<?php
class ControllerInformationPaymentConfirmationSuccess extends Controller {

	public function index() {

		$this->load->language('information/payment_confirmation_success');

		$this->document->setTitle($this->language->get('heading_title'));
		$data['heading_title'] =  $this->language->get('heading_title');

		if ($this->request->server['HTTPS']) {
			$base = HTTPS_SERVER;
		} else {
			$base = HTTP_SERVER;
		}
		$data['continue'] =  $base;

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = NULL;
		//$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/payment_confirmation_success.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/payment_confirmation_success.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/information/payment_confirmation_success.tpl', $data));
		}
		
	}
}