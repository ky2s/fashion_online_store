<?php  
class ControllerModuleManufacturerFilter extends Controller {
	public function index($setting) {
		$this->language->load('module/manufacturerfilter');
		
    	$data['heading_title'] = $this->language->get('heading_title');
    	
    	$this->load->model('catalog/manufacturer');

    	if ($this->request->get['route'] == 'product/category') {
    		$parts = explode('_', (string)$this->request->get['path']);
			$category_id = (int)array_pop($parts);
			$data['category_id'] = $category_id;
    	} elseif ($this->request->get['route'] == 'product/search') {    		
    		if (isset($this->request->get['category_id'])) {
    			$category_id = $this->request->get['category_id'];
    		} else {
    			$category_id = 0;
    		}
    	}

    	if(isset($this->session->data['manufacturers'])) {
    		$data['manufacturersSession'] = $this->session->data['manufacturers'];
    	} else {
    		$data['manufacturersSession'] = '';
    	}

    	$data['manufacturers'] = array();

		$results = $this->model_catalog_manufacturer->getManufacturersWithCount($category_id);		
		foreach ($results as $result) {
			$data['manufacturers'][] = array('name' => $result['name'], "id" => $result['manufacturer_id'], "count" => $result['c']);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/manufacturer_filter.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/manufacturer_filter.tpl', $data);
		} else {
			return $this->load->view('default/template/module/manufacturerfilter.tpl', $data);
		}
	}
}
?>