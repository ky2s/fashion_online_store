<?php
class ControllerModuleFeatured extends Controller {
	public function index($setting) {
		
		$this->load->language('module/featured');

		$data['heading_title'] = $this->language->get('heading_title');
		
		$module_id = 28; //ID MODULE latest dari database
		$module_info = $this->model_extension_module->getModule($module_id);
		$data['module_name'] = $module_info['name'];
		
		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$data['featured'] = $this->url->link('product/featured');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$store_id = $this->config->get('config_store_id');
		$data['store_id'] = $store_id;

		$config = $this->model_setting_setting->getSetting('config', $store_id);
		
		if($config){
			$data['store_name'] = $config['config_name'];
		}

		$data['products'] = array();
		$items = array();

		if (!$setting['limit']) {
			$setting['limit'] = 4;
		}

		$products = array_slice($setting['product'], 0, (int)$setting['limit']);

		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProductByGroup($product_id);

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

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true, true);
						
						$price_old = $price;
						if($store_id > 0){
							$price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')), '', '', true) ;
						}

					} else {
						$price = false;
					}

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