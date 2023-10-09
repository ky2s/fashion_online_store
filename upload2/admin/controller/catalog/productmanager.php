<?php
class ControllerCatalogProductManager extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/productmanager');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');
		$this->load->model('setting/setting');
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/productmanager', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['add'] = $this->url->link('catalog/product/add', 'token=' . $this->session->data['token'], 'SSL');
		$data['copy'] = $this->url->link('catalog/productmanager/copy', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete'] = $this->url->link('catalog/productmanager/delete', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_list'] = $this->language->get('text_list');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_model'] = $this->language->get('entry_model');
		$data['entry_price'] = $this->language->get('entry_price');
		$data['entry_quantity'] = $this->language->get('entry_quantity');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_limit_placeholder'] = $this->language->get('entry_limit_placeholder');

		$data['button_copy'] = $this->language->get('button_copy');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');
		$data['button_togglecolumns'] = $this->language->get('button_togglecolumns');
		
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');

		$this->load->model('localisation/tax_class');
		$data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();
		$data['tax_classes'] = array_merge(array(array('tax_class_id' => 0, 'title' => '--- None ---', 'sort_order' => 0)), $data['tax_classes']);

		$this->load->model('localisation/stock_status');
		$data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();

		$this->load->model('localisation/weight_class');
		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();
		
		$this->load->model('catalog/manufacturer');
		$data['manufacturers'] = $this->model_catalog_manufacturer->getManufacturers();
		$data['manufacturers'] = array_merge(array(array('manufacturer_id' => 0, 'name' => '--- None ---', 'sort_order' => 0)), $data['manufacturers']);
		
		$data['excelport_link'] = $this->url->link('module/excelport', 'token='.$this->session->data['token'], 'SSL');
		$excelportConfig = $this->model_setting_setting->getSetting('ExcelPort');
		$data['excelport_error'] = $this->language->get('excelport_error');
		$data['text_export'] = $this->language->get('text_export');
		$data['excelport'] = false;
		if (!empty($excelportConfig)) {
			$data['excelport'] = true;
		}
		
		$data['asterisk_warning'] 		= $this->language->get('asterisk_warning');
		$data['confirm_bulk'] 			= $this->language->get('confirm_bulk');
		$data['bulk_image_result'] 		= $this->language->get('bulk_image_result');
		$data['modal_close'] 			= $this->language->get('modal_close');
		$data['bulk_modal_heading'] 	= $this->language->get('bulk_modal_heading');
		$data['bulk_modal_text'] 		= $this->language->get('bulk_modal_text');
		$data['showhide_filter']		= $this->language->get('showhide_filter');
		$data['bulk_zip_error']			= $this->language->get('bulk_zip_error');
		$data['upload_file']			= $this->language->get('upload_file');
		$data['bulk_image_help_all']	= $this->language->get('bulk_image_help_all');
		$data['bulk_image_structured']  = $this->language->get('bulk_image_structured');
		$data['bulk_image_structured2'] = $this->language->get('bulk_image_structured2');
		$data['bulk_atleast2'] 			= $this->language->get('bulk_atleast2');

		$data['filter_name'] = null;
		$data['filter_model'] = null;
		$data['filter_price'] = null;
		$data['filter_quantity'] = null;
		$data['filter_status'] = null;
		$data['filter_limit'] = null;
		
		$data['tableData'] = $this->getTableData('');
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('catalog/productmanager.tpl', $data));
	}
	
	public function getTableData($url = '') {
		$tableData = array(
			'product_id' => array( 
				'name' => 'ID', 
				'sort' => 'p.product_id', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.product_id' . $url, 'SSL'),
				'bulk' => false),
			'image' => array( 
				'name' => $this->language->get('column_image'), 
				'sort' => '', 
				'url' => '',
				'bulk' => false),
			'image_filename' => array( 
				'name' => $this->language->get('column_image_filename'), 
				'sort' => '', 
				'url' => '',
				'bulk' => false),		
			'name' => array( 
				'name' => $this->language->get('column_name'), 
				'sort' => 'pd.name', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL'),
				'bulk' => true),
			'model' => array( 
				'name' => $this->language->get('column_model'), 
				'sort' => 'p.model', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.model' . $url, 'SSL'),
				'bulk' => true),
			'manufacturer' => array(
				'name' => $this->language->get('entry_manufacturer'), 
				'sort' => 'm.name', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=m.name' . $url, 'SSL'),
				'bulk' => true),
			'sku' => array ( 
				'name' => $this->language->get('entry_sku'), 
				'sort' => 'p.sku', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.sku' . $url, 'SSL'),
				'bulk' => true),
			'upc' => array ( 
				'name' => $this->language->get('entry_upc'), 
				'sort' => 'p.upc', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.upc' . $url, 'SSL'),
				'bulk' => true),
			'ean' => array ( 
				'name' => $this->language->get('entry_ean'), 
				'sort' => 'p.ean', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.ean' . $url, 'SSL'),
				'bulk' => true),
			'jan' => array ( 
				'name' => $this->language->get('entry_jan'),
				'sort' => 'p.jan', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.jan' . $url, 'SSL'),
				'bulk' => true),
			'isbn' => array ( 
				'name' => $this->language->get('entry_isbn'),
				'sort' => 'p.isbn', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.isbn' . $url, 'SSL'),
				'bulk' => true),
			'mpn' => array ( 
				'name' => $this->language->get('entry_mpn'),
				'sort' => 'p.mpn', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.mpn' . $url, 'SSL'),
				'bulk' => true),	
			'location' => array ( 
				'name' => $this->language->get('entry_location'), 
				'sort' => 'p.location', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.location' . $url, 'SSL'),
				'bulk' => true),
			'stock_status' => array ( 
				'name' => $this->language->get('entry_stock_status'), 
				'sort' => 's.name', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=s.name' . $url, 'SSL'),
				'bulk' => true),
			'tax_class' => array ( 
				'name' => $this->language->get('entry_tax_class'), 
				'sort' => 't.title', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=t.title' . $url, 'SSL'),
				'bulk' => true),
			'weight_class' => array ( 
				'name' => $this->language->get('entry_weight_class'), 
				'sort' => 'w.title', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=w.title' . $url, 'SSL'),
				'bulk' => true),
			'viewed' => array ( 
				'name' => $this->language->get('entry_viewed'), 
				'sort' => 'p.viewed', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.viewed' . $url, 'SSL'),
				'bulk' => true),				
			'points' => array ( 
				'name' => $this->language->get('entry_reward'), 
				'sort' => 'p.points', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.points' . $url, 'SSL'),
				'bulk' => true),
			'shipping' => array ( 
				'name' => $this->language->get('entry_shipping'), 
				'sort' => 'p.shipping', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.shipping' . $url, 'SSL'),
				'bulk' => true),
			'price' => array ( 
				'name' => $this->language->get('column_price'), 
				'sort' => 'p.price', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.price' . $url, 'SSL'),
				'bulk' => true),
			'quantity' => array ( 
				'name' => $this->language->get('column_quantity'), 
				'sort' => 'p.quantity', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.quantity' . $url, 'SSL'),
				'bulk' => true),
			'minimum' => array (
				'name' => $this->language->get('entry_minimum'), 
				'sort' => 'p.minimum', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.minimum' . $url, 'SSL'),
				'bulk' => true),
			'subtract' => array (
				'name' => $this->language->get('entry_subtract'), 
				'sort' => 'p.subtract', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.subtract' . $url, 'SSL'),
				'bulk' => true),		
			'status' => array ( 
				'name' => $this->language->get('column_status'), 
				'sort' => 'p.status', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.status' . $url, 'SSL'),
				'bulk' => true),
			'date_available' => array (
				'name' => $this->language->get('entry_date_available'),
				'sort' => 'p.date_available', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.date_available' . $url, 'SSL'),
				'bulk' => true),
			'date_added' => array ( 
				'name' => $this->language->get('date_added'), 
				'sort' => 'p.date_added', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.date_added' . $url, 'SSL'),
				'bulk' => true),				
			'date_modified' => array ( 
				'name' => $this->language->get('date_modified'), 
				'sort' => 'p.date_modified', 
				'url' => $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.date_modified' . $url, 'SSL'),
				'bulk' => true)			
		);
		
		return $tableData;
	}

	public function getList() {
		$this->load->language('catalog/productmanager');
		$this->load->model('catalog/product');
		
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['filter_model'])) {
			$filter_model = $this->request->get['filter_model'];
		} else {
			$filter_model = null;
		}

		if (isset($this->request->get['filter_price'])) {
			$filter_price = $this->request->get['filter_price'];
		} else {
			$filter_price = null;
		}

		if (isset($this->request->get['filter_quantity'])) {
			$filter_quantity = $this->request->get['filter_quantity'];
		} else {
			$filter_quantity = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		
		if (isset($this->request->get['filter_limit'])) {
			$filter_limit = $this->request->get['filter_limit'];
		} else {
			$filter_limit = 10;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}

		if (isset($this->request->get['filter_quantity'])) {
			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_limit'])) {
			$url .= '&filter_limit=' . $this->request->get['filter_limit'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['products'] = array();

		$filter_data = array(
			'filter_name'	  => $filter_name,
			'filter_model'	  => $filter_model,
			'filter_price'	  => $filter_price,
			'filter_quantity' => $filter_quantity,
			'filter_status'   => $filter_status,
			'sort'            => $sort,
			'order'           => $order,
			'start'           => ($page - 1) * $filter_limit,
			'limit'           =>  $filter_limit
		);

		$this->load->model('tool/image');

		$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

		$results = $this->getProducts($filter_data);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 40, 40);
			}

			$special = false;

			$product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);

			foreach ($product_specials  as $product_special) {
				if (($product_special['date_start'] == '0000-00-00' || strtotime($product_special['date_start']) < time()) && ($product_special['date_end'] == '0000-00-00' || strtotime($product_special['date_end']) > time())) {
					$special = $product_special['price'];

					break;
				}
			}

			$data['products'][] = array(
				'product_id' 		=> $result['product_id'],
				'image'      		=> $image,
				'name'       		=> $result['name'],
				'model'      		=> $result['model'],
				'price'					=> format_me($result['price']),
				//'price'      => $this->currency->format($result['price'], $this->config->get('config_currency')),
				'special'    		=> $special,
				'quantity'   		=> $result['quantity'],
				'status'     		=> ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'edit'       		=> $this->url->link('catalog/product/edit', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'] . $url, 'SSL'),
				'sku'		 		=> $result['sku'],
				'upc'		 		=> $result['upc'],
				'ean'		 		=> $result['ean'],
				'jan'		 		=> $result['jan'],
				'isbn' 	     		=> $result['isbn'],
				'mpn'       		=> $result['mpn'],
				'location'	 		=> $result['location'],
				'tax_class'  		=> $result['tax_class'],
				'stock_status' 		=> $result['stock_status'],
				'weight_class' 		=> $result['weight_class'],
				'manufacturer' 		=> $result['manufacturer'],
				'minimum'	 		=> $result['minimum'],
				'shipping'			=> ($result['shipping']== 1) ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'points'	 		=> $result['points'],
				'viewed'	 		=> $result['viewed'],				
				'image_filename' 	=> $result['image'],
				'weight'	 		=> $result['weight'],
				'subtract'  		=> ($result['subtract']== 1) ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'status'     		=> ($result['status']== 1) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'shipping_code' 	=> $result['shipping'],
				'subtract_code' 	=> $result['subtract'],
				'status_code' 		=> $result['status'],
				'tax_class_code'	=> $result['tax_class_id'],
				'stock_status_code'	=> $result['stock_status_id'],
				'weight_class_code'	=> $result['weight_class_id'],
				'manufacturer_code'	=> $result['manufacturer_id'],
				'date_added' 		=> $result['date_added'],
				'date_available' 	=> $result['date_available'],
				'date_modified' 	=> $result['date_modified']
			);
		}

		$data['column_image'] = $this->language->get('column_image');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_model'] = $this->language->get('column_model');
		$data['column_price'] = $this->language->get('column_price');
		$data['column_quantity'] = $this->language->get('column_quantity');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_action'] = $this->language->get('column_action');
		
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		
		$data['bulk_edit'] = $this->language->get('bulk_edit');

		$data['button_edit'] = $this->language->get('button_edit');
		$data['text_no_results'] = $this->language->get('text_no_results');

		$data['delete'] = $this->url->link('catalog/productmanager/delete', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/tax_class');
		$data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();
		$data['tax_class_default'] = 0;
		
		$this->load->model('localisation/stock_status');
		$data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();
		$data['stock_status_default'] = 0;

		$this->load->model('localisation/weight_class');
		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();
		$data['weight_class_default'] = $this->config->get('config_weight_class_id');
		
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 40, 40);
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}

		if (isset($this->request->get['filter_quantity'])) {
			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_limit'])) {
			$url .= '&filter_limit=' . $this->request->get['filter_limit'];
		}
		
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_order'] = $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url, 'SSL');
		
		$data['tableData'] = $this->getTableData($url);

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_model'])) {
			$url .= '&filter_model=' . urlencode(html_entity_decode($this->request->get['filter_model'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_price'])) {
			$url .= '&filter_price=' . $this->request->get['filter_price'];
		}

		if (isset($this->request->get['filter_quantity'])) {
			$url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_limit'])) {
			$url .= '&filter_limit=' . $this->request->get['filter_limit'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $product_total;
		$pagination->page = $page;
		$pagination->limit = $filter_limit;
		$pagination->url = $this->url->link('catalog/productmanager/getList', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $filter_limit) + 1 : 0, ((($page - 1) * $filter_limit) > ($product_total - $filter_limit)) ? $product_total : ((($page - 1) * $filter_limit) + $filter_limit), $product_total, ceil($product_total / $filter_limit));

		$data['filter_name'] = $filter_name;
		$data['filter_model'] = $filter_model;
		$data['filter_price'] = $filter_price;
		$data['filter_quantity'] = $filter_quantity;
		$data['filter_status'] = $filter_status;
		$data['filter_limit'] = $filter_limit;

		$data['sort'] = $sort;
		$data['order'] = $order;

		$this->response->setOutput($this->load->view('catalog/productmanager-list.tpl', $data));	
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model'])) {
			$this->load->model('catalog/product');
			$this->load->model('catalog/option');

			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}

			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 5;
			}

			$filter_data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);

			$results = $this->getProducts($filter_data);

			foreach ($results as $result) {
				$option_data = array();

				$product_options = $this->model_catalog_product->getProductOptions($result['product_id']);

				foreach ($product_options as $product_option) {
					$option_info = $this->model_catalog_option->getOption($product_option['option_id']);

					if ($option_info) {
						$product_option_value_data = array();

						foreach ($product_option['product_option_value'] as $product_option_value) {
							$option_value_info = $this->model_catalog_option->getOptionValue($product_option_value['option_value_id']);

							if ($option_value_info) {
								$product_option_value_data[] = array(
									'product_option_value_id' => $product_option_value['product_option_value_id'],
									'option_value_id'         => $product_option_value['option_value_id'],
									'name'                    => $option_value_info['name'],
									'price'                   => (float)$product_option_value['price'] ? $this->currency->format($product_option_value['price'], $this->config->get('config_currency')) : false,
									'price_prefix'            => $product_option_value['price_prefix']
								);
							}
						}

						$option_data[] = array(
							'product_option_id'    => $product_option['product_option_id'],
							'product_option_value' => $product_option_value_data,
							'option_id'            => $product_option['option_id'],
							'name'                 => $option_info['name'],
							'type'                 => $option_info['type'],
							'value'                => $product_option['value'],
							'required'             => $product_option['required']
						);
					}
				}

				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'model'      => $result['model'],
					'option'     => $option_data,
					'price'      => $result['price']
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function delete() {
		$this->load->language('catalog/productmanager');
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/product');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $product_id) {
				$this->model_catalog_product->deleteProduct($product_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('catalog/productmanager', 'token=' . $this->session->data['token'], 'SSL'));
		}
	}
	
	public function copy() {
		$this->load->language('catalog/productmanager');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/product');

		if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $product_id) {
				$this->model_catalog_product->copyProduct($product_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('catalog/productmanager', 'token=' . $this->session->data['token'], 'SSL'));
		}

	}
	
	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/product')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateCopy() {
		if (!$this->user->hasPermission('modify', 'catalog/product')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
	public function getProducts($data = array()) {
		$sql = "SELECT
					p.*, pd.name as name, m.name as manufacturer, w.title as weight_class, s.name as stock_status, t.title as tax_class 
				FROM 
					" . DB_PREFIX . "product p 
					LEFT JOIN " . DB_PREFIX . "weight_class_description w ON (p.weight_class_id = w.weight_class_id)
					LEFT JOIN " . DB_PREFIX . "stock_status s ON (p.stock_status_id = s.stock_status_id)
					LEFT JOIN " . DB_PREFIX . "tax_class t ON (p.tax_class_id = t.tax_class_id)
					LEFT JOIN " . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
					LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) 
				WHERE 
					pd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		if (!empty($data['filter_name'])) {
			$sql .= " AND pd.name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_model'])) {
			$sql .= " AND p.model LIKE '" . $this->db->escape($data['filter_model']) . "%'";
		}

		if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
			$sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
		}

		if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
			$sql .= " AND p.quantity = '" . (int)$data['filter_quantity'] . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND p.status = '" . (int)$data['filter_status'] . "'";
		}
		
		$sql .= " GROUP BY p.product_id";

		if (isset($data['sort'])) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY pd.name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function updateproduct() {
		$json = array();
		if (isset($this->request->post)) {
			$field 				= $this->request->post['pdata'];
			$value 				= $this->request->post['pvalue'];
			$product_id   		= $this->request->post['pid'];
			$language_id 		= $this->config->get('config_language_id');
			
			if ($field == 'name') {
				$this->db->query("UPDATE " . DB_PREFIX . "product_description SET name = '" . $this->db->escape($value) . "' WHERE product_id = '" . (int)$product_id . "' AND language_id = '" . (int)$language_id . "'");
			} else if ($field == 'weight_class') {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET weight_class_id = '" . $this->db->escape($value) . "' WHERE product_id = '" . (int)$product_id . "'");		
			} else if ($field == 'tax_class') {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET tax_class_id = '" . $this->db->escape($value) . "' WHERE product_id = '" . (int)$product_id . "'");
			} else if ($field == 'manufacturer') {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET manufacturer_id = '" . $this->db->escape($value) . "' WHERE product_id = '" . (int)$product_id . "'");
			} else if ($field == 'stock_status') {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET stock_status_id = '" . $this->db->escape($value) . "' WHERE product_id = '" . (int)$product_id . "'");			
			} else {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET " . $field . " = '" . $this->db->escape($value) . "', date_modified = NOW() WHERE product_id = '" . (int)$product_id . "'");
			}
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$json['product'] = $this->model_catalog_product->getProduct($product_id);
			if (is_file(DIR_IMAGE . $json['product']['image'])) {
				$json['product_image'] = $this->model_tool_image->resize($json['product']['image'], 40, 40);
			} else {
				$json['product_image'] = $this->model_tool_image->resize('no_image.png', 40, 40);
			}
			$json['field'] = $field;
			$json['value'] = $value;
			$json['product_id'] = $product_id;
			$json['success'] = 'success';
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function updateproductbulk() {
		$json = array();
		$this->load->model('catalog/product');
		if (isset($this->request->post)) {
			$field 				= $this->request->post['pdata'];
			$value 				= $this->request->post['pvalue'];
			$product_id   		= $this->request->post['pid'];
			$language_id 		= $this->config->get('config_language_id');
			$product_id = explode(",", $product_id);
			$json['products']	= array();
			foreach ($product_id as $pid) {
				$pid_info = $this->model_catalog_product->getProduct($pid);
				if ($field!='weight_class' && $field!='tax_class' && $field!='manufacturer' && $field!='stock_status') {
					$new_value = str_replace('%value%', $pid_info[$field], $value);
				} else {
					$new_value = $value;	
				}
				if ($field == 'name') {
					$this->db->query("UPDATE " . DB_PREFIX . "product_description SET name = '" . $this->db->escape($new_value) . "' WHERE product_id = '" . (int)$pid . "' AND language_id = '" . (int)$language_id . "'");
				} else if ($field == 'weight_class') {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET weight_class_id = '" . $this->db->escape($new_value) . "' WHERE product_id = '" . (int)$pid . "'");		
				} else if ($field == 'tax_class') {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET tax_class_id = '" . $this->db->escape($new_value) . "' WHERE product_id = '" . (int)$pid . "'");
				} else if ($field == 'manufacturer') {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET manufacturer_id = '" . $this->db->escape($new_value) . "' WHERE product_id = '" . (int)$pid . "'");
				} else if ($field == 'stock_status') {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET stock_status_id = '" . $this->db->escape($new_value) . "' WHERE product_id = '" . (int)$pid . "'");			
				} else if  ($field == 'quantity' || $field == 'minimum' || $field == 'points' || $field == 'viewed') {
					eval( '$result = (' . $new_value . ');' );
					$this->db->query("UPDATE " . DB_PREFIX . "product SET " . $field . " = '" . $this->db->escape((int)$result) . "', date_modified = NOW() WHERE product_id = '" . (int)$pid . "'");
				} else if  ($field == 'price') {
					eval( '$result = (' . $new_value . ');' );
					$this->db->query("UPDATE " . DB_PREFIX . "product SET " . $field . " = '" . $this->db->escape($result) . "', date_modified = NOW() WHERE product_id = '" . (int)$pid . "'");
				} else {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET " . $field . " = '" . $this->db->escape($new_value) . "', date_modified = NOW() WHERE product_id = '" . (int)$pid . "'");
				}	
				
				$json['products'][] = $this->model_catalog_product->getProduct($pid);
			}
			$json['field'] = $field;
			$json['value'] = $value;
			$json['product_id'] = $product_id;
			$json['success'] = 'success';
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function bulkupload() {
		$json = array();

		if(isset($_FILES)) {  
			$error = false;
			$files = array();
		
			$uploaddir = DIR_IMAGE.'catalog/';
			foreach($_FILES as $file) {
				if(move_uploaded_file($file['tmp_name'], $uploaddir .basename($file['name']))) {
					$files[] = $uploaddir .$file['name'];
				} else {
					$error = true;
				}
			}
			
			if ($error) {
				$json['error'][] = 'There was an error uploading your files.';
			}
		} else {
			$json['error'][] = 'There was unexpected error. Please try again.';
		}
		
		$current_folder = time();
		$unzipping = false;
		$zip = new ZipArchive;
		$res = $zip->open($files[0]);
		$update_map = array();
		if ($res === true) {
			for($x=0;$x < $zip->numFiles; $x++) {
				$filename = $zip->getNameIndex($x);
				if (preg_match('/\.(jpe?g|gif|png)$/', basename($filename))) {
					$filePath = $uploaddir.'productmanager'.DIRECTORY_SEPARATOR.$current_folder . DIRECTORY_SEPARATOR . ltrim($filename, '/');
					mkdir(dirname($filePath), 0755, true);
					file_put_contents($filePath, $zip->getFromIndex($x));
					preg_match('/^(\d+)\.(jpg|png)$/', basename($filename), $matches);
					$product_id = $matches[1];
					$update_map[$product_id] = $filePath;
				}
			}
			$zip->close();
			$unzipping = true;
		} else {
			$json['error'][] = 'We were not able to unzip the file.';
		}
		
		if (file_exists($files[0])) {
			unlink($files[0]);
		}
		
		if ($unzipping) {
			$this->load->model('catalog/product');
			$this->load->model('tool/image');
			$totalChanges = 0;
			foreach ($update_map as $product_id => $file) {
				$image_url = str_replace(DIR_IMAGE,'',$file);
				
				$product_info = $this->model_catalog_product->getProduct($product_id);
				if (!empty($product_info)) {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape($image_url) . "' WHERE product_id = '" . (int)$product_id . "'");
					$new_data = $this->model_catalog_product->getProduct($product_id);
					if (is_file(DIR_IMAGE . $new_data['image'])) {
						$product_image = $this->model_tool_image->resize($new_data['image'], 40, 40);
					} else {
						$product_image = $this->model_tool_image->resize('no_image.png', 40, 40);
					}
					$json['products'][] = array(
						'id' => $new_data['product_id'],
						'image' => $new_data['image'],
						'product_image' => $product_image
					);
					$totalChanges++;		
				}
			}
			$json['total'] = $totalChanges;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));	
	}
}