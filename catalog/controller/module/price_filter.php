<?php  
class ControllerModulePriceFilter extends Controller {
	public function index($setting) {
		$this->language->load('module/price_filter');
		
    	$data['heading_title'] = $this->language->get('heading_title');
    	
    	$this->document->addScript('catalog/view/javascript/nouislider/jquery.nouislider.all.min.js');
    	$this->document->addStyle('catalog/view/javascript/nouislider/jquery.nouislider.css');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

    	$this->load->model('catalog/product');
    	$category_id = end($parts);
    	$filter['filter_category_id'] = $category_id;

		$pricelist = array();
		$results = $this->model_catalog_product->getProducts($filter);		
		if($results) {			
			foreach ($results as $key => $value) {			
				$pricelist[] = $value['price'];							
			}

			$data['currencySymbol'] = $this->currency->getSymbolLeft();
			$data['lowestPrice'] 	= (int)min($pricelist);
			$data['highestPrice'] 	= (int)max($pricelist);	

			if (isset($this->session->data['lower'])&&isset($this->session->data['higher'])) {
				$data['datalower']  = $this->session->data['lower'];
			    $data['datahigher'] = $this->session->data['higher'];      
			} else { 
			    $data['datalower']  = $data['lowestPrice'];
			    $data['datahigher'] = $data['highestPrice'];              
			}
			
			$data['datalowercategory']   = $data['lowestPrice'];
			$data['datahighercategory']  = $data['highestPrice'];	

		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/price_filter.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/price_filter.tpl', $data);
		} else {
			return $this->load->view('default/template/module/price_filter.tpl', $data);
		}
	}
}
?>