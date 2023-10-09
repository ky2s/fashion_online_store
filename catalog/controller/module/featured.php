<?php
class ControllerModuleFeatured extends Controller {
	public function index($setting) {
		
		$this->load->language('module/featured');

		$store_id = $this->config->get('config_store_id');
		$data['store_id'] = $store_id;
		$setting = $this->model_extension_module->getFeatured($store_id);
		
		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['module_name'] = $setting['name'];
		
		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$data['featured'] = $this->url->link('product/featured');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');
		$this->load->model('setting/setting');

		$config = $this->model_setting_setting->getSetting('config', $store_id);
		if($config){
			$data['store_name'] = $config['config_name'];
		}

		$data['products'] = array();
		$items = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		//CHECK WHO AFFILIATE
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

		$products = array_slice($setting['product'], 0, (int)$setting['limit']);
		foreach ($products as $product_id) {
			
			$session_admin = false;

			$product_info = $this->model_catalog_product->getProductByGroup($product_id, $session_admin);


			if ($product_info) {	

				foreach ($product_info as $i => $p) {

					if ($p['image']) 
					{	
						$image = array();
						$images = $this->model_catalog_product->getProductImages($p['product_id']);
						foreach ($images as $g => $img) {
							if($img['image']){
								$image[$g] = $this->model_tool_image->resize($img['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
							}else{
								$image[$g] = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));		
							}
						}
					} 
					else {
						$image[$i] = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}

					//PRICE
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true, true);
						
						$price_old = $price;
						if($store_id > 0){
							$price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true) ;
						}

						//check cookie & session tracking
						if($this->request->cookie['tracking'] && $this->session->data['tracking']){
							$affiliate_price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true, true,true) ;
						}

					} else {
						$price = false;
					}

					//SPECIAL PRICE
					if ((float)$p['special']) {
						$special = $this->currency->format($this->tax->calculate($p['special'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true, true);
						
						if($store_id > 0){
							$special = $price_old;
						}
						
					} else {
						$special = false;
						
						if($store_id > 0){
							$special = $price_old;
						}

						//for affiliate
						if(!$compare && isset($this->request->cookie['tracking']) && ($config['config_affiliate_discount'] > 0) && $this->session->data['tracking']){
							$special = $affiliate_price;	
						}
						
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float)$p['special'] ? $p['special'] : $p['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $p['rating'];
					} else {
						$rating = false;
					}

					//pre($special);
					$size = $this->model_catalog_product->getProductOptions($p['product_id']);
					//check group id
					if($p['group_id']){
						$items[$p['group_id']]['group_data']= $this->model_catalog_product->getGroup($p['group_id']);
						$items[$p['group_id']]['product_data'][]= array(
							'product_id'  => $p['product_id'],
							'group_id'  	=> $p['group_id'],
							'thumb'       => $image,
							'name'        => $p['name'],
							'description' => utf8_substr(strip_tags(html_entity_decode($p['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
							'price'       => $price,
							'product_quantity' => $p['quantity'],
							'special'     => $special,
							'tax'         => $tax,
							'rating'      => $rating,
							'href'        => $this->url->link('product/product', 'product_id=' . $p['product_id'] .'&group_id='.$p['group_id']),
							'color'        => $p['color'],
							'size'      => $size,
						);	
					}
				}
			}
		}

		$data['groups'] = $items;

		if ($data['groups']) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/featured.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/featured.tpl', $data);
			} else {
				return $this->load->view('default/template/module/featured.tpl', $data);
			}
		}
	}
}