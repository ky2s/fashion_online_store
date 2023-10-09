<?php
class ModelCheckoutOrder extends Model {
	public function addOrder($data) {
		$this->event->trigger('pre.order.add', $data);

		$this->db->query("INSERT INTO `" . DB_PREFIX . "order` SET invoice_prefix = '" . $this->db->escape($data['invoice_prefix']) . "', store_id = '" . (int)$data['store_id'] . "', store_name = '" . $this->db->escape($data['store_name']) . "', store_url = '" . $this->db->escape($data['store_url']) . "', customer_id = '" . (int)$data['customer_id'] . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']) ? serialize($data['custom_field']) : '') . "', payment_firstname = '" . $this->db->escape($data['payment_firstname']) . "', payment_lastname = '" . $this->db->escape($data['payment_lastname']) . "', payment_company = '" . $this->db->escape($data['payment_company']) . "', payment_address_1 = '" . $this->db->escape($data['payment_address_1']) . "', payment_address_2 = '" . $this->db->escape($data['payment_address_2']) . "', payment_city = '" . $this->db->escape($data['payment_city']) . "', payment_postcode = '" . $this->db->escape($data['payment_postcode']) . "', payment_country = '" . $this->db->escape($data['payment_country']) . "', payment_country_id = '" . (int)$data['payment_country_id'] . "', payment_zone = '" . $this->db->escape($data['payment_zone']) . "', payment_zone_id = '" . (int)$data['payment_zone_id'] . "', payment_address_format = '" . $this->db->escape($data['payment_address_format']) . "', payment_custom_field = '" . $this->db->escape(isset($data['payment_custom_field']) ? serialize($data['payment_custom_field']) : '') . "', payment_method = '" . $this->db->escape($data['payment_method']) . "', payment_code = '" . $this->db->escape($data['payment_code']) . "', shipping_firstname = '" . $this->db->escape($data['shipping_firstname']) . "', shipping_lastname = '" . $this->db->escape($data['shipping_lastname']) . "', shipping_company = '" . $this->db->escape($data['shipping_company']) . "', shipping_address_1 = '" . $this->db->escape($data['shipping_address_1']) . "', shipping_address_2 = '" . $this->db->escape($data['shipping_address_2']) . "', shipping_city = '" . $this->db->escape($data['shipping_city']) . "', shipping_postcode = '" . $this->db->escape($data['shipping_postcode']) . "', shipping_country = '" . $this->db->escape($data['shipping_country']) . "', shipping_country_id = '" . (int)$data['shipping_country_id'] . "', shipping_zone = '" . $this->db->escape($data['shipping_zone']) . "', shipping_zone_id = '" . (int)$data['shipping_zone_id'] . "', shipping_address_format = '" . $this->db->escape($data['shipping_address_format']) . "', shipping_custom_field = '" . $this->db->escape(isset($data['shipping_custom_field']) ? serialize($data['shipping_custom_field']) : '') . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "', shipping_code = '" . $this->db->escape($data['shipping_code']) . "', comment = '" . $this->db->escape($data['comment']) . "', wrap_comment = '" . $this->db->escape($data['wrap_comment']) . "', wrap_name = '" . $this->db->escape($data['wrap_name']) . "', wrap_image = '" . $this->db->escape($data['wrap_image']) . "', wrap_total = '" . (float)$data['wrap_subtotal'] . "', card_name = '" . $this->db->escape($data['card_name']) . "', card_comment = '" . $this->db->escape($data['card_comment']) . "', card_image = '" . $this->db->escape($data['card_image']) . "', card_total = '" . (float)$data['card_price'] . "', total = '" . (float)$data['total'] . "', affiliate_id = '" . (int)$data['affiliate_id'] . "', commission = '" . (float)$data['commission'] . "', marketing_id = '" . (int)$data['marketing_id'] . "', tracking = '" . $this->db->escape($data['tracking']) . "', language_id = '" . (int)$data['language_id'] . "', currency_id = '" . (int)$data['currency_id'] . "', currency_code = '" . $this->db->escape($data['currency_code']) . "', currency_value = '" . (float)$data['currency_value'] . "', ip = '" . $this->db->escape($data['ip']) . "', forwarded_ip = '" .  $this->db->escape($data['forwarded_ip']) . "', user_agent = '" . $this->db->escape($data['user_agent']) . "', accept_language = '" . $this->db->escape($data['accept_language']) . "', date_added = NOW(), date_modified = NOW()");

		$order_id = $this->db->getLastId();

		// Products
		if (isset($data['products'])) {
			foreach ($data['products'] as $product) {
							
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '" . (float)$product['tax'] . "', vendor_id = '" . (int)$product['vendor_id'] . "', commission =  '" . (float)$product['commission'] . "', title = '" . $this->db->escape($product['title']) . "', vendor_total = '" . (float)$product['vendor_total'] . "', vendor_tax = '" . (float)$product['vendor_tax'] . "', store_tax = '" . (float)$product['store_tax'] . "',reward = '" . (int)$product['reward'] . "'");
			
	
				$order_product_id = $this->db->getLastId();
	
				foreach ($product['option'] as $option) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
				}
			
			$getVenId = $this->db->query("SELECT vs.vendor_id AS vendor_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "vendor v ON (p.product_id = v.vproduct_id) LEFT JOIN " . DB_PREFIX . "vendors vs ON (v.vendor = vs.vendor_id) WHERE p.product_id = '" . (int)$product['product_id'] . "'");
			$getVenIds[] = array ('vendor_id' => $getVenId->row['vendor_id']);
			
			}
		}
		
		// Gift Voucher
			
			$vendor_cost = $this->getdescost();	
			$getUniVenId = array_map("unserialize", array_unique(array_map("serialize", $getVenIds)));
			foreach ($getUniVenId as $vendor) {
				if (!empty($this->session->data['shipping_method'])) {
					if ($vendor['vendor_id']) {
						if (preg_match("/\bmvdm_flat\b/i", $this->session->data['shipping_method']['code'])) {
							
							$final_couriers = array();
							foreach($this->mvdm_flat_shipping() as $courier) {
								if (substr($this->session->data['shipping_method']['code'],19) == $courier['courier_id']) {
									$getVendor = $this->db->query("SELECT vendor FROM `" . DB_PREFIX . "vendor` WHERE vproduct_id = '" . (int)$courier['product_id'] . "'");
									$final_couriers[] = array (
										'vendor_id'	=> $getVendor->row['vendor'],
										'cost'		=> $courier['cost'],
										'weight'	=> $courier['weight']
									);	
										
								}
							}
								
							$scost = 0;
							$sweight = 0;							
							foreach ($final_couriers as $final_courier) {
								if ($vendor['vendor_id'] == $final_courier['vendor_id']) {
									$scost += $final_courier['cost'];
									$sweight += $final_courier['weight'];
								}
							}
								
							if ($this->config->get('mvdm_flat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvdm_flat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$couriername = $this->db->query("SELECT courier_name FROM `" . DB_PREFIX . "courier` WHERE courier_id = '" . (int)(substr($this->session->data['shipping_method']['code'],19)) . "'");
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = '" . $this->db->escape($couriername->row['courier_name']) . "', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
								
						} elseif ($this->session->data['shipping_method']['code'] == 'mvweight.mvweight') {
							$scost = 0;
							$sweight = 0;
											
							foreach ($vendor_cost as $vsc) {
								if ($vendor['vendor_id'] == $vsc['vendor_id']) {
									$scost = $vsc['cost'];
									$sweight = $vsc['weight'];
								}
							}
								
							if ($this->config->get('mvweight_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvweight_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Weight Base Shipping', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
							
						} elseif ($this->session->data['shipping_method']['code'] == 'mvflat.mvflat') {			
							$mv_flat = $this->mv_flat_shipping();
							$scost = 0;
							$sweight = 0;
				
							foreach ($mv_flat as $mvflat) {
								if ($vendor['vendor_id'] == $mvflat['vendor']) {
									$scost += $mvflat['cost'];
									$sweight += $mvflat['weight'];
								}
							}
								
							if ($this->config->get('mvflat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvflat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Flat Rate Shipping', tax =  '" . (float)$shipping_tax . "', cost =  '" . (float)$scost . "', weight = '" . (float)$sweight . "'");
						}
					}
				}
			}
			
		$this->load->model('checkout/voucher');

		// Vouchers
		if (isset($data['vouchers'])) {
			foreach ($data['vouchers'] as $voucher) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");
	
				$order_voucher_id = $this->db->getLastId();
	
				$voucher_id = $this->model_checkout_voucher->addVoucher($order_id, $voucher);
	
				$this->db->query("UPDATE " . DB_PREFIX . "order_voucher SET voucher_id = '" . (int)$voucher_id . "' WHERE order_voucher_id = '" . (int)$order_voucher_id . "'");
			}
		}
		
		// Totals
		if (isset($data['totals'])) {
			foreach ($data['totals'] as $total) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = '" . $this->db->escape($total['code']) . "', title = '" . $this->db->escape($total['title']) . "', `value` = '" . (float)$total['value'] . "', sort_order = '" . (int)$total['sort_order'] . "'");

			if($total['code'] == 'coupon') {
				$code = '';		
				$start = strpos($total['title'], '(') + 1;
				$end = strrpos($total['title'], ')');
					
				if ($start && $end) {  
					$code = substr($total['title'], $start, $end - $start);
				}
				
				$this->load->model('checkout/coupon');				
				$coupon_info = $this->model_checkout_coupon->getCoupon($code);
					
				if ($coupon_info) {
					$vendor_list = array();
					$vendor_pool = array();
					
					foreach ($coupon_info['product'] as $product_id){
						$getvendor = $this->db->query("SELECT vendor FROM " . DB_PREFIX . "vendor WHERE vproduct_id = '" . (int)$product_id . "'");
						$vendor_list[] = array (
							'vendor_id'	=> $getvendor->row['vendor']
						);
					}
									
					$vendor_pool = array_map("unserialize", array_unique(array_map("serialize", $vendor_list)));
								
					foreach ($vendor_pool as $vendor) {
						if ($vendor) {
							${'sub_total' . $vendor['vendor_id'] } = 0;
							${'tax_rate' . $vendor['vendor_id'] } = 0;
								
							foreach($this->cart->getProducts() as $product) {
								$get_id = $this->db->query("SELECT vendor FROM " . DB_PREFIX . "vendor WHERE vproduct_id = '" . (int)$product['product_id'] . "'");
								if ($vendor['vendor_id'] == $get_id->row['vendor']) {
									if (in_array($product['product_id'], $coupon_info['product'])) {
										${'sub_total' . $vendor['vendor_id'] } += $product['total'];	
											
										if ($coupon_info['type'] == 'F') {
											$tax_discount = $coupon_info['discount'];
										} elseif ($coupon_info['type'] == 'P') {
											$tax_discount = $product['total'] / 100 * $coupon_info['discount'];
										}
											
										if ($product['tax_class_id']) {
											${'tax_rate' . $vendor['vendor_id'] } += $this->tax->getTax($product['total'] - ($product['total'] - $tax_discount), $product['tax_class_id']);
										}
									}
								}						
							}
									
							$subtotal_list[] = array (
								'subtotal'	=>	${'sub_total' . $vendor['vendor_id'] },
								'tax'		=>	${'tax_rate' . $vendor['vendor_id'] },
								'vendor_id'	=>	$vendor['vendor_id']
							);
						}
					}

					foreach ($subtotal_list as $subtotal) {
						if ($subtotal) {
							$discount_amount = 0;
							if ($coupon_info['type'] == 'F') {
								$discount_amount = $coupon_info['discount'];
							} elseif ($coupon_info['type'] == 'P') {
								$discount_amount = $subtotal['subtotal'] / 100 * $coupon_info['discount'];
							}
							$this->db->query("INSERT INTO `" . DB_PREFIX . "vendor_discount` SET coupon_id = '" . (int)$coupon_info['coupon_id'] . "', title= '" . $total['title'] . "',order_id = '" . (int)$order_id . "', vendor_id = '" . (int)$subtotal['vendor_id'] . "', amount = '" . (float)$discount_amount . "', tax = '" . (float)$subtotal['tax'] . "'");
						}
					}				
				}
			}
			
			}
		}
		
		$this->event->trigger('post.order.add', $order_id);

		return $order_id;
	}

	public function editOrder($order_id, $data) {
		$this->event->trigger('pre.order.edit', $data);

		// Void the order first
		$this->addOrderHistory($order_id, 0);

		$this->db->query("UPDATE `" . DB_PREFIX . "order` SET invoice_prefix = '" . $this->db->escape($data['invoice_prefix']) . "', store_id = '" . (int)$data['store_id'] . "', store_name = '" . $this->db->escape($data['store_name']) . "', store_url = '" . $this->db->escape($data['store_url']) . "', customer_id = '" . (int)$data['customer_id'] . "', customer_group_id = '" . (int)$data['customer_group_id'] . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(serialize($data['custom_field'])) . "', payment_firstname = '" . $this->db->escape($data['payment_firstname']) . "', payment_lastname = '" . $this->db->escape($data['payment_lastname']) . "', payment_company = '" . $this->db->escape($data['payment_company']) . "', payment_address_1 = '" . $this->db->escape($data['payment_address_1']) . "', payment_address_2 = '" . $this->db->escape($data['payment_address_2']) . "', payment_city = '" . $this->db->escape($data['payment_city']) . "', payment_postcode = '" . $this->db->escape($data['payment_postcode']) . "', payment_country = '" . $this->db->escape($data['payment_country']) . "', payment_country_id = '" . (int)$data['payment_country_id'] . "', payment_zone = '" . $this->db->escape($data['payment_zone']) . "', payment_zone_id = '" . (int)$data['payment_zone_id'] . "', payment_address_format = '" . $this->db->escape($data['payment_address_format']) . "', payment_custom_field = '" . $this->db->escape(serialize($data['payment_custom_field'])) . "', payment_method = '" . $this->db->escape($data['payment_method']) . "', payment_code = '" . $this->db->escape($data['payment_code']) . "', shipping_firstname = '" . $this->db->escape($data['shipping_firstname']) . "', shipping_lastname = '" . $this->db->escape($data['shipping_lastname']) . "', shipping_company = '" . $this->db->escape($data['shipping_company']) . "', shipping_address_1 = '" . $this->db->escape($data['shipping_address_1']) . "', shipping_address_2 = '" . $this->db->escape($data['shipping_address_2']) . "', shipping_city = '" . $this->db->escape($data['shipping_city']) . "', shipping_postcode = '" . $this->db->escape($data['shipping_postcode']) . "', shipping_country = '" . $this->db->escape($data['shipping_country']) . "', shipping_country_id = '" . (int)$data['shipping_country_id'] . "', shipping_zone = '" . $this->db->escape($data['shipping_zone']) . "', shipping_zone_id = '" . (int)$data['shipping_zone_id'] . "', shipping_address_format = '" . $this->db->escape($data['shipping_address_format']) . "', shipping_custom_field = '" . $this->db->escape(serialize($data['shipping_custom_field'])) . "', shipping_method = '" . $this->db->escape($data['shipping_method']) . "', shipping_code = '" . $this->db->escape($data['shipping_code']) . "', comment = '" . $this->db->escape($data['comment']) . "', total = '" . (float)$data['total'] . "', affiliate_id = '" . (int)$data['affiliate_id'] . "', commission = '" . (float)$data['commission'] . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "'");

		// Products
		if (isset($data['products'])) {
			foreach ($data['products'] as $product) {
							
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '" . (float)$product['tax'] . "', vendor_id = '" . (int)$product['vendor_id'] . "', commission =  '" . (float)$product['commission'] . "', title = '" . $this->db->escape($product['title']) . "', vendor_total = '" . (float)$product['vendor_total'] . "', vendor_tax = '" . (float)$product['vendor_tax'] . "', store_tax = '" . (float)$product['store_tax'] . "',reward = '" . (int)$product['reward'] . "'");
			
	
				$order_product_id = $this->db->getLastId();
	
				foreach ($product['option'] as $option) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
				}
			}
		}
		
		// Gift Voucher
			
			$vendor_cost = $this->getdescost();	
			$getUniVenId = array_map("unserialize", array_unique(array_map("serialize", $getVenIds)));
			foreach ($getUniVenId as $vendor) {
				if (!empty($this->session->data['shipping_method'])) {
					if ($vendor['vendor_id']) {
						if (preg_match("/\bmvdm_flat\b/i", $this->session->data['shipping_method']['code'])) {
							
							$final_couriers = array();
							foreach($this->mvdm_flat_shipping() as $courier) {
								if (substr($this->session->data['shipping_method']['code'],19) == $courier['courier_id']) {
									$getVendor = $this->db->query("SELECT vendor FROM `" . DB_PREFIX . "vendor` WHERE vproduct_id = '" . (int)$courier['product_id'] . "'");
									$final_couriers[] = array (
										'vendor_id'	=> $getVendor->row['vendor'],
										'cost'		=> $courier['cost'],
										'weight'	=> $courier['weight']
									);	
										
								}
							}
								
							$scost = 0;
							$sweight = 0;							
							foreach ($final_couriers as $final_courier) {
								if ($vendor['vendor_id'] == $final_courier['vendor_id']) {
									$scost += $final_courier['cost'];
									$sweight += $final_courier['weight'];
								}
							}
								
							if ($this->config->get('mvdm_flat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvdm_flat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$couriername = $this->db->query("SELECT courier_name FROM `" . DB_PREFIX . "courier` WHERE courier_id = '" . (int)(substr($this->session->data['shipping_method']['code'],19)) . "'");
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = '" . $this->db->escape($couriername->row['courier_name']) . "', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
								
						} elseif ($this->session->data['shipping_method']['code'] == 'mvweight.mvweight') {
							$scost = 0;
							$sweight = 0;
											
							foreach ($vendor_cost as $vsc) {
								if ($vendor['vendor_id'] == $vsc['vendor_id']) {
									$scost = $vsc['cost'];
									$sweight = $vsc['weight'];
								}
							}
								
							if ($this->config->get('mvweight_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvweight_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Weight Base Shipping', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
							
						} elseif ($this->session->data['shipping_method']['code'] == 'mvflat.mvflat') {			
							$mv_flat = $this->mv_flat_shipping();
							$scost = 0;
							$sweight = 0;
				
							foreach ($mv_flat as $mvflat) {
								if ($vendor['vendor_id'] == $mvflat['vendor']) {
									$scost += $mvflat['cost'];
									$sweight += $mvflat['weight'];
								}
							}
								
							if ($this->config->get('mvflat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvflat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Flat Rate Shipping', tax =  '" . (float)$shipping_tax . "', cost =  '" . (float)$scost . "', weight = '" . (float)$sweight . "'");
						}
					}
				}
			}
			
		$this->load->model('checkout/voucher');

		$this->model_checkout_voucher->disableVoucher($order_id);

		// Vouchers
		$this->db->query("DELETE FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");
		
		if (isset($data['vouchers'])) {
			foreach ($data['vouchers'] as $voucher) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");
	
				$order_voucher_id = $this->db->getLastId();
	
				$voucher_id = $this->model_checkout_voucher->addVoucher($order_id, $voucher);
	
				$this->db->query("UPDATE " . DB_PREFIX . "order_voucher SET voucher_id = '" . (int)$voucher_id . "' WHERE order_voucher_id = '" . (int)$order_voucher_id . "'");
			}
		}
		
		// Totals
		$this->db->query("DELETE FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "'");

		if (isset($data['totals'])) {
			foreach ($data['totals'] as $total) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = '" . $this->db->escape($total['code']) . "', title = '" . $this->db->escape($total['title']) . "', `value` = '" . (float)$total['value'] . "', sort_order = '" . (int)$total['sort_order'] . "'");
			}
		}
		
		$this->event->trigger('post.order.edit', $order_id);
	}

	public function deleteOrder($order_id) {
		$this->event->trigger('pre.order.delete', $order_id);

		// Void the order first
		$this->addOrderHistory($order_id, 0);

		$this->db->query("DELETE FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_product` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_option` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_voucher` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_history` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "order_fraud` WHERE order_id = '" . (int)$order_id . "'");
		$this->db->query("DELETE `or`, ort FROM `" . DB_PREFIX . "order_recurring` `or`, `" . DB_PREFIX . "order_recurring_transaction` `ort` WHERE order_id = '" . (int)$order_id . "' AND ort.order_recurring_id = `or`.order_recurring_id");

		$this->db->query("DELETE FROM `" . DB_PREFIX . "affiliate_transaction` WHERE order_id = '" . (int)$order_id . "'");

		// Gift Voucher
			
			$vendor_cost = $this->getdescost();	
			$getUniVenId = array_map("unserialize", array_unique(array_map("serialize", $getVenIds)));
			foreach ($getUniVenId as $vendor) {
				if (!empty($this->session->data['shipping_method'])) {
					if ($vendor['vendor_id']) {
						if (preg_match("/\bmvdm_flat\b/i", $this->session->data['shipping_method']['code'])) {
							
							$final_couriers = array();
							foreach($this->mvdm_flat_shipping() as $courier) {
								if (substr($this->session->data['shipping_method']['code'],19) == $courier['courier_id']) {
									$getVendor = $this->db->query("SELECT vendor FROM `" . DB_PREFIX . "vendor` WHERE vproduct_id = '" . (int)$courier['product_id'] . "'");
									$final_couriers[] = array (
										'vendor_id'	=> $getVendor->row['vendor'],
										'cost'		=> $courier['cost'],
										'weight'	=> $courier['weight']
									);	
										
								}
							}
								
							$scost = 0;
							$sweight = 0;							
							foreach ($final_couriers as $final_courier) {
								if ($vendor['vendor_id'] == $final_courier['vendor_id']) {
									$scost += $final_courier['cost'];
									$sweight += $final_courier['weight'];
								}
							}
								
							if ($this->config->get('mvdm_flat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvdm_flat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$couriername = $this->db->query("SELECT courier_name FROM `" . DB_PREFIX . "courier` WHERE courier_id = '" . (int)(substr($this->session->data['shipping_method']['code'],19)) . "'");
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = '" . $this->db->escape($couriername->row['courier_name']) . "', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
								
						} elseif ($this->session->data['shipping_method']['code'] == 'mvweight.mvweight') {
							$scost = 0;
							$sweight = 0;
											
							foreach ($vendor_cost as $vsc) {
								if ($vendor['vendor_id'] == $vsc['vendor_id']) {
									$scost = $vsc['cost'];
									$sweight = $vsc['weight'];
								}
							}
								
							if ($this->config->get('mvweight_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvweight_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Weight Base Shipping', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
							
						} elseif ($this->session->data['shipping_method']['code'] == 'mvflat.mvflat') {			
							$mv_flat = $this->mv_flat_shipping();
							$scost = 0;
							$sweight = 0;
				
							foreach ($mv_flat as $mvflat) {
								if ($vendor['vendor_id'] == $mvflat['vendor']) {
									$scost += $mvflat['cost'];
									$sweight += $mvflat['weight'];
								}
							}
								
							if ($this->config->get('mvflat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvflat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Flat Rate Shipping', tax =  '" . (float)$shipping_tax . "', cost =  '" . (float)$scost . "', weight = '" . (float)$sweight . "'");
						}
					}
				}
			}
			
		$this->load->model('checkout/voucher');

		$this->model_checkout_voucher->disableVoucher($order_id);

		$this->event->trigger('post.order.delete', $order_id);
	}

	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT *, (SELECT os.name FROM `" . DB_PREFIX . "order_status` os WHERE os.order_status_id = o.order_status_id AND os.language_id = o.language_id) AS order_status FROM `" . DB_PREFIX . "order` o WHERE o.order_id = '" . (int)$order_id . "'");

		if ($order_query->num_rows) {
			$country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$order_query->row['payment_country_id'] . "'");

			if ($country_query->num_rows) {
				$payment_iso_code_2 = $country_query->row['iso_code_2'];
				$payment_iso_code_3 = $country_query->row['iso_code_3'];
			} else {
				$payment_iso_code_2 = '';
				$payment_iso_code_3 = '';
			}

			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['payment_zone_id'] . "'");

			if ($zone_query->num_rows) {
				$payment_zone_code = $zone_query->row['code'];
			} else {
				$payment_zone_code = '';
			}

			$country_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "country` WHERE country_id = '" . (int)$order_query->row['shipping_country_id'] . "'");

			if ($country_query->num_rows) {
				$shipping_iso_code_2 = $country_query->row['iso_code_2'];
				$shipping_iso_code_3 = $country_query->row['iso_code_3'];
			} else {
				$shipping_iso_code_2 = '';
				$shipping_iso_code_3 = '';
			}

			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$order_query->row['shipping_zone_id'] . "'");

			if ($zone_query->num_rows) {
				$shipping_zone_code = $zone_query->row['code'];
			} else {
				$shipping_zone_code = '';
			}

			$this->load->model('localisation/language');

			$language_info = $this->model_localisation_language->getLanguage($order_query->row['language_id']);

			if ($language_info) {
				$language_code = $language_info['code'];
				$language_directory = $language_info['directory'];
			} else {
				$language_code = '';
				$language_directory = '';
			}

			return array(
				'order_id'                => $order_query->row['order_id'],
				'invoice_no'              => $order_query->row['invoice_no'],
				'invoice_prefix'          => $order_query->row['invoice_prefix'],
				'store_id'                => $order_query->row['store_id'],
				'store_name'              => $order_query->row['store_name'],
				'store_url'               => $order_query->row['store_url'],
				'customer_id'             => $order_query->row['customer_id'],
				'firstname'               => $order_query->row['firstname'],
				'lastname'                => $order_query->row['lastname'],
				'email'                   => $order_query->row['email'],
				'telephone'               => $order_query->row['telephone'],
				'fax'                     => $order_query->row['fax'],
				'custom_field'            => unserialize($order_query->row['custom_field']),
				'payment_firstname'       => $order_query->row['payment_firstname'],
				'payment_lastname'        => $order_query->row['payment_lastname'],
				'payment_company'         => $order_query->row['payment_company'],
				'payment_address_1'       => $order_query->row['payment_address_1'],
				'payment_address_2'       => $order_query->row['payment_address_2'],
				'payment_postcode'        => $order_query->row['payment_postcode'],
				'payment_city'            => $order_query->row['payment_city'],
				'payment_zone_id'         => $order_query->row['payment_zone_id'],
				'payment_zone'            => $order_query->row['payment_zone'],
				'payment_zone_code'       => $payment_zone_code,
				'payment_country_id'      => $order_query->row['payment_country_id'],
				'payment_country'         => $order_query->row['payment_country'],
				'payment_iso_code_2'      => $payment_iso_code_2,
				'payment_iso_code_3'      => $payment_iso_code_3,
				'payment_address_format'  => $order_query->row['payment_address_format'],
				'payment_custom_field'    => unserialize($order_query->row['payment_custom_field']),
				'payment_method'          => $order_query->row['payment_method'],
				'payment_code'            => $order_query->row['payment_code'],
				'shipping_firstname'      => $order_query->row['shipping_firstname'],
				'shipping_lastname'       => $order_query->row['shipping_lastname'],
				'shipping_company'        => $order_query->row['shipping_company'],
				'shipping_address_1'      => $order_query->row['shipping_address_1'],
				'shipping_address_2'      => $order_query->row['shipping_address_2'],
				'shipping_postcode'       => $order_query->row['shipping_postcode'],
				'shipping_city'           => $order_query->row['shipping_city'],
				'shipping_zone_id'        => $order_query->row['shipping_zone_id'],
				'shipping_zone'           => $order_query->row['shipping_zone'],
				'shipping_zone_code'      => $shipping_zone_code,
				'shipping_country_id'     => $order_query->row['shipping_country_id'],
				'shipping_country'        => $order_query->row['shipping_country'],
				'shipping_iso_code_2'     => $shipping_iso_code_2,
				'shipping_iso_code_3'     => $shipping_iso_code_3,
				'shipping_address_format' => $order_query->row['shipping_address_format'],
				'shipping_custom_field'   => unserialize($order_query->row['shipping_custom_field']),
				'shipping_method'         => $order_query->row['shipping_method'],
				'shipping_code'           => $order_query->row['shipping_code'],
				'comment'                 => $order_query->row['comment'],
				'total'                   => $order_query->row['total'],
				'order_status_id'         => $order_query->row['order_status_id'],
				'order_status'            => $order_query->row['order_status'],
				'affiliate_id'            => $order_query->row['affiliate_id'],
				'commission'              => $order_query->row['commission'],
				'language_id'             => $order_query->row['language_id'],
				'language_code'           => $language_code,
				'language_directory'      => $language_directory,
				'currency_id'             => $order_query->row['currency_id'],
				'currency_code'           => $order_query->row['currency_code'],
				'currency_value'          => $order_query->row['currency_value'],
				'ip'                      => $order_query->row['ip'],
				'forwarded_ip'            => $order_query->row['forwarded_ip'],
				'user_agent'              => $order_query->row['user_agent'],
				'accept_language'         => $order_query->row['accept_language'],
				'date_modified'           => $order_query->row['date_modified'],
				'date_added'              => $order_query->row['date_added']
			);
		} else {
			return false;
		}
	}

				
			public function addOrderHistory($order_id, $order_status_id, $comment = '', $notify = false, $sent_comment_to_all = false) {
			
		$this->event->trigger('pre.order.history.add', $order_id);

		$order_info = $this->getOrder($order_id);
				
		if ($order_info) {
			// Fraud Detection
			$this->load->model('account/customer');

			$customer_info = $this->model_account_customer->getCustomer($order_info['customer_id']);

			if ($customer_info && $customer_info['safe']) {
				$safe = true;
			} else {
				$safe = false;
			}

			if ($this->config->get('config_fraud_detection')) {
				$this->load->model('checkout/fraud');

				$risk_score = $this->model_checkout_fraud->getFraudScore($order_info);

				if (!$safe && $risk_score > $this->config->get('config_fraud_score')) {
					$order_status_id = $this->config->get('config_fraud_status_id');
				}
			}

			// Ban IP
			if (!$safe) {
				$status = false;

				if ($order_info['customer_id']) {
					$results = $this->model_account_customer->getIps($order_info['customer_id']);

					foreach ($results as $result) {
						if ($this->model_account_customer->isBanIp($result['ip'])) {
							$status = true;

							break;
						}
					}
				} else {
					$status = $this->model_account_customer->isBanIp($order_info['ip']);
				}

				if ($status) {
					$order_status_id = $this->config->get('config_order_status_id');
				}
			}

			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$order_status_id . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

			$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', notify = '" . (int)$notify . "', comment = '" . $this->db->escape($comment) . "', date_added = NOW()");

			// If current order status is not processing or complete but new status is processing or complete then commence completing the order
			if (!in_array($order_info['order_status_id'], array_merge($this->config->get('config_processing_status'), $this->config->get('config_complete_status'))) && in_array($order_status_id, array_merge($this->config->get('config_processing_status'), $this->config->get('config_complete_status')))) {
				// Stock subtraction
				$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

				foreach ($order_product_query->rows as $order_product) {
					$this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_id = '" . (int)$order_product['product_id'] . "' AND subtract = '1'");

					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product['order_product_id'] . "'");

					foreach ($order_option_query->rows as $option) {
						$this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_option_value_id = '" . (int)$option['product_option_value_id'] . "' AND subtract = '1'");
					}
				}

				// Redeem coupon, vouchers and reward points
				$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");

				foreach ($order_total_query->rows as $order_total) {
					$this->load->model('total/' . $order_total['code']);

					if (method_exists($this->{'model_total_' . $order_total['code']}, 'confirm')) {
						$this->{'model_total_' . $order_total['code']}->confirm($order_info, $order_total);
					}
				}

				// Add commission if sale is linked to affiliate referral.
				if ($order_info['affiliate_id'] && $this->config->get('config_affiliate_auto')) {
					$this->load->model('affiliate/affiliate');

					$this->model_affiliate_affiliate->addTransaction($order_info['affiliate_id'], $order_info['commission'], $order_id);
				}
			}

			// If old order status is the processing or complete status but new status is not then commence restock, and remove coupon, voucher and reward history
			if (in_array($order_info['order_status_id'], array_merge($this->config->get('config_processing_status'), $this->config->get('config_complete_status'))) && !in_array($order_status_id, array_merge($this->config->get('config_processing_status'), $this->config->get('config_complete_status')))) {
				// Restock
				$product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

				foreach($product_query->rows as $product) {
					$this->db->query("UPDATE `" . DB_PREFIX . "product` SET quantity = (quantity + " . (int)$product['quantity'] . ") WHERE product_id = '" . (int)$product['product_id'] . "' AND subtract = '1'");

					$option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

					foreach ($option_query->rows as $option) {
						$this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET quantity = (quantity + " . (int)$product['quantity'] . ") WHERE product_option_value_id = '" . (int)$option['product_option_value_id'] . "' AND subtract = '1'");
					}
				}

				// Remove coupon, vouchers and reward points history
				$this->load->model('account/order');

				$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");

				foreach ($order_total_query->rows as $order_total) {
					$this->load->model('total/' . $order_total['code']);

					if (method_exists($this->{'model_total_' . $order_total['code']}, 'unconfirm')) {
						$this->{'model_total_' . $order_total['code']}->unconfirm($order_id);
					}
				}

				// Remove commission if sale is linked to affiliate referral.
				if ($order_info['affiliate_id']) {
					$this->load->model('affiliate/affiliate');

					$this->model_affiliate_affiliate->deleteTransaction($order_id);
				}
			}

			$this->cache->delete('product');

			// If order status is 0 then becomes greater than 0 send main html email
			if (!$order_info['order_status_id'] && $order_status_id) {
				// Check for any downloadable products
				$download_status = false;

				$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
			
			$this->load->model('tool/upload');
			$this->db->query("UPDATE `" . DB_PREFIX . "order_product` SET order_status_id = '" . (int)$order_status_id . "' WHERE order_id = '" . (int)$order_id . "'");
			

				foreach ($order_product_query->rows as $order_product) {
					// Check if there are any linked downloads
			
			$option_data_vendor = array();
			$order_option_vendor_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product['order_product_id'] . "'");
					
			foreach ($order_option_vendor_query->rows as $option) {
				if ($option['type'] != 'file') {
					$value = $option['value'];
				} else {
					$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

					if ($upload_info) {
						$value = $upload_info['name'];
					} else {
						$value = '';
					}
				}

				$option_data_vendor[] = array(
					'name'  => $option['name'],
					'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
				);
			}						
					
			$vmail = $this->db->query("SELECT pd.name AS name, p.model AS model, p.sku AS sku, vs.email AS email, vs.vendor_id AS vendor_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "vendor v ON (pd.product_id = v.vproduct_id) LEFT JOIN " . DB_PREFIX . "vendors vs ON (v.vendor = vs.vendor_id) WHERE p.product_id = '" . (int)$order_product['product_id'] . "'");
			$vendor_products[] = array(
				'name'     => $vmail->row['name'],
				'model'    => $vmail->row['model'],
				'sku' 	   => $vmail->row['sku'],
				'option'   => $option_data_vendor,
				'quantity' => $order_product['quantity'],
				'price'	   => $order_product['price'],
				'total'	   => $order_product['total'],
				'tax'	   => $order_product['tax'],
				'vendor_id' => $vmail->row['vendor_id'],
				'email'	    => $vmail->row['email']
			);
						
			$vendor_list[] = array ('vendor_id' => $vmail->row['vendor_id']);
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_status_vendor_update SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', vendor_id = '" . (int)$vmail->row['vendor_id'] . "', product_id = '" . (int)$order_product['order_product_id'] . "'");
			
					$product_download_query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "product_to_download` WHERE product_id = '" . (int)$order_product['product_id'] . "'");

					if ($product_download_query->row['total']) {
						$download_status = true;
					}
				}
			
			$vendor_unique = array_map("unserialize", array_unique(array_map("serialize", $vendor_list)));				
			if (($this->config->get('mvd_email_status')) && (in_array((int)$order_status_id,$this->config->get('mvd_checkout_order_status')))) {
				if ($vendor_products){
					$vendor_cost = $this->getdescost();					
					foreach ($vendor_unique as $vendor) {
						if ($vendor['vendor_id']) {
							$data = array();
							$vemail = $this->db->query("SELECT *, CONCAT(firstname,' ',lastname) AS contact_name FROM `" . DB_PREFIX . "vendors` WHERE vendor_id = '" . (int)$vendor['vendor_id'] . "'");
							$cust_order_status_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
							$language = new Language($order_info['language_directory']);
							//$language->load($order_info['language_filename']);
							$language->load('mail/vendor_email');
										
							$data['text_order_details'] = $language->get('text_order_details');
							$data['text_shipping_address'] = "<b>" . $language->get('text_shipping_address') . "</b><br/>";
							$data['date_ordered'] = '<b>' . $language->get('text_date_ordered') . ' </b>' . date('F j\, Y') . '<br/>';
							$data['logo'] = HTTP_SERVER . 'image/' . $this->config->get('config_logo');
							$data['store_name'] = $order_info['store_name'];
							$data['store_url'] = $order_info['store_url'];
								
							/*Show header title*/
							$data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);		
								
							/*show vendor name*/
							$data['vendor_name'] = '<b>' . $language->get('text_title') . $vemail->row['contact_name'] . '</b>,' . "\n\n";
								
							/*show message to vendor*/
							$data['vendor_message'] = $this->config->get('mvd_new_order_message' . $this->config->get('config_language_id')) . "\n\n";
																					
							/*show vendor customer order id*/
							if ($this->config->get('mvd_show_order_id')) {
								$data['order_id'] = '<b>' . $language->get('text_vendor_order_id') . '</b>' . $order_id . '<br/>';
							} else {
								$data['order_id'] = '';
							}
								
							/*show vendor customer order status*/
							if ($this->config->get('mvd_show_order_status')) {
								$data['order_status'] = '<b>' . $language->get('text_order_status') . ' </b>' . $cust_order_status_query->row['name'] . '<br/>';
							} else {
								$data['order_status'] = '';
							}
								
							/*show payment method*/
							if ($this->config->get('mvd_show_payment_method')) {
								$data['payment_method'] = '<b>' . $language->get('text_payment_method') . ' </b>' . $order_info['payment_method'] . '<br/>';
							} else {
								$data['payment_method'] = '';
							}
								
							/*show vendor customer email*/
							if ($this->config->get('mvd_show_cust_email')) {
								$data['email_address'] = '<b>' . $language->get('text_email') . ' </b>' . $order_info['email'] . '<br/>';
							} else {
								$data['email_address'] = '';
							}
								
							/*show vendor customer telephone*/
							if ($this->config->get('mvd_show_cust_telephone')) {
								$data['telephone'] = '<b>' . $language->get('text_telephone') . ' </b>' . $order_info['telephone'] . '<br/>';
							} else {
								$data['telephone'] = '';
							}
								
							/*show vendor customer shipping address*/
							if ($this->config->get('mvd_show_cust_shipping_address')) {
								if (($order_info['shipping_firstname']) && ($order_info['shipping_address_1'])) { 
									$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
									$find = array(
									'{firstname}',
									'{lastname}',
									'{company}',
									'{address_1}',
									'{address_2}',
									'{city}',
									'{postcode}',
									'{zone}',
									'{zone_code}',
									'{country}'
									);
								
									$replace = array(
										'firstname' => $order_info['shipping_firstname'],
										'lastname'  => $order_info['shipping_lastname'],
										'company'   => $order_info['shipping_company'],
										'address_1' => $order_info['shipping_address_1'],
										'address_2' => $order_info['shipping_address_2'],
										'city'      => $order_info['shipping_city'],
										'postcode'  => $order_info['shipping_postcode'],
										'zone'      => $order_info['shipping_zone'],
										'zone_code' => $order_info['shipping_zone_code'],
										'country'   => $order_info['shipping_country']  
									);
									$data['cust_shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
								} else {
									$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
									$find = array(
										'{firstname}',
										'{lastname}',
										'{company}',
										'{address_1}',
										'{address_2}',
										'{city}',
										'{postcode}',
										'{zone}',
										'{zone_code}',
										'{country}'
									);
									
									$replace = array(
										'firstname' => $order_info['payment_firstname'],
										'lastname'  => $order_info['payment_lastname'],
										'company'   => $order_info['payment_company'],
										'address_1' => $order_info['payment_address_1'],
										'address_2' => $order_info['payment_address_2'],
										'city'      => $order_info['payment_city'],
										'postcode'  => $order_info['payment_postcode'],
										'zone'      => $order_info['payment_zone'],
										'zone_code' => $order_info['payment_zone_code'],
										'country'   => $order_info['payment_country']  
									);
									$data['cust_shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
								}
							} else {
								$data['cust_shipping_address'] = '';
							}
							
							/*show vendor information*/
							if ($this->config->get('mvd_show_vendor_address')) {
								$data['show_vendor_contact'] = True;
								$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
									$find = array(
										'{firstname}',
										'{lastname}',
										'{company}',
										'{address_1}',
										'{address_2}',
										'{city}',
										'{postcode}',
										'{zone}',
										'{country}'
									);
									
								$zone_name = $this->db->query("SELECT name FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$vemail->row['zone_id'] . "' AND country_id = '" . (int)$vemail->row['country_id'] . "'");			
								$country_name = $this->db->query("SELECT name FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$vemail->row['country_id'] . "'");	
									
									$replace = array(
										'firstname' => $vemail->row['firstname'],
										'lastname'  => $vemail->row['lastname'],
										'company'   => $vemail->row['company'],
										'address_1' => $vemail->row['address_1'],
										'address_2' => $vemail->row['address_2'],
										'city'      => $vemail->row['city'],
										'postcode'  => $vemail->row['postcode'],
										'zone'  	=> isset($zone_name->row['name']) ? $zone_name->row['name'] : 'None',
										'country'   => $country_name->row['name']
									);
										
								$vendor_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
											
								$data['vendor_address'] = $vendor_address . '<br/>';
								$data['text_vendor_contact'] = $language->get('text_vendor_contact');
									
								/*show vendor email*/
								if ($this->config->get('mvd_show_vendor_email')) {
									$data['vendor_email'] = '<b>' . $language->get('text_email') . ' </b>' . $vemail->row['email'] . '<br/>';
								} else {
									$data['vendor_email'] = '';
								}
									
								/*show vendor telephone*/
								if ($this->config->get('mvd_show_vendor_telephone')) {
									$data['vendor_telephone'] = '<b>' . $language->get('text_telephone') . ' </b>' . $vemail->row['telephone'] . '<br/>';
								} else {
									$data['vendor_telephone'] = '';
								}
					
							} else {
								$data['show_vendor_contact'] = False;
							}
							/*end show vendor address*/
								
							$coupon = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendor_discount WHERE order_id = '" . (int)$order_id . "' AND vendor_id = '" . (int)$vendor['vendor_id'] . "'");
							if (isset($coupon->row['amount']) > 0) {
								$data['coupon_title'] = $coupon->row['title'];
								$data['coupon'] = '-' . $this->currency->format($coupon->row['amount']);
							} else {
								$data['coupon'] = false;
							}
							
							$subtotal = 0;
							$vsubtotal = $this->db->query("SELECT SUM(total) AS sum_product_total, SUM(quantity*tax) as sum_product_tax FROM " . DB_PREFIX . "order_product op LEFT JOIN " . DB_PREFIX . "vendor v ON ( op.product_id = v.vproduct_id ) WHERE v.vendor =  '" . (int)$vendor['vendor_id'] . "' AND op.order_id =  '" . (int)$order_id . "'");
							$subtotal = $vsubtotal->row['sum_product_total'];
								
							$vat = $this->db->query("SELECT title FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' AND code = 'tax'");

							/*Get Shipping Cost*/
							$shipcost = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_shipping` WHERE vendor_id = '" . (int)$vendor['vendor_id'] . "' AND order_id = '" . (int)$order_id . "'");
								
							if ($this->config->get('tax_status') && ($vsubtotal->row['sum_product_tax'] != 0)) {
								$data['text_tax'] = $vat->row['title'];
								$data['tax'] = $this->currency->format($vsubtotal->row['sum_product_tax'] + (isset($shipcost->row['tax']) ? $shipcost->row['tax'] : '0') - (isset($coupon->row['tax']) ? $coupon->row['tax'] : '0'));
							} else {
								$data['tax'] = '0';
							}
									
							if ($shipcost->rows) {
								if ($shipcost->row['cost']) {
									$total = $vsubtotal->row['sum_product_total'] + $shipcost->row['cost'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] + $shipcost->row['tax'] -((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
								} else {
									$total = $vsubtotal->row['sum_product_total'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] - ((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
								}
									
								$data['shipping'] = $shipcost->row['title'] . ' (' . $this->weight->format($shipcost->row['weight'], $this->config->get('config_weight_class_id')) . ')';
								$data['scost'] = $this->currency->format($shipcost->row['cost']);
									
							} else {
								$total = $vsubtotal->row['sum_product_total'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] - ((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
								$data['scost'] = 0;
							}
										
							/*END Get Shipping Cost*/
													
							foreach ($vendor_products as $vendor_product) {
								if ($vendor['vendor_id'] == $vendor_product['vendor_id']) {
									$data['vendor_products'][] = array(
										'name'     => $vendor_product['name'],
										'option'   => $vendor_product['option'],
										'model'    => $vendor_product['model'],
										'sku'	   => $vendor_product['sku'],
										'price'	   => $this->currency->format($vendor_product['price'] + ($this->config->get('tax_status') ? $vendor_product['tax'] : 0)),
										'quantity' => $vendor_product['quantity'],
										'total'	   => $this->currency->format($vendor_product['total'] + ($this->config->get('tax_status') ? ($vendor_product['tax'] * $vendor_product['quantity']) : 0)),
										'email'    => $vendor_product['email']
									);
								}
							}
								
							$data['product'] = $language->get('column_product');
							$data['model'] = $language->get('column_model');
							$data['quantity'] = $language->get('column_quantity');
							$data['unit_price'] = $language->get('column_unit_price');
							$data['total'] = $language->get('column_total');
							$data['subtotal'] = $language->get('column_subtotal');
							$data['vendor_auto_msg'] = $language->get('text_vendor_auto_msg');
							$data['vendor_alert'] = $language->get('text_vendor_email') . $this->config->get('config_title');
							$data['vsubtotal'] = $this->currency->format($subtotal);
							$data['vtotal'] = $this->currency->format($total);

							if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/vendor_email.tpl')) {
								$html = $this->load->view($this->config->get('config_template') . '/template/mail/vendor_email.tpl', $data);
							} else {
								$html = $this->load->view('default/template/mail/vendor_email.tpl', $data);
							}
										
							$mail = new Mail($this->config->get('config_mail'));
							$mail->setTo($vemail->row['email']);
							$mail->setFrom($this->config->get('config_email'));
							$mail->setSender($this->config->get('config_name'));
							$mail->setSubject($language->get('text_vendor_email_subject') . $this->config->get('config_title'));
							$mail->setHtml($html);
							$mail->send();
						} 
					}
				}
			}
			

				// Load the language for any mails that might be required to be sent out
				$language = new Language($order_info['language_directory']);
				$language->load('default');
				$language->load('mail/order');

				$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");

				if ($order_status_query->num_rows) {
					$order_status = $order_status_query->row['name'];
				} else {
					$order_status = '';
				}

				$subject = sprintf($language->get('text_new_subject'), $order_info['store_name'], $order_id);

				// HTML Mail
				$data = array();

				$data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);

				$data['text_greeting'] = sprintf($language->get('text_new_greeting'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'));
				$data['text_link'] = $language->get('text_new_link');
				$data['text_download'] = $language->get('text_new_download');
				$data['text_order_detail'] = $language->get('text_new_order_detail');
				$data['text_instruction'] = $language->get('text_new_instruction');
				$data['text_order_id'] = $language->get('text_new_order_id');
				$data['text_date_added'] = $language->get('text_new_date_added');
				$data['text_payment_method'] = $language->get('text_new_payment_method');
				$data['text_shipping_method'] = $language->get('text_new_shipping_method');
				$data['text_email'] = $language->get('text_new_email');
				$data['text_telephone'] = $language->get('text_new_telephone');
				$data['text_ip'] = $language->get('text_new_ip');
				$data['text_order_status'] = $language->get('text_new_order_status');
				$data['text_payment_address'] = $language->get('text_new_payment_address');
				$data['text_shipping_address'] = $language->get('text_new_shipping_address');
				$data['text_product'] = $language->get('text_new_product');
				$data['text_model'] = $language->get('text_new_model');
				$data['text_quantity'] = $language->get('text_new_quantity');
				$data['text_price'] = $language->get('text_new_price');
				$data['text_total'] = $language->get('text_new_total');
				$data['text_footer'] = $language->get('text_new_footer');

				$data['logo'] = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
				$data['store_name'] = $order_info['store_name'];
				$data['store_url'] = $order_info['store_url'];
				$data['customer_id'] = $order_info['customer_id'];
				$data['link'] = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id;

				if ($download_status) {
					$data['download'] = $order_info['store_url'] . 'index.php?route=account/download';
				} else {
					$data['download'] = '';
				}

				$data['order_id'] = $order_id;
				$data['date_added'] = date($language->get('date_format_short'), strtotime($order_info['date_added']));
				$data['payment_method'] = $order_info['payment_method'];
				$data['shipping_method'] = $order_info['shipping_method'];
				$data['email'] = $order_info['email'];
				$data['telephone'] = $order_info['telephone'];
				$data['ip'] = $order_info['ip'];
				$data['order_status'] = $order_status;

				if ($comment && $notify) {
					$data['comment'] = nl2br($comment);
				} else {
					$data['comment'] = '';
				}

				if ($order_info['payment_address_format']) {
					$format = $order_info['payment_address_format'];
				} else {
					$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
				}

				$find = array(
					'{firstname}',
					'{lastname}',
					'{company}',
					'{address_1}',
					'{address_2}',
					'{city}',
					'{postcode}',
					'{zone}',
					'{zone_code}',
					'{country}'
				);

				$replace = array(
					'firstname' => $order_info['payment_firstname'],
					'lastname'  => $order_info['payment_lastname'],
					'company'   => $order_info['payment_company'],
					'address_1' => $order_info['payment_address_1'],
					'address_2' => $order_info['payment_address_2'],
					'city'      => $order_info['payment_city'],
					'postcode'  => $order_info['payment_postcode'],
					'zone'      => $order_info['payment_zone'],
					'zone_code' => $order_info['payment_zone_code'],
					'country'   => $order_info['payment_country']
				);

				$data['payment_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

				if ($order_info['shipping_address_format']) {
					$format = $order_info['shipping_address_format'];
				} else {
					$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}';
				}

				$this->load->model('tool/image');
				if ($this->request->server['HTTPS']) {
					$base = HTTPS_SERVER;
				} else {
					$base = HTTP_SERVER;
				}
				$data['top_left'] 		= $base."catalog/view/theme/default/image/top_left.png";
				$data['top_right'] 		= $base."catalog/view/theme/default/image/top_right.png";
				$data['bottom_right'] 	= $base."catalog/view/theme/default/image/bottom_right.png";
				$data['bottom_left'] 	= $base."catalog/view/theme/default/image/bottom_left.png";
				$data['base'] = $base;
				$data['config_name']    = $this->config->get('config_name');

				$find = array(
					'{firstname}',
					'{lastname}',
					'{company}',
					'{address_1}',
					'{address_2}',
					'{city}',
					'{postcode}',
					'{zone}',
					'{zone_code}',
					'{country}'
				);

				$replace = array(
					'firstname' => $order_info['shipping_firstname'],
					'lastname'  => $order_info['shipping_lastname'],
					'company'   => $order_info['shipping_company'],
					'address_1' => $order_info['shipping_address_1'],
					'address_2' => $order_info['shipping_address_2'],
					'city'      => $order_info['shipping_city'],
					'postcode'  => $order_info['shipping_postcode'],
					'zone'      => $order_info['shipping_zone'],
					'zone_code' => $order_info['shipping_zone_code'],
					'country'   => $order_info['shipping_country']
				);

				$data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

				$this->load->model('tool/upload');
			
				// Products
				$data['products'] = array();

				foreach ($order_product_query->rows as $product) {
					$option_data = array();

					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");

					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];
						} else {
							$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

							if ($upload_info) {
								$value = $upload_info['name'];
							} else {
								$value = '';
							}
						}

						$option_data[] = array(
							'name'  => $option['name'],
							'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
						);
					}

					$sql = "SELECT image FROM ".DB_PREFIX."product WHERE product_id = ".$product['product_id'];
					$result = $this->db->query($sql)->row;

					$data['products'][] = array(
						'name'     => $product['name'],
						'image'    => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height')),
						'model'    => $product['model'],
						'option'   => $option_data,
						'quantity' => $product['quantity'],
						'price'    => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
						'total'    => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value'])
					);
				}

				// Vouchers
				$data['vouchers'] = array();

				$order_voucher_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");

				foreach ($order_voucher_query->rows as $voucher) {
					$data['vouchers'][] = array(
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']),
					);
				}

				// Order Totals
				$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");

				foreach ($order_total_query->rows as $total) {
					$data['totals'][] = array(
						'title' => $total['title'],
						'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
					);
				}

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/order.tpl')) {
					$html = $this->load->view($this->config->get('config_template') . '/template/mail/order.tpl', $data);
				} else {
					$html = $this->load->view('default/template/mail/order.tpl', $data);
				}

				// Can not send confirmation emails for CBA orders as email is unknown
				$this->load->model('payment/amazon_checkout');

				if (!$this->model_payment_amazon_checkout->isAmazonOrder($order_info['order_id'])) {
					// Text Mail
					$text  = sprintf($language->get('text_new_greeting'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8')) . "\n\n";
					$text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
					$text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
					$text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";

					if ($comment && $notify) {
						$text .= $language->get('text_new_instruction') . "\n\n";
						$text .= $comment . "\n\n";
					}

					// Products
					$text .= $language->get('text_new_products') . "\n";

					foreach ($order_product_query->rows as $product) {
						$text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";

						$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");

						foreach ($order_option_query->rows as $option) {
							if ($option['type'] != 'file') {
								$value = $option['value'];
							} else {
								$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

								if ($upload_info) {
									$value = $upload_info['name'];
								} else {
									$value = '';
								}
							}

							$text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value) . "\n";
						}
					}

					foreach ($order_voucher_query->rows as $voucher) {
						$text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
					}

					$text .= "\n";

					$text .= $language->get('text_new_order_total') . "\n";

					foreach ($order_total_query->rows as $total) {
						$text .= $total['title'] . ': ' . html_entity_decode($this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";
					}

					$text .= "\n";

					if ($order_info['customer_id']) {
						$text .= $language->get('text_new_link') . "\n";
						$text .= $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
					}

					if ($download_status) {
						$text .= $language->get('text_new_download') . "\n";
						$text .= $order_info['store_url'] . 'index.php?route=account/download' . "\n\n";
					}

					// Comment
					if ($order_info['comment']) {
						$text .= $language->get('text_new_comment') . "\n\n";
						$text .= $order_info['comment'] . "\n\n";
					}

					$text .= $language->get('text_new_footer') . "\n\n";
					$mail = new Mail($this->config->get('config_mail'));
					$mail->setTo($order_info['email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender($order_info['store_name']);
					$mail->setSubject($subject);
					$mail->setHtml($html);
					$mail->setText($text);
					$mail->send();
				}

				// Admin Alert Mail
				if ($this->config->get('config_order_mail')) {
					$subject = sprintf($language->get('text_new_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $order_id);

					// HTML Mail
					$data['text_greeting'] = $language->get('text_new_received');
					
					if ($comment) {
						if ($order_info['comment']) {
							$data['comment'] = nl2br($comment) . '<br/><br/>' . $order_info['comment'];
						} else {
							$data['comment'] = nl2br($comment);
						}
					} else {
						if ($order_info['comment']) {
							$data['comment'] = $order_info['comment'];
						} else {
							$data['comment'] = '';
						}
					}
					$data['text_download'] = '';

					$data['text_footer'] = '';

					$data['text_link'] = '';
					$data['link'] = '';
					$data['download'] = '';

					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/order.tpl')) {
						$html = $this->load->view($this->config->get('config_template') . '/template/mail/order.tpl', $data);
					} else {
						$html = $this->load->view('default/template/mail/order.tpl', $data);
					}

					// Text
					$text  = $language->get('text_new_received') . "\n\n";
					$text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
					$text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
					$text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";
					$text .= $language->get('text_new_products') . "\n";

					foreach ($order_product_query->rows as $product) {
						$text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";

						$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");

						foreach ($order_option_query->rows as $option) {
							if ($option['type'] != 'file') {
								$value = $option['value'];
							} else {
								$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
							}

							$text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value) . "\n";
						}
					}

					foreach ($order_voucher_query->rows as $voucher) {
						$text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
					}

					$text .= "\n";

					$text .= $language->get('text_new_order_total') . "\n";

					foreach ($order_total_query->rows as $total) {
						$text .= $total['title'] . ': ' . html_entity_decode($this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";
					}

					$text .= "\n";

					if ($order_info['comment']) {
						$text .= $language->get('text_new_comment') . "\n\n";
						$text .= $order_info['comment'] . "\n\n";
					}

					$mail = new Mail($this->config->get('config_mail'));
					$mail->setTo($this->config->get('config_email'));
					$mail->setFrom($this->config->get('config_email'));
					$mail->setReplyTo($order_info['email']);
					$mail->setSender($order_info['store_name']);
					$mail->setSubject($subject);
					$mail->setHtml($html);
					$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
					$mail->send();

					// Send to additional alert emails
					$emails = explode(',', $this->config->get('config_mail_alert'));

					foreach ($emails as $email) {
						if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
							$mail->setTo($email);
							$mail->send();
						}
					}
				}
			}

			// If order status is not 0 then send update text email
			if ($order_info['order_status_id'] && $order_status_id) {
			
			$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
				$this->db->query("UPDATE `" . DB_PREFIX . "order_product` SET order_status_id = '" . (int)$order_status_id . "' WHERE order_id = '" . (int)$order_id . "'");
				
				foreach ($order_product_query->rows as $order_product) {				
					$option_data_vendor = array();
					$order_option_vendor_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product['order_product_id'] . "'");
					
					foreach ($order_option_vendor_query->rows as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];
						} else {
							$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

							if ($upload_info) {
								$value = $upload_info['name'];
							} else {
								$value = '';
							}
						}

						$option_data_vendor[] = array(
							'name'  => $option['name'],
							'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
						);
					}						
					
					$vmail = $this->db->query("SELECT pd.name AS name, p.model AS model, p.sku AS sku, vs.email AS email, vs.vendor_id AS vendor_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) LEFT JOIN " . DB_PREFIX . "vendor v ON (pd.product_id = v.vproduct_id) LEFT JOIN " . DB_PREFIX . "vendors vs ON (v.vendor = vs.vendor_id) WHERE p.product_id = '" . (int)$order_product['product_id'] . "'");
					$vendor_products[] = array(
						'name'     => $vmail->row['name'],
						'model'    => $vmail->row['model'],
						'sku' 	   => $vmail->row['sku'],
						'option'   => $option_data_vendor,
						'quantity' => $order_product['quantity'],
						'price'	   => $order_product['price'],
						'total'	   => $order_product['total'],
						'tax'	   => $order_product['tax'],
						'vendor_id' => $vmail->row['vendor_id'],
						'email'	    => $vmail->row['email']
					);
						
					$vendor_list[] = array ('vendor_id' => $vmail->row['vendor_id']);
					$this->db->query("INSERT INTO " . DB_PREFIX . "order_status_vendor_update SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', vendor_id = '" . (int)$vmail->row['vendor_id'] . "', product_id = '" . (int)$order_product['order_product_id'] . "'");
					
					// Check if there are any linked downloads
					$product_download_query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "product_to_download` WHERE product_id = '" . (int)$order_product['product_id'] . "'");

					if ($product_download_query->row['total']) {
						$download_status = true;
					}
				}
				
				$vendor_unique = array_map("unserialize", array_unique(array_map("serialize", $vendor_list)));				
				if (($this->config->get('mvd_email_status')) && (in_array((int)$order_status_id,$this->config->get('mvd_checkout_order_status')))) {
					if ($vendor_products){				
						foreach ($vendor_unique as $vendor) {
							if ($vendor['vendor_id']) {
								$data = array();
								$vemail = $this->db->query("SELECT *, CONCAT(firstname,' ',lastname) AS contact_name FROM `" . DB_PREFIX . "vendors` WHERE vendor_id = '" . (int)$vendor['vendor_id'] . "'");
								$cust_order_status_query = $this->db->query("SELECT name FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
								$language = new Language($order_info['language_directory']);
								//$language->load($order_info['language_filename']);
								$language->load('mail/vendor_email');
										
								$data['text_order_details'] = $language->get('text_order_details');
								$data['text_shipping_address'] = "<b>" . $language->get('text_shipping_address') . "</b><br/>";
								$data['date_ordered'] = '<b>' . $language->get('text_date_ordered') . ' </b>' . date('F j\, Y') . '<br/>';
								$data['logo'] = HTTP_SERVER . 'image/' . $this->config->get('config_logo');
								$data['store_name'] = $order_info['store_name'];
								$data['store_url'] = $order_info['store_url'];
								
								/*Show header title*/
								$data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);		
								
								/*show vendor name*/
								$data['vendor_name'] = '<b>' . $language->get('text_title') . $vemail->row['contact_name'] . '</b>,' . "\n\n";
								
								/*show message to vendor*/
								$data['vendor_message'] = $this->config->get('mvd_history_order_message' . $this->config->get('config_language_id')) . "\n\n";
																					
								/*show vendor customer order id*/
								if ($this->config->get('mvd_show_order_id')) {
									$data['order_id'] = '<b>' . $language->get('text_vendor_order_id') . '</b>' . $order_id . '<br/>';
								} else {
									$data['order_id'] = '';
								}
								
								/*show vendor customer order status*/
								if ($this->config->get('mvd_show_order_status')) {
									$data['order_status'] = '<b>' . $language->get('text_order_status') . ' </b>' . $cust_order_status_query->row['name'] . '<br/>';
								} else {
									$data['order_status'] = '';
								}
								
								/*show payment method*/
								if ($this->config->get('mvd_show_payment_method')) {
									$data['payment_method'] = '<b>' . $language->get('text_payment_method') . ' </b>' . $order_info['payment_method'] . '<br/>';
								} else {
									$data['payment_method'] = '';
								}
								
								/*show vendor customer email*/
								if ($this->config->get('mvd_show_cust_email')) {
									$data['email_address'] = '<b>' . $language->get('text_email') . ' </b>' . $order_info['email'] . '<br/>';
								} else {
									$data['email_address'] = '';
								}
								
								/*show vendor customer telephone*/
								if ($this->config->get('mvd_show_cust_telephone')) {
									$data['telephone'] = '<b>' . $language->get('text_telephone') . ' </b>' . $order_info['telephone'] . '<br/>';
								} else {
									$data['telephone'] = '';
								}
								
								/*show vendor customer shipping address*/
								if ($this->config->get('mvd_show_cust_shipping_address')) {
									if (($order_info['shipping_firstname']) && ($order_info['shipping_address_1'])) { 
										$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
										$find = array(
										'{firstname}',
										'{lastname}',
										'{company}',
										'{address_1}',
										'{address_2}',
										'{city}',
										'{postcode}',
										'{zone}',
										'{zone_code}',
										'{country}'
										);
									
										$replace = array(
											'firstname' => $order_info['shipping_firstname'],
											'lastname'  => $order_info['shipping_lastname'],
											'company'   => $order_info['shipping_company'],
											'address_1' => $order_info['shipping_address_1'],
											'address_2' => $order_info['shipping_address_2'],
											'city'      => $order_info['shipping_city'],
											'postcode'  => $order_info['shipping_postcode'],
											'zone'      => $order_info['shipping_zone'],
											'zone_code' => $order_info['shipping_zone_code'],
											'country'   => $order_info['shipping_country']  
										);
										$data['cust_shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
									} else {
										$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
										$find = array(
											'{firstname}',
											'{lastname}',
											'{company}',
											'{address_1}',
											'{address_2}',
											'{city}',
											'{postcode}',
											'{zone}',
											'{zone_code}',
											'{country}'
										);
									
										$replace = array(
											'firstname' => $order_info['payment_firstname'],
											'lastname'  => $order_info['payment_lastname'],
											'company'   => $order_info['payment_company'],
											'address_1' => $order_info['payment_address_1'],
											'address_2' => $order_info['payment_address_2'],
											'city'      => $order_info['payment_city'],
											'postcode'  => $order_info['payment_postcode'],
											'zone'      => $order_info['payment_zone'],
											'zone_code' => $order_info['payment_zone_code'],
											'country'   => $order_info['payment_country']  
										);
										$data['cust_shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
									}
								} else {
									$data['cust_shipping_address'] = '';
								}
								
								/*show vendor information*/
								if ($this->config->get('mvd_show_vendor_address')) {
									$data['show_vendor_contact'] = True;
									$format = '<b>{firstname} {lastname}</b>' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city}, {postcode}' . "\n" . '{zone}, {country}';
										$find = array(
											'{firstname}',
											'{lastname}',
											'{company}',
											'{address_1}',
											'{address_2}',
											'{city}',
											'{postcode}',
											'{zone}',
											'{country}'
										);
										
									$zone_name = $this->db->query("SELECT name FROM " . DB_PREFIX . "zone WHERE zone_id = '" . (int)$vemail->row['zone_id'] . "' AND country_id = '" . (int)$vemail->row['country_id'] . "'");			
									$country_name = $this->db->query("SELECT name FROM " . DB_PREFIX . "country WHERE country_id = '" . (int)$vemail->row['country_id'] . "'");	
									
										$replace = array(
											'firstname' => $vemail->row['firstname'],
											'lastname'  => $vemail->row['lastname'],
											'company'   => $vemail->row['company'],
											'address_1' => $vemail->row['address_1'],
											'address_2' => $vemail->row['address_2'],
											'city'      => $vemail->row['city'],
											'postcode'  => $vemail->row['postcode'],
											'zone'  	=> isset($zone_name->row['name']) ? $zone_name->row['name'] : 'None',
											'country'   => $country_name->row['name']
										);
										
									$vendor_address = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
											
									$data['vendor_address'] = $vendor_address . '<br/>';
									$data['text_vendor_contact'] = $language->get('text_vendor_contact');
									
									/*show vendor email*/
									if ($this->config->get('mvd_show_vendor_email')) {
										$data['vendor_email'] = '<b>' . $language->get('text_email') . ' </b>' . $vemail->row['email'] . '<br/>';
									} else {
										$data['vendor_email'] = '';
									}
									
									/*show vendor telephone*/
									if ($this->config->get('mvd_show_vendor_telephone')) {
										$data['vendor_telephone'] = '<b>' . $language->get('text_telephone') . ' </b>' . $vemail->row['telephone'] . '<br/>';
									} else {
										$data['vendor_telephone'] = '';
									}
					
								} else {
									$data['show_vendor_contact'] = False;
								}
								/*end show vendor address*/
								
								$coupon = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendor_discount WHERE order_id = '" . (int)$order_id . "' AND vendor_id = '" . (int)$vendor['vendor_id'] . "'");
								if (isset($coupon->row['amount']) > 0) {
									$data['coupon_title'] = $coupon->row['title'];
									$data['coupon'] = '-' . $this->currency->format($coupon->row['amount']);
								} else {
									$data['coupon'] = false;
								}
								
								$subtotal = 0;
								$vsubtotal = $this->db->query("SELECT SUM(total) AS sum_product_total, SUM(quantity*tax) as sum_product_tax FROM " . DB_PREFIX . "order_product op LEFT JOIN " . DB_PREFIX . "vendor v ON ( op.product_id = v.vproduct_id ) WHERE v.vendor =  '" . (int)$vendor['vendor_id'] . "' AND op.order_id =  '" . (int)$order_id . "'");
								$subtotal = $vsubtotal->row['sum_product_total'];
								
								$vat = $this->db->query("SELECT title FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' AND code = 'tax'");

								/*Get Shipping Cost*/
								$shipcost = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_shipping` WHERE vendor_id = '" . (int)$vendor['vendor_id'] . "' AND order_id = '" . (int)$order_id . "'");
								
								if ($this->config->get('tax_status') && ($vsubtotal->row['sum_product_tax'] != 0)) {
									$data['text_tax'] = $vat->row['title'];
									$data['tax'] = $this->currency->format($vsubtotal->row['sum_product_tax'] + (isset($shipcost->row['tax']) ? $shipcost->row['tax'] : '0') - (isset($coupon->row['tax']) ? $coupon->row['tax'] : '0'));
								} else {
									$data['tax'] = '0';
								}
									
								if ($shipcost->rows) {
									if ($shipcost->row['cost']) {
										$total = $vsubtotal->row['sum_product_total'] + $shipcost->row['cost'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] + $shipcost->row['tax'] -((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
									} else {
										$total = $vsubtotal->row['sum_product_total'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] - ((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
									}
									
									$data['shipping'] = $shipcost->row['title'] . ' (' . $this->weight->format($shipcost->row['weight'], $this->config->get('config_weight_class_id')) . ')';
									$data['scost'] = $this->currency->format($shipcost->row['cost']);
									
								} else {
									$total = $vsubtotal->row['sum_product_total'] - ((isset($coupon->row['amount'])) ? $coupon->row['amount'] : 0) + ($this->config->get('tax_status') ? ($vsubtotal->row['sum_product_tax'] - ((isset($coupon->row['tax'])) ? $coupon->row['tax'] : 0)): 0);
									$data['scost'] = 0;
								}
										
								/*END Get Shipping Cost*/
													
								foreach ($vendor_products as $vendor_product) {
									if ($vendor['vendor_id'] == $vendor_product['vendor_id']) {
										$data['vendor_products'][] = array(
											'name'     => $vendor_product['name'],
											'option'   => $vendor_product['option'],
											'model'    => $vendor_product['model'],
											'sku'	   => $vendor_product['sku'],
											'price'	   => $this->currency->format($vendor_product['price'] + ($this->config->get('tax_status') ? $vendor_product['tax'] : 0)),
											'quantity' => $vendor_product['quantity'],
											'total'	   => $this->currency->format($vendor_product['total'] + ($this->config->get('tax_status') ? ($vendor_product['tax'] * $vendor_product['quantity']) : 0)),
											'email'    => $vendor_product['email']
										);
									}
								}
								
								$data['product'] = $language->get('column_product');
								$data['model'] = $language->get('column_model');
								$data['quantity'] = $language->get('column_quantity');
								$data['unit_price'] = $language->get('column_unit_price');
								$data['total'] = $language->get('column_total');
								$data['subtotal'] = $language->get('column_subtotal');
								$data['vendor_auto_msg'] = $language->get('text_vendor_auto_msg');
								$data['vendor_alert'] = $language->get('text_vendor_email') . $this->config->get('config_title');
								$data['vsubtotal'] = $this->currency->format($subtotal);
								$data['vtotal'] = $this->currency->format($total);

								if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/vendor_email.tpl')) {
									$html = $this->load->view($this->config->get('config_template') . '/template/mail/vendor_email.tpl', $data);
								} else {
									$html = $this->load->view('default/template/mail/vendor_email.tpl', $data);
								}
										
								$mail = new Mail($this->config->get('config_mail'));
								$mail->setTo($vemail->row['email']);
								$mail->setFrom($this->config->get('config_email'));
								$mail->setSender($this->config->get('config_name'));
								$mail->setSubject($language->get('text_vendor_email_subject') . $this->config->get('config_title'));
								$mail->setHtml($html);
								$mail->send();
							} 
						}
					}
				}
			
				$language = new Language($order_info['language_directory']);
				$language->load('default');
				$language->load('mail/order');
				$data                           = array();

				$this->load->model('tool/image');
				if ($this->request->server['HTTPS']) {
					$base = HTTPS_SERVER;
				} else {
					$base = HTTP_SERVER;
				}
				$data['top_left'] 		= $base."catalog/view/theme/default/image/top_left.png";
				$data['top_right'] 		= $base."catalog/view/theme/default/image/top_right.png";
				$data['bottom_right'] 	= $base."catalog/view/theme/default/image/bottom_right.png";
				$data['bottom_left'] 	= $base."catalog/view/theme/default/image/bottom_left.png";

				$data['logo']       			= $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
				$data['store_name']    		 	= $order_info['store_name'];
				$data['text_update_order'] 	    = $language->get('text_update_order');
				$data['order_id']               = $order_id;
				$data['base']                   = $base;
				$data['text_update_date_added'] = $language->get('text_update_date_added');
				$data['date_added']             = date($language->get('date_format_short'), strtotime($order_info['date_added']));
				$data['config_name']            = $this->config->get('config_name');

				$subject = sprintf($language->get('text_update_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);
				$data['title'] = $subject;

				$message  = $language->get('text_update_order') . ' ' . $order_id . "\n";
				$message .= $language->get('text_update_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n\n";

				$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");

				if ($order_status_query->num_rows) {
					$message .= $language->get('text_update_order_status') . "\n\n";
					$message .= $order_status_query->row['name'] . "\n\n";

					$data['text_update_order_status'] = $language->get('text_update_order_status');
					$data['order_status'] = $order_status_query->row['name'];
				} else {
					$data['text_update_order_status'] = '';
					$data['order_status'] = '';
				}

				if ($order_info['customer_id']) {
					$message .= $language->get('text_update_link') . "\n";
					$message .= $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
					$data['text_update_link'] = $language->get('text_update_link');
					$data['update_link'] = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_id;
				} else {
					$data['text_update_link'] = '';
					$data['update_link'] = '';
				}

				if ($notify && $comment) {
					$message .= $language->get('text_update_comment') . "\n\n";
								
			if ($notify && $sent_comment_to_all) {
				$getComments = $this->getVendorComment($order_id);
					foreach ($getComments AS $Comment) {
						if ($Comment['comment']) {
							$message .= strip_tags(html_entity_decode($Comment['comment'], ENT_QUOTES, 'UTF-8')) . "\n\n";
						}
					}
			} else {
				$message .= strip_tags($comment) . "\n\n";
			}
			
					$data['text_update_comment'] = $language->get('text_update_comment');
					$data['comment'] = nl2br($comment);
				} else {
					$data['text_update_comment'] = '';
					$data['comment'] = '';
				}

				$message .= $language->get('text_update_footer');
				$data['text_update_footer'] = $language->get('text_update_footer');

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/orderUpdate.tpl')) {
					$html = $this->load->view($this->config->get('config_template') . '/template/mail/orderUpdate.tpl', $data);
				} else {
					$html = $this->load->view('default/template/mail/orderUpdate.tpl', $data);
				}

				$mail = new Mail($this->config->get('config_mail'));
				$mail->setTo($order_info['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($order_info['store_name']);
				$mail->setSubject($subject);
				$mail->setHtml($html);
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
			}

			// If order status in the complete range create any vouchers that where in the order need to be made available.
			if (in_array($order_info['order_status_id'], $this->config->get('config_complete_status'))) {
				// Send out any gift voucher mails
			
			$vendor_cost = $this->getdescost();	
			$getUniVenId = array_map("unserialize", array_unique(array_map("serialize", $getVenIds)));
			foreach ($getUniVenId as $vendor) {
				if (!empty($this->session->data['shipping_method'])) {
					if ($vendor['vendor_id']) {
						if (preg_match("/\bmvdm_flat\b/i", $this->session->data['shipping_method']['code'])) {
							
							$final_couriers = array();
							foreach($this->mvdm_flat_shipping() as $courier) {
								if (substr($this->session->data['shipping_method']['code'],19) == $courier['courier_id']) {
									$getVendor = $this->db->query("SELECT vendor FROM `" . DB_PREFIX . "vendor` WHERE vproduct_id = '" . (int)$courier['product_id'] . "'");
									$final_couriers[] = array (
										'vendor_id'	=> $getVendor->row['vendor'],
										'cost'		=> $courier['cost'],
										'weight'	=> $courier['weight']
									);	
										
								}
							}
								
							$scost = 0;
							$sweight = 0;							
							foreach ($final_couriers as $final_courier) {
								if ($vendor['vendor_id'] == $final_courier['vendor_id']) {
									$scost += $final_courier['cost'];
									$sweight += $final_courier['weight'];
								}
							}
								
							if ($this->config->get('mvdm_flat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvdm_flat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$couriername = $this->db->query("SELECT courier_name FROM `" . DB_PREFIX . "courier` WHERE courier_id = '" . (int)(substr($this->session->data['shipping_method']['code'],19)) . "'");
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = '" . $this->db->escape($couriername->row['courier_name']) . "', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
								
						} elseif ($this->session->data['shipping_method']['code'] == 'mvweight.mvweight') {
							$scost = 0;
							$sweight = 0;
											
							foreach ($vendor_cost as $vsc) {
								if ($vendor['vendor_id'] == $vsc['vendor_id']) {
									$scost = $vsc['cost'];
									$sweight = $vsc['weight'];
								}
							}
								
							if ($this->config->get('mvweight_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvweight_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Weight Base Shipping', cost =  '" . (float)$scost . "', tax =  '" . (float)$shipping_tax . "', weight = '" . (float)$sweight . "'");
							
						} elseif ($this->session->data['shipping_method']['code'] == 'mvflat.mvflat') {			
							$mv_flat = $this->mv_flat_shipping();
							$scost = 0;
							$sweight = 0;
				
							foreach ($mv_flat as $mvflat) {
								if ($vendor['vendor_id'] == $mvflat['vendor']) {
									$scost += $mvflat['cost'];
									$sweight += $mvflat['weight'];
								}
							}
								
							if ($this->config->get('mvflat_tax_class_id')) {
								$shipping_tax = $this->tax->calculate($scost, $this->config->get('mvflat_tax_class_id'), $this->config->get('config_tax')) - $scost;
							} else {
								$shipping_tax = '0';
							}
								
							$this->db->query("INSERT INTO " . DB_PREFIX . "order_shipping SET order_id = '" . (int)$order_id . "', vendor_id =  '" . (int)$vendor['vendor_id'] . "', title = 'Flat Rate Shipping', tax =  '" . (float)$shipping_tax . "', cost =  '" . (float)$scost . "', weight = '" . (float)$sweight . "'");
						}
					}
				}
			}
			
				$this->load->model('checkout/voucher');

				$this->model_checkout_voucher->confirm($order_id);
			}
		}

		$this->event->trigger('post.order.history.add', $order_id);
	}
			
				Private function getdescost() {
				$purchase_product = array();
				$vendor_country = array();
				$product_vendor = array();
				$purchase_data =array();
				$filtered_geo_zone_id = array();
				$vendor_data = array();
						
				$address = array();
				if (isset($this->session->data['shipping_address']['address_id']) && $this->session->data['shipping_address']['address_id']) { 
					$this->load->model('account/address');
					$address = $this->model_account_address->getAddress($this->session->data['shipping_address']['address_id']);
				} elseif (isset($this->session->data['payment_address']['address_id']) && $this->session->data['payment_address']['address_id']) { 
					$this->load->model('account/address');
					$address = $this->model_account_address->getAddress($this->session->data['payment_address']['address_id']);
				} else { 
					$address = (isset($this->session->data['guest'])) ? $this->session->data['guest'] : array();
				}
				
				if (!empty($address)) {
					$country_id	= (isset($address['country_id'])) ? $address['country_id'] : $this->request->post['country_id'];
					$zone_id 	= (isset($address['zone_id'])) ? $address['zone_id'] : $this->request->post['zone_id'];
				} else {
					$country_id	= $this->session->data['payment_address']['country_id'];
					$zone_id 	= $this->session->data['payment_address']['zone_id'];
				}

				foreach ($this->cart->getProducts() as $product) {
					if ($product['shipping']) {
						$purchase_product = $this->db->query("SELECT vs.vendor_id AS vendor_id, vs.country_id as country_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "vendor v ON (p.product_id = v.vproduct_id) LEFT JOIN " . DB_PREFIX . "vendors vs ON (v.vendor = vs.vendor_id) WHERE p.product_id = '" . (int)$product['product_id'] . "'");
							$purchase_data[] = array (
								'product_id'  	=> $product['product_id'],
								'weight'		=> (float)$product['weight'],
								'country_id'	=> $purchase_product->row['country_id'],
								'vendor_id'		=> $purchase_product->row['vendor_id']
							);
									
						$vendor_country[] = $purchase_product->row['country_id'];
						$product_vendor[] = array ('vendor_id'	=> $purchase_product->row['vendor_id']);
					}
				}
							
				$scountry = array_filter(array_unique($vendor_country));
				$svendor = array_map("unserialize", array_unique(array_map("serialize", $product_vendor)));
							
				$pquery = $this->db->query("SELECT * FROM " . DB_PREFIX . "geo_zone ORDER BY geo_zone_id");
				$pgetvendors = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendors");

				foreach ($pquery->rows as $geo_zone) {
					if (in_array($this->config->get('mvweight_' . $geo_zone['geo_zone_id'] . '_scountry'),$scountry)) { 
						foreach ($pgetvendors->rows as $getvendor) {
							if ($this->config->get('mvweight_' . $geo_zone['geo_zone_id'] . '_vendors')) {
								if (in_array($getvendor['vendor_id'],$this->config->get('mvweight_' . $geo_zone['geo_zone_id'] . '_vendors'))) {
									$filtered_geo_zone_id[] = array('geo_zone'	=>	(int)$geo_zone['geo_zone_id']);
								}
							}
						}
					} 
				}
							
				$desGeoZone = array_map("unserialize", array_unique(array_map("serialize", $filtered_geo_zone_id)));
					
				$group_total_weight = 0;
				foreach ($svendor as $vendor) {
					${'group_' . $vendor['vendor_id'] . '_weight'} = '';
					foreach ($purchase_data as $pd_weight) {
						if (isset($pd_weight['product_id'])) {
							if ($pd_weight['vendor_id'] == $vendor['vendor_id']) {
								${'group_' . $vendor['vendor_id'] . '_weight'} += $pd_weight['weight'];
							}
						}
					}
					${'get_group_vendor_id_' . $vendor['vendor_id'] . '_weight'} = 'group_vendor_id_' . $vendor['vendor_id'] . '_weight';
					$group_total_weight += ${'group_' . $vendor['vendor_id'] . '_weight'};
				}
						
				foreach ($desGeoZone as $geo_zone) {
					if ($this->config->get('mvweight_' . (int)$geo_zone['geo_zone'] . '_status')) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$geo_zone['geo_zone'] . "' AND country_id = '" . (int)$country_id . "' AND (zone_id = '" . (int)$zone_id . "' OR zone_id = '0')");
								
						if ($query->num_rows) {
							$status = true;
						} else {
							$status = false;
						}
									
					} else {
						$status = false;
					}
								
					if ($status) {
						foreach ($svendor as $vendor) {
							if (in_array(preg_replace("/[^0-9]/", '', ${'get_group_vendor_id_' . $vendor['vendor_id'] . '_weight'}), $this->config->get('mvweight_' . (int)$geo_zone['geo_zone'] . '_vendors'))) {
								$weight = ${'group_' . $vendor['vendor_id'] . '_weight'};
								$rates = explode(',', $this->config->get('mvweight_' . (int)$geo_zone['geo_zone'] . '_rate'));
								foreach ($rates as $rate) {
									$data = explode(':', $rate);
									if ($data[0] >= $weight) {
										if (isset($data[1])) {
											$vendor_data[] = array(
												'vendor_id'	=>	$vendor['vendor_id'],
												'cost'		=>	$data[1],
												'weight'	=>	(float)$weight
											);
										}
										break;
									}
								}
							}
						}
					}
				}
				return $vendor_data;
			}
				
			Private function mv_flat_shipping() {
						
				$mv_flat_data = array();		
				foreach ($this->cart->getProducts() as $product) {
					if ($product['shipping']) {
						$vproduct = $this->db->query("SELECT v.vendor, v.prefered_shipping, v.shipping_cost, p.weight FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "vendor v ON (p.product_id = v.vproduct_id) WHERE p.product_id = '" . (int)$product['product_id'] . "'");
							if ($this->config->get('mvflat_shipping_method') == $vproduct->row['prefered_shipping']) {
								$mv_flat_data[] = array (
									'vendor' 	=> (int)$vproduct->row['vendor'],
									'weight'	=> (float)$vproduct->row['weight']*$product['quantity'],
									'cost'		=> (float)$vproduct->row['shipping_cost']*$product['quantity']
									);
							}
					}
				}
				return $mv_flat_data;
			}
				
			Private function mvdm_flat_shipping() {
						
				$valid_courier = array();
				$shipping_courier = array();		
				$shipping_pool = array();
				$validate_shipping_method = TRUE;
				$num_of_shipping_products = 0;
					
				$address = array();
				if (isset($this->session->data['shipping_address']['address_id']) && $this->session->data['shipping_address']['address_id']) { 
					$this->load->model('account/address');
					$address = $this->model_account_address->getAddress($this->session->data['shipping_address']['address_id']);
				} elseif (isset($this->session->data['payment_address']['address_id']) && $this->session->data['payment_address']['address_id']) { 
					$this->load->model('account/address');
					$address = $this->model_account_address->getAddress($this->session->data['payment_address']['address_id']);
				} else { 
					$address = (isset($this->session->data['guest'])) ? $this->session->data['guest'] : array();
				}

				$country_id	= (isset($address['country_id'])) ? $address['country_id'] : $this->request->post['country_id'];
				$zone_id 	= (isset($address['zone_id'])) ? $address['zone_id'] : $this->request->post['zone_id'];

				foreach ($this->cart->getProducts() as $product) {
					if ($product['shipping']) {
						$query_shipping_data = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_shipping WHERE product_id = '" . (int)$product['product_id'] . "' ORDER BY product_shipping_id");
						if ($query_shipping_data->rows) {
							foreach ($query_shipping_data->rows as $courier) {
								$valid_destination = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$courier['geo_zone_id'] . "' AND country_id = '" . (int)$country_id . "' AND (zone_id = '" . (int)$zone_id . "' OR zone_id = '0')");
								if ($valid_destination->row) {
									$shipping_couriers[] = array(
										'product_id'	=>	$courier['product_id'],
										'courier_id'	=>	$courier['courier_id'],
										'shipping_rate'	=>	$product['quantity']*$courier['shipping_rate'],
										'weight'		=>	$product['weight'],
										'geo_zone_id'	=>	$courier['geo_zone_id']
									);
								}
							}
						}
						$num_of_shipping_products++;
					}				
				}
					
				foreach ($shipping_couriers as $shipping_courier) {
					$i=0;
					foreach ($shipping_couriers as $shipping_compare) {
						if ($shipping_courier['courier_id'] == $shipping_compare['courier_id']) {						
							$i++;
						}
					}
							
					if ($num_of_shipping_products == $i) {
						$valid_courier[] = array (
							'courier_id'	=> $shipping_courier['courier_id']
						);
					}
				}

				$available_shipping_methods = array_map("unserialize", array_unique(array_map("serialize", $valid_courier)));
				foreach ($available_shipping_methods as $shipping_method) {
					foreach($shipping_couriers as $shipping_courier) {
						if ($shipping_method['courier_id'] == $shipping_courier['courier_id'] ) {
							$shipping_pool[] = array(
								'product_id'	=>	$shipping_courier['product_id'],
								'courier_id'	=>	$shipping_courier['courier_id'],
								'cost'			=>	$shipping_courier['shipping_rate'],
								'weight'		=>	$shipping_courier['weight']
							);
						}
					}				
				}
				return $shipping_pool;		
			}
				
			Public function PaymentGateway() {		
				$products = $this->cart->getProducts();
				$identical_vendor = true;
					
				if ($products) {				
					foreach ($products as $product) {
						if ($product) {
							$getVID = $this->db->query("SELECT vendor FROM " . DB_PREFIX . "vendor WHERE vproduct_id = '" . (int)$product['product_id'] . "'");						
							if ($getVID->row) {
								foreach ($products as $product1) {
									if ($product1) {
										$getVID2 = $this->db->query("SELECT vendor FROM " . DB_PREFIX . "vendor WHERE vproduct_id = '" . (int)$product1['product_id'] . "'");
										if ($getVID->row['vendor'] == $getVID2->row['vendor']) {									
											$vendor_id = $getVID->row['vendor'];
										} else {
											$identical_vendor = false;
										}			
									}
								}
							}
						}
					}
				} else {
					$identical_vendor = false;
				}

				if ($identical_vendor && $getVID->row) {
					$getPaymentInfo = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendors WHERE vendor_id = '" . (int)$vendor_id . "'");
					return $getPaymentInfo->row;
				} else {
					return false;
				}
			}
				
			Public function MSPPCallback($order_info) {
				if ($order_info) {
					$getVendorID = $this->db->query("SELECT vendor_id FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_info . "' LIMIT 1");
					$getEmail = $this->db->query("SELECT * FROM " . DB_PREFIX . "vendors WHERE vendor_id = '" . (int)$getVendorID->row['vendor_id'] . "'");
					return $getEmail->row;
				} else {
					return false;
				}
			}

			public function getVendorComment($order_id) {
				$query = $this->db->query("SELECT comment FROM " . DB_PREFIX . "order_history WHERE order_id = '" . (int)$order_id . "' ORDER BY order_history_id DESC");
				return $query->rows;
			}
			
}