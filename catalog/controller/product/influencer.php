<?php
class ControllerProductInfluencer extends Controller {
	
	public function index() {
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/influencer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/influencer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/influencer.tpl', $data);
		}
	}
}