<?php
class ControllerCommonInfluencer extends Controller {
	
	public function index() {
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/influencer.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/influencer.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/influencer.tpl', $data));
		}
	}
}