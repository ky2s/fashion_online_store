<?php
class ControllerModuleLatest extends Controller {
	public function index($setting) {
		//pre($this->session->data['cart']);
		$this->load->language('module/latest');

		$data['heading_title'] = $this->language->get('heading_title');

		$module_id = 31; //ID MODULE latest dari database
		$module_info = $this->model_extension_module->getModule($module_id);
		$data['module_name'] = $module_info['name'];
		$data['text_tax'] = $this->language->get('text_tax');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');
		$data['latest'] = $this->url->link('product/latest');
		$data['about_brand'] = $this->url->link('information/information&information_id=4');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		$data['groups'] = array();

		$filter_data = array(
			'sort'  => 'p.date_added',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $setting['limit']
		);

		$groups = $this->model_catalog_product->getProductsByGroup($filter_data);
		
		if ($groups) {
			foreach ($groups as $result) {
				/*if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
				}*/

				

				//OPTION
				/*$data['options'] = array();
				foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
					$product_option_value_data = array();

					foreach ($option['product_option_value'] as $option_value) {
						if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
							if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float)$option_value['price']) {
								$price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
							} else {
								$price = false;
							}

							$product_option_value_data[] = array(
								'product_option_value_id' => $option_value['product_option_value_id'],
								'option_value_id'         => $option_value['option_value_id'],
								'name'                    => $option_value['name'],
								'image'                   => $this->model_tool_image->resize($option_value['image'], 50, 50),
								'price'                   => $price,
								'price_prefix'            => $option_value['price_prefix']
							);
						}
					}

					$data['options'][] = array(
						'product_option_id'    => $option['product_option_id'],
						'product_option_value' => $product_option_value_data,
						'option_id'            => $option['option_id'],
						'name'                 => $option['name'],
						'type'                 => $option['type'],
						'value'                => $option['value'],
						'required'             => $option['required']
					);
				}*/

				//pre($result['product_data']);
				$product['products'] = array();
				foreach ($result['product_data'] as $p) 
				{		
					if ($p['image']) 
					{	
						$image = array();
						$images = $this->model_catalog_product->getProductImages($p['product_id']);
						foreach ($images as $img) {
							$image[] = $this->model_tool_image->resize($img['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
						}
					} 
					else {
						$image[] = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($p['price'], $p['tax_class_id'], $this->config->get('config_tax')),'','', true, true);
					} else {
						$price = false;
					}

					if ((float)$p['special']) {
						$special = $this->currency->format($this->tax->calculate($p['special'], $p['tax_class_id'], $this->config->get('config_tax')),'','', true, true);
					} else {
						$special = false;
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
					//option get size
					$size = $this->model_catalog_product->getProductOptions($p['product_id']);
					$product['products'][] = array(
						'product_id'  => $p['product_id'],
						'thumb'       => $image,
						'name'        => $p['name'],
						'color'        => $p['color'],
						'description' => utf8_substr(strip_tags(html_entity_decode($p['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
						'price'       => $price,
						'special'     => $special,
						'tax'         => $tax,
						'rating'      => $rating,
						'href'        => $this->url->link('product/product', 'product_id=' . $p['product_id'] .'&group_id='.$result['group_data']['product_group_id']),
						'size'      => $size,
					); 
				}

				$data['groups'][] = array(
					'group_data' => $result['group_data'],
					'product_data' => $product['products'],
					);
			}
			//pre($data['groups']);
			//essential
			$this->load->model('catalog/information');
			$essential_id = 22; //22: ID Essential di table information
			$essential_result = $this->model_catalog_information->getInformation($essential_id);
			$data['essential'] = $essential_result['description'];

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/latest.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/latest.tpl', $data);
			} else {
				return $this->load->view('default/template/module/latest.tpl', $data);
			}
		}
	}
}