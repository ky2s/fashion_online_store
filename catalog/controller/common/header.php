<?php
class ControllerCommonHeader extends Controller {

	public function index() {
		
		$this->checkStore();

		$data['title'] = $this->document->getTitle();

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$this->document->addScript('catalog/view/javascript/slick/slick.js');
		$this->document->addStyle('catalog/view/javascript/slick/slick.css');
		$this->document->addStyle('catalog/view/javascript/slick/slick-theme.css');
		
		$data['rc'] = $this->request->cookie['tracking'].'-cookie';
		//$data['rc'] = $this->session->data['tracking'].'session';
		
		/*//CHECK WHO AFFILIATE
		$affiliate_code = (isset($this->request->cookie['tracking'])) ? $this->request->cookie['tracking'] : FALSE;
		$this->load->model('affiliate/affiliate');
		$affiliate_data = $this->model_affiliate_affiliate->getAffiliateByCode($affiliate_code);

		$customer_id = (isset($this->session->data['customer_id'])) ? $this->session->data['customer_id'] : FALSE;
		$this->load->model('account/customer');
		$customer_data = $this->model_account_customer->getCustomer($customer_id);
		
		$compare = false;
		if(isset($affiliate_data['email']) && isset($customer_data['email'])){
			if($affiliate_data['email'] == $customer_data['email']){
				$compare = true;
			}
		}
		
		//cookie tracking saved in session
		if(!$compare){
			if($this->request->cookie['tracking']){

				if (!$this->customer->isLogged()) {
					$this->response->redirect($this->url->link('common/referral'));
				}
				$this->session->data['tracking'] = $this->request->cookie['tracking'];
			}	
		}else{
			$this->session->data['tracking'] = NULL;
		}*/

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');
		$data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$data['icon'] = $server . 'image/' . $this->config->get('config_icon');
		} else {
			$data['icon'] = '';
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');

		$data['text_home'] = $this->language->get('text_home');
		$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_payment_confirmation'] = $this->language->get('text_payment_confirmation');
		$data['text_confirm_order'] = $this->language->get('text_confirm_order');

		//link
		$data['home'] = $this->domain;
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/edit', '', 'SSL');
		$data['password'] = $this->url->link('account/password', '', 'SSL');
		$data['address'] = $this->url->link('account/address', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		//$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['about'] = $this->url->link('information/information&information_id=4');
		$data['payment_confirmation'] = $this->url->link('information/payment_confirmation', '', 'SSL');

		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;
					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);
		//pre($categories);
		foreach ($categories as $k=>$category) {
			if ($category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);
				//PRE($children);
				/*LEVEL 2 ***********************/	

				$product_total_add = '';
				foreach ($children as $j=>$child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					if($this->config->get('config_product_count'))
					{
						end($filter_data);	
						$lastElementKey = key($filter_data);
						foreach($filter_data as $k => $v) {
							$product_total_add .= $v;
							if($k != $lastElementKey) {
								$product_total_add .= '.';
							}
						}
						
						$product_total = $this->cache->get('product_total,'.$product_total_add);
						
						if(!$product_total) {
							$product_total = $this->model_catalog_product->getTotalProducts($filter_data);
							$this->cache->set('product_total.'.$product_total_add, $product_total);
						}
					}
					
					/*LEVEL 3 ***********************/
					$children_last = $this->model_catalog_category->getCategories($child['category_id']);
					$child_last_data = array();	
					foreach ($children_last as $i=>$child_last) 
					{
						$child_last_data[$i] = array(
							'id'     => $child_last['category_id'],
							'name'  => $child_last['name'],
							'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] .'_'. $child_last['category_id'])
						);
					}

					$children_data[$j] = array(
						'id'     => $child['category_id'],
						'name'     => $child['name'],
						'children' => $child_last_data,
						'column' => $child['column'] ? $category['column'] : 1,
						'href'     => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories'][$k] = array(
					'id'     => $category['category_id'],
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}

		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		## CUSTOM BY STEPH ##
		if($this->customer->isLogged()) {
			$data['text_account_is_login'] = sprintf($this->language->get('text_account_is_login'), $this->customer->getFirstName());			
		} else {
			$data['text_account_is_login'] = $this->language->get('text_account');
		}
		##

		$data['factories'] = $this->url->link('information/information&information_id=15');
		//modal login
		$data['quicksignup'] = $this->load->controller('common/quicksignup');

		//banner popup
		$this->load->model('design/banner');
		$data['banners'] = array();
		$results = $this->model_design_banner->getBannerActive(1);
		if($results && ($this->session->data['session_data'] == NULL)){
			foreach ($results as $result) {
				if (is_file(DIR_IMAGE . $result['image'])) {
					if(($result['start_date'] <= date('Y-m-d H:i:s')) && ($result['end_date'] >= date('Y-m-d H:i:s'))){		
						$data['banners'][] = array(
							'title' => $result['title'],
							'link'  => ($result['link']) ? $result['link'] : '',
							'image' => $this->model_tool_image->resize($result['image'], 510, 437)
						);	
					}		
				}
			}
		}
		// /pre($data['banners']);
		if(isset($this->request->post['session_data'])){
			$this->session->data['session_data'] = $this->request->post['session_data'];	
		}
// /pre($this->session->data);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}

	public function checkStore(){
		if ($this->request->server['HTTPS']) {
			$base = HTTPS_SERVER;
		} else {
			$base = HTTP_SERVER;
		}

		$this->load->model('setting/setting');
		//pre($this->model_setting_setting->getSetting('config'));
		//pre($this->config);
		$store_id = $this->config->get('config_store_id');
		//pre($store_id);
		if($store_id > 0){
			$this->load->model('setting/store');
			
			$data_field = array('field' => 'store_id', 'value'=> $store_id);
			$store = $this->model_setting_store->getStoresByField($data_field);
			//pre($store);
			//$actual_link = "http://$_SERVER[HTTP_HOST]";
			//$actual_link = "http://$_SERVER[HTTP_HOST]";
			//pre($this->config->get('config_ftp_hostname'));
			//$check_store = $this->model_setting_store->checkActiveStore($actual_link);
			//
			if(!$store[0]['status']){
				//pre($this->config->get('config_url'));
				/*$field_store_default = array('field' => 'store_id', 'value'=> 0); // store_id = 0 is default_store
				$default_store = $this->model_setting_store->getStoresByField($field_store_default);
				pre($default_store);*/
				$default_store = $this->model_setting_setting->getSetting('config', 0);
				//pre($default_store);
				$this->response->redirect($base);
			}
		}
	}
}