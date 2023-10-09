<?php
class ControllerCheckoutCheckout extends Controller {
	public function index() {
		
		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$this->response->redirect($this->url->link('checkout/cart'));
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
				$this->response->redirect($this->url->link('checkout/cart'));
			}
		}

		$this->load->language('checkout/checkout');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

		// Required by klarna
		if ($this->config->get('klarna_account') || $this->config->get('klarna_invoice')) {
			$this->document->addScript('http://cdn.klarna.com/public/kitt/toc/v1.0/js/klarna.terms.min.js');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_cart'),
			'href' => $this->url->link('checkout/cart')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('checkout/checkout', '', 'SSL')
		);

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_checkout_option'] = $this->language->get('text_checkout_option');
		$data['text_checkout_account'] = $this->language->get('text_checkout_account');
		$data['text_checkout_payment_address'] = $this->language->get('text_checkout_payment_address');
		$data['text_checkout_shipping_address'] = $this->language->get('text_checkout_shipping_address');
		$data['text_checkout_shipping_method'] = $this->language->get('text_checkout_shipping_method');
		$data['text_checkout_gift_wrapping'] = $this->language->get('text_checkout_gift_wrapping');
		$data['text_checkout_gift_card'] = $this->language->get('text_checkout_gift_card');

		if (isset($this->session->data['error'])) {
			$data['error_warning'] = $this->session->data['error'];
			unset($this->session->data['error']);
		} else {
			$data['error_warning'] = '';
		}

		$data['logged'] = $this->customer->isLogged();

		if (isset($this->session->data['account'])) {
			$data['account'] = $this->session->data['account'];
		} else {
			$data['account'] = '';
		}

		$totalExtention = array('gift_card', 'wrapping');
		$data['extraTotal'] = array();
		foreach ($totalExtention as $value) {
			if ($this->config->get($value . '_status')) {
				$data['extraTotal'][$value] = true;
			} else {
				$data['extraTotal'][$value] = false;
			}	
		}

		if( $data['extraTotal']['gift_card'] && !$data['extraTotal']['wrapping'] ) {
			$data['text_checkout_gift_card'] = $this->language->get('text_checkout_gift_cardB');
		}

		if( $data['extraTotal']['gift_card'] && $data['extraTotal']['wrapping'] ) {

			$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method3');
			$data['text_checkout_confirm']			  = $this->language->get('text_checkout_confirm3');

		} elseif ( $data['extraTotal']['gift_card'] || $data['extraTotal']['wrapping'] ) {
			
			$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method2');
			$data['text_checkout_confirm']        = $this->language->get('text_checkout_confirm2');

		} else {
			
			$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');
			$data['text_checkout_confirm']        = $this->language->get('text_checkout_confirm');

		}
		
		//SUBTOTAL&TOTAL
		$this->load->model('extension/extension');

		$total_data = array();
		$total = 0;
		$taxes = $this->cart->getTaxes();

		// Display prices
		if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
			$sort_order = array();

			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}

			
			$sort_order = array();
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
		
			array_multisort($sort_order, SORT_ASC, $total_data);
		}

		foreach ($total_data as $result) {
			
			if($result['code'] == 'sub_total'){
				$data['totals'][] = array(
					'code' => 'sub_total',
					'title' => $result['title'],
					'value'  => $this->currency->format($result['value']),
				);	
			}

			if($result['code'] == 'coupon'){
				$part_coupon = str_replace('Coupon', '', $result['title']);
				$data['totals'][] = array(
					'code' => 'coupon',
					'title' => $part_coupon,
					'value'  => $this->currency->format($result['value']),
				);	
			}

			if($result['code'] == 'shipping'){
				$part = preg_split('/[\s,]+/', $result['title'], 3);
				$data['totals'][] = array(
					'code' => 'shipping',
					'title' => $part[0]. ' ' . $part[1],
					'value'  => $this->currency->format($result['value']),
				);	
			}

			if($result['code'] == 'total'){
				$data['totals'][] = array(
					'code' => 'total',
					'title' => $result['title'],
					'value'  => $this->currency->format($result['value']),
				);	
			}
			
		}

		$data['is_coupon'] = $this->session->data['coupon'];
		$data['success'] =$this->session->data['success'];

		$data['store_id'] = $this->config->get('config_store_id');
		$data['shipping_required'] = $this->cart->hasShipping();

		$data['coupon'] = $this->load->controller('checkout/coupon');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/checkout.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/checkout.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/checkout.tpl', $data));
		}
	}

	public function country() {
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id'        => $country_info['country_id'],
				'name'              => $country_info['name'],
				'iso_code_2'        => $country_info['iso_code_2'],
				'iso_code_3'        => $country_info['iso_code_3'],
				'address_format'    => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone'              => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status'            => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function customfield() {
		$json = array();

		$this->load->model('account/custom_field');

		// Customer Group
		if (isset($this->request->get['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->get['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->get['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

		foreach ($custom_fields as $custom_field) {
			$json[] = array(
				'custom_field_id' => $custom_field['custom_field_id'],
				'required'        => $custom_field['required']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}