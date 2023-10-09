<?php
class ControllerCheckoutReferral extends Controller {

	public function index() {
			//pre($this->config);
		if ($this->config->get('credit_status')) {
			
			$this->load->language('checkout/coupon');

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_loading'] = $this->language->get('text_loading');

			$data['entry_coupon'] = $this->language->get('entry_coupon');

			$data['button_coupon'] = $this->language->get('button_coupon');

			if (isset($this->session->data['referral_point'])) {
				$data['referral_point'] = $this->session->data['referral_point'];
			} else {
				$data['referral_point'] = '';
			}

			if (isset($this->request->get['redirect']) && !empty($this->request->get['redirect'])) {
				$data['redirect'] = $this->request->get['redirect'];
			} else {
				$data['redirect'] = $this->url->link('checkout/cart');
			}

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/referral.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/checkout/referral.tpl', $data);
			} else {
				return $this->load->view('default/template/checkout/referral.tpl', $data);
			}
		}
	}

	public function referral() {
		$this->load->language('checkout/coupon');

		$json = array();

		//$json['dat'] = $this->cart->getSubTotal();
		if (empty($this->request->post['referral_point'])) {
			$json['error'] = ' Please enter a referral point!';
		}
		elseif ($this->request->post['referral_point'] > $this->customer->getBalance()) {
		 	$json['error'] = 'Exceeds the limit your point!';
		} 
		elseif($this->request->post['referral_point'] > $this->cart->getSubTotal()){
			$json['error'] = 'Exceeds the limit your order!';	
		}
		elseif ($this->config->get('credit_status')) {

			//save jumlah point yg di input ke session
			$this->session->data['referral_point'] = $this->request->post['referral_point'];

			$this->session->data['success'] = "Success: Your referral point has been applied!";


			if(!empty($this->request->post['is_checkout'])){
				$json['redirect'] = $this->url->link('checkout/checkout');
			}else{				
				$json['redirect'] = $this->url->link('checkout/cart');
			}

		} else {
			$json['error'] = $this->language->get('error_coupon');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}