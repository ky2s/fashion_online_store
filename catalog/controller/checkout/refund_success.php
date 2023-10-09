<?php
class ControllerCheckoutRefundSuccess extends Controller {
	public function index() {
		$this->load->language('checkout/refund');

		$this->document->setTitle($this->language->get('heading_title'));
		$data['heading_title'] =  $this->language->get('heading_title');

		$data['contact_email'] = $this->config->get('config_email_contact');
		$data['continue'] = $this->url->link('common/home');
		$data['previous'] = $this->url->link('checkout/refund');

		//refund data
		$data['account_name'] = $this->session->data['refund_data']['account_name'];
		$data['account_bank'] = $this->session->data['refund_data']['account_bank'];
		$data['account_number'] = $this->session->data['refund_data']['account_number'];
		unset($this->session->data['refund_data']);

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if($data['account_bank']){
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/refund_success.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/refund_success.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/common/refund_success.tpl', $data));
			}
		}
	}
}