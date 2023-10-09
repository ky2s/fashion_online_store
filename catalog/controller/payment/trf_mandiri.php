<?php
class ControllerPaymentTrfMandiri extends Controller {
	public function index() {
		$this->language->load('payment/trf_mandiri');
		
		$data['text_instruction'] 	= NULL;
    	$data['text_accountno'] 	= NULL;
		$data['text_accountname'] 	= NULL;
		$data['text_detail1'] 		= NULL;
		$data['text_detail2'] 		= sprintf($this->language->get('text_detail2'),  $this->config->get('config_url')."payment-confirmation");
		$data['button_confirm'] 	= $this->language->get('button_confirm');
		$data['text_logo'] 			= NULL;
		$data['accountno'] 			= NULL;
		$data['accountname'] 		= NULL;

//		$data['accountno'] 			= $this->config->get('trf_mandiri_accountno');
//		$data['accountname'] 		= $this->config->get('trf_mandiri_accountname');
		$data['continue'] 	 		= $this->url->link('checkout/success');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/trf_mandiri.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/trf_mandiri.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/trf_mandiri.tpl', $data);
		} 
	}
	
	public function confirm() {
		if ($this->session->data['payment_method']['code'] == 'trf_mandiri') {

			$this->language->load('payment/trf_mandiri');

			//save to session 
			$this->session->data['payment_detail1'] = $this->language->get('text_detail1');
			$this->session->data['payment_logo'] = $this->language->get('text_logo');
			$this->session->data['payment_number'] = $this->config->get('trf_mandiri_accountno');
			$this->session->data['payment_name'] = $this->config->get('trf_mandiri_accountname');

			$this->load->model('checkout/order');
			
			$comment  = $this->language->get('text_title') . "\n" . $this->language->get('text_detail1') . "\n\n";
			$comment .= $this->language->get('text_accountno') . $this->config->get('trf_mandiri_accountno') . "\n";
			$comment .= $this->language->get('text_accountname') . $this->config->get('trf_mandiri_accountname') . "\n\n";
			$comment .= $this->language->get('text_detail2');
			
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('trf_mandiri_order_status_id'), $comment, true, $this->session->data['tracking']);
		}		
	}
}
?>