<?php
class ModelAccountCustomer extends Model {
	public function addCustomer($data) {
		$this->event->trigger('pre.customer.add', $data);

		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		$this->load->model('account/customer_group');

		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

		$this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int)$customer_group_id . "', store_id = '" . (int)$this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? serialize($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int)$data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int)!$customer_group_info['approval'] . "', date_added = NOW()");

		$customer_id = $this->db->getLastId();

		$this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int)$customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city_id = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['address']) ? serialize($data['custom_field']['address']) : '') . "'");

		$address_id = $this->db->getLastId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$customer_id . "'");
		
		/* COUPON NEWSLETTER WHEN CUSTOMER REGISTER
		 * author: Stephanus Budiwijaya
		 * contact: @stephanusB (twitter)
		 * date: April 16th 2015
		 * desc:
		 *  if enabled, when customer register, system will generate coupon which setting is based on from coupon newsletter from admin site
		 *  coupon code will generate randomly and will be sent to customer within email registration
		 *  coupon code can only be used once per customer & will be valid for only 7 days since coupon code is generated		 
		*/
		
		if($this->config->get('config_newsletter_status') && isset($data['newsletter']))  {
			
			//run this code only if enabled	
			
			//find if email already registered in newsletter
			$query = $this->db->query("SELECT newsletter_email FROM newsletter WHERE newsletter_email = '".$this->db->escape($data['email'])."'");

			if (!$query->row) { 
	      
	      //register email in newsletter
	      $this->db->query("INSERT INTO " . DB_PREFIX . "newsletter SET 
	                        newsletter_email = '" . $this->db->escape($data['email']) . "', 
	                        newsletter_status = ".(isset($data['newsletter']) ? (int)$data['newsletter'] : 0));

	      $newsletter_id = $this->db->getLastId();

	      //create coupon
	      $code = substr(base_convert(sha1(uniqid(mt_rand())), 16, 36), 0, 10);	      
	      $this->db->query("INSERT INTO " . DB_PREFIX . "coupon SET 
	                        newsletter_id = ".$newsletter_id.",
	                        name = '".$this->db->escape($this->db->escape($data['email']))." newsletter', 
	                        code = '" . $this->db->escape($code) . "', 
	                        discount = '" . $this->config->get('config_newsletter_discount') . "', 
	                        type = 'F'  , 
	                        total = '" . $this->config->get('config_newsletter_total') . "', 
	                        logged = '" . $this->config->get('config_newsletter_logged') . "', 
	                        shipping = '" . $this->config->get('config_newsletter_shipping') . "', 
	                        date_start = NOW(), 
	                        date_end = DATE_ADD(NOW(),INTERVAL 1 WEEK), 
	                        uses_total = 1, 
	                        uses_customer = 1, 	                        
	                        status = '" . $this->config->get('config_newsletter_status') . "', 
	                        date_added = NOW()");

	      $amount = $this->currency->format($this->config->get('config_newsletter_discount'), $this->config->get('config_currency'));
	      $total  = $this->currency->format($this->config->get('config_newsletter_total'), $this->config->get('config_currency'));	      	      
	    }
		}
    
    // -------------------------

		$this->load->language('mail/customer');

		$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

		$message = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";

		if (!$customer_group_info['approval']) {
			$message .= $this->language->get('text_login') . "\n";
			$data['text_login'] = $this->language->get('text_login');
		} else {
			$message .= $this->language->get('text_approval') . "\n";
			$data['text_login'] = $this->language->get('text_approval');
		}

		$message .= $this->url->link('account/login', '', 'SSL') . "\n\n";
		$message .= sprintf($this->language->get('text_coupon'), $amount, $total) . "\n\n";
		$message .= sprintf($this->language->get('text_coupon_code'), $code) . "\n\n";
		$message .= sprintf($this->language->get('text_coupon_valid'), date('d M Y'), date("d M Y",strtotime("+1 week"))) . "\n\n";
		$message .= $this->language->get('text_services') . "\n\n";
		$message .= $this->language->get('text_thanks') . "\n";
		$message .= $this->config->get('config_name');

		$this->load->model('tool/image');
		if ($this->request->server['HTTPS']) {
			$base = HTTPS_SERVER;
		} else {
			$base = HTTP_SERVER;
		}
		$data['top_left'] 		= $base."catalog/view/theme/default/image/top_left.png";
		$data['top_right'] 		= $base."catalog/view/theme/default/image/top_right.png";
		$data['bottom_right'] = $base."catalog/view/theme/default/image/bottom_right.png";
		$data['bottom_left'] 	= $base."catalog/view/theme/default/image/bottom_left.png";

		$data['logo']       	  = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
		$data['title']          = $subject;
		$data['store_name']     = $this->config->get('config_name');
		$data['text_greeting']  = sprintf($this->language->get('text_welcome'), $this->config->get('config_name'));
		$data['link']           = $this->url->link('account/login', '', 'SSL');
		$data['text_services']  = $this->language->get('text_services');
		$data['text_thanks']    = $this->language->get('text_thanks');
		$data['config_name']    = $this->config->get('config_name');
		$data['base']           = $base;

		$data['text_coupon']       = sprintf($this->language->get('text_coupon'), $amount, $total);
		$data['text_coupon_code']  = sprintf($this->language->get('text_coupon_code'), $code);
		$data['text_coupon_valid'] = sprintf($this->language->get('text_coupon_valid'), date('d M Y'), date("d M Y",strtotime("+1 week")));
		
		$data['text_hot_products'] = $this->language->get('text_hot_products');

		$filter_data = array(
			'sort'  => 'p.sort_order',
			'order' => 'ASC',
			'start' => 0,
			'limit' => 4
		);

		$sql = 'SELECT setting FROM oc_module WHERE code = "featured"';
		$query = $this->db->query($sql);
		foreach ($query->rows  as $key => $value) {
			$setting =  unserialize($value['setting']);
		}

		$filter_data['featured_products_id'] = $setting['product'];
		$this->load->model('catalog/product');
		$this->load->model('tool/image');
		$results = $this->model_catalog_product->getProductsFeatured($filter_data);		
		
		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize($result['image'], 110, 110);
			} else {
				$image = $this->model_tool_image->resize('placeholder.png', 110, 110);
			}

			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$price = false;
			}

			if ((float)$result['special']) {
				$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
			} else {
				$special = false;
			}

			if ($this->config->get('config_tax')) {
				$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
			} else {
				$tax = false;
			}

			if ($this->config->get('config_review_status')) {
				$rating = (int)$result['rating'];
			} else {
				$rating = false;
			}

			$data['products'][] = array(				
				'thumb'       => $image,
				'name'        => $result['name'],				
				'price'       => $price,
				'special'     => $special,							
				'href'        => $this->url->link('product/product', 'product_id=' . $result['product_id'] . $url)
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/register.tpl')) {
			$html = $this->load->view($this->config->get('config_template') . '/template/mail/register.tpl', $data);
		} else {
			$html = $this->load->view('default/template/mail/register.tpl', $data);
		}

		$mail = new Mail($this->config->get('config_mail'));
		$mail->setTo($data['email']);
		$mail->setFrom($this->config->get('config_email'));
		$mail->setSender($this->config->get('config_name'));
		$mail->setSubject($subject);
		$mail->setHtml($html);
		$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
		$mail->send();

		// Send to main admin email if new account email is enabled
		if ($this->config->get('config_account_mail')) {
			$message  = $this->language->get('text_signup') . "\n\n";
			$message .= $this->language->get('text_website') . ' ' . $this->config->get('config_name') . "\n";
			$message .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
			$message .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
			$message .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";
			$message .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
			$message .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";

			$mail->setTo($this->config->get('config_email'));
			$mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();

			// Send to additional alert emails if new account email is enabled
			$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}
		}

		$this->event->trigger('post.customer.add', $customer_id);

		return $customer_id;
	}

	public function editCustomer($data) {
		$this->event->trigger('pre.customer.edit', $data);

		$customer_id = $this->customer->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']) ? serialize($data['custom_field']) : '') . "' WHERE customer_id = '" . (int)$customer_id . "'");

		$this->event->trigger('post.customer.edit', $customer_id);
	}

	public function editPassword($email, $password) {
		$this->event->trigger('pre.customer.edit.password');

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		$this->event->trigger('post.customer.edit.password');
	}

	public function editNewsletter($newsletter) {
		$this->event->trigger('pre.customer.edit.newsletter');

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int)$newsletter . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		$this->db->query("UPDATE " . DB_PREFIX . "newsletter SET newsletter_status = '" . (int)$newsletter . "' WHERE newsletter_email = '" . $this->customer->getEmail() . "'");

		$this->event->trigger('post.customer.edit.newsletter');
	}

	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->row;
	}

	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getCustomerByToken($token) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");

		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");

		return $query->row;
	}

	public function getTotalCustomersByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}

	public function getIps($customer_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int)$customer_id . "'");

		return $query->rows;
	}

	public function isBanIp($ip) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ban_ip` WHERE ip = '" . $this->db->escape($ip) . "'");

		return $query->num_rows;
	}
	
	public function addLoginAttempt($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_login WHERE email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");
		
		if (!$query->num_rows) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "customer_login SET email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', total = 1, date_added = '" . $this->db->escape(date('Y-m-d H:i:s')) . "', date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "customer_login SET total = (total + 1), date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "' WHERE customer_login_id = '" . (int)$query->row['customer_login_id'] . "'");
		}			
	}	
	
	public function getLoginAttempts($email) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}
	
	public function deleteLoginAttempts($email) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}	
}