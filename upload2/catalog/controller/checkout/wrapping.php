<?php
class ControllerCheckoutWrapping extends Controller {
	public function index() {
		$this->load->language('checkout/wrapping');

		$data['button_continue'] = $this->language->get('button_continue');
		
		$data['column_image'] 	 = $this->language->get('column_image');
		$data['column_name'] 		 = $this->language->get('column_name');
		$data['column_quantity'] = $this->language->get('column_quantity');
		$data['column_option'] 	 = $this->language->get('column_option');

		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_total'] 	 = $this->language->get('text_total');
		$data['text_select'] 	 = $this->language->get('text_select');
		$data['text_add_wrap'] 	 = $this->language->get('text_add_wrap');		
		$data['text_select_to_wrap'] 	 = $this->language->get('text_select_to_wrap');				
		$data['text_no_data'] 	 = $this->language->get('text_no_data');
		$data['text_welcome'] 	 = $this->language->get('text_welcome');
		$data['button_remove'] 	 = $this->language->get('button_remove');
		
		$data['entry_comment'] 	 = $this->language->get('entry_comment');		
		$data['error_product'] 	 = $this->language->get('error_product');				
		$data['error_quantity'] 	 = $this->language->get('error_quantity');				

		$this->load->model('tool/image');
		
		$wrapping_options = array();
		foreach ($this->config->get('wrapping_option') as $key => $value) {
			
			if ($value['image']) {
				$image = $value['image'];
			} else {
				$image = 'placeholder.png';				
			}

			$wrapping_options[] = array(
				'image' 			=> $this->model_tool_image->resize($image, $this->config->get('wrapping_width'), $this->config->get('wrapping_height')),
				'largeImage'	=> $this->model_tool_image->resize($image, $this->config->get('wrapping_width_preview'), $this->config->get('wrapping_height_preview')),
				'name'  		  => $value['name'],
				'price_label' => $this->currency->format($value['price']),
				'price' 			=> $value['price'],
				'order' 			=> $value['order'],
				'id' 					=> $value['id']
				);
		}

		usort($wrapping_options, function($a, $b) {
		    return $a['order'] - $b['order'];
		});

		$data['wrapping_options'] = $wrapping_options;
				
		if(isset($this->session->data['wrap_method']['wrap_comment'])) {
			$data['comment'] = $this->session->data['wrap_method']['wrap_comment'];
		} else {
			$data['comment'] = '';
		}

		if(isset($this->session->data['wrap_method']['wrap_id'])) {
			$data['id'] = $this->session->data['wrap_method']['wrap_id'];
		} else {
			$data['id'] = '';
		}
	
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/wrapping.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/wrapping.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/wrapping.tpl', $data));
		}
	}

	public function save() {
		$this->load->language('checkout/checkout');

		$json = array();

		// Validate if customer is logged in.
		if (!$this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$json['redirect'] = $this->url->link('checkout/cart');
		}

		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total) {
				$json['redirect'] = $this->url->link('checkout/cart');

				break;
			}
		}

		if (!$json) {
	
			$wrapp_session = array();

			foreach ($this->config->get('wrapping_option') as $key => $value) {			
				if($this->request->post['radioOption'] == $value['id']) {
					$wrapp_session['wrap_id']  = $value['id'];
					$wrapp_session['wrap_name']  = $value['name'];
					$wrapp_session['wrap_price'] = $value['price'];
					$wrapp_session['wrap_image'] = $value['image'];					
					$wrapp_session['wrap_comment'] = $this->request->post['comment'];
				}
			}

			$this->session->data['wrap_method'] = $wrapp_session;			
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}