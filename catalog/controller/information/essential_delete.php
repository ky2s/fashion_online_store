<?php
class ControllerInformationEssential extends Controller {

	public function index() {
		/*$this->load->language('information/information');

		$this->load->model('catalog/information');*/

		//$essential_id = 13; //13: ID Essential di table information
		//$data = $this->model_catalog_information->getInformation($essential_id);
		//$data['description'] = $result['description'];
		//pre($essential);
		/*if($essential['status'])
		{
            $data['title'] = $essential['title'];
            $data['head'] = $essential['head'];
            $data['description'] = $essential['description'];
		}*/
		$data = "ok";
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/essential.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/information/essential.tpl', $data);
		} else {
			return $this->load->view('default/template/information/essential.tpl', $data);
		}
	}
}