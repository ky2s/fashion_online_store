<?php
class ControllerPaymentTrfBni extends Controller {
	public function index() {
		$this->language->load('payment/trf_bni');
		
		$data['text_instruction'] 	= $this->language->get('text_instruction');
    	$data['text_accountno'] 	= $this->language->get('text_accountno');
		$data['text_accountname'] 	= $this->language->get('text_accountname');
		$data['text_detail1'] 		= $this->language->get('text_detail1');
		$data['text_detail2'] 		= $this->language->get('text_detail2');
		$data['text_logo'] 			= $this->language->get('text_logo');
		$data['button_confirm'] 	= $this->language->get('button_confirm');
		$data['accountno'] 			= $this->config->get('trf_bni_accountno');
		$data['accountname'] 		= $this->config->get('trf_bni_accountname');
		$data['continue'] 	 		= $this->url->link('checkout/success');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/trf_bni.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/trf_bni.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/trf_bni.tpl', $data);
		} 
	}
	
	public function confirm() {
		if ($this->session->data['payment_method']['code'] == 'trf_bni') {
			$this->language->load('payment/trf_bni');
		
			$this->load->model('checkout/order');
			
			$comment  = $this->language->get('text_title') . "\n" . $this->language->get('text_detail1') . "\n\n";
			$comment .= $this->language->get('text_accountno') . $this->config->get('trf_bni_accountno') . "\n";
			$comment .= $this->language->get('text_accountname') . $this->config->get('trf_bni_accountname') . "\n\n";
			$comment .= $this->language->get('text_detail2');
			
			$this->model_checkout_order->addOrderHistory($this->session->data['order_id'], $this->config->get('trf_bni_order_status_id'), $comment, true);
		}		
	}
}
?>