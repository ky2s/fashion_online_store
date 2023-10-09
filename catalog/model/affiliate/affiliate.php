<?php
class ModelAffiliateAffiliate extends Model {
	public function addAffiliate($data) {
		$this->event->trigger('pre.affiliate.add', $data);

		if(!empty($data['name']))
		{
			$customer_name = explode(' ',$data['name']);
			$data['firstname']='';
			$data['lastname'] = '';
			if(isset($customer_name[0])){
				$data['firstname'] = $customer_name[0];
			}
			if(isset($customer_name[1])) {
				$data['lastname'] .= $customer_name[1];
			}
			if(isset($customer_name[2])) {
				$data['lastname'] .= ' '.$customer_name[2];
			}
			if(isset($customer_name[3])) {
				$data['lastname'] .= ' '.$customer_name[3];
			}
		}

		$code = trim(strtolower(str_replace(' ','',$data['name'])));
		//$code = sha1($code);
		if($code){	
			// do{
			// 	$affiliate = $this->checkAffiliateCode($code);
			// 	if($affiliate) {					
					
			// 		$str = explode('-',$affiliate['code']);
			// 		$last = end($str);

			// 		if ((int)$last != 0) {
			// 		    $key = key($str);  
			// 		    $str[$key] = (int)$last + 1;
			// 		    $code = implode($str,'-');					    
			// 		} else {
			// 		    $code .= '-1';
			// 		}				
			// 	}
			// 	else{
			// 		break;
			// 	}	

			// }
			// while( $affiliate );	
			$affiliate = $this->checkAffiliateCode($code);

			if($affiliate){
				$str = explode('-',$affiliate['code']);
				$last = end($str);

				if ((int)$last != 0) {
				    $key = key($str);  
				    $str[$key] = (int)$last + 1;
				    $code = implode($str,'-');					    
				} else {
				    $code .= '-1';
				}	
			}					
		}
		
		$sql = "INSERT INTO " . DB_PREFIX . "affiliate SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', company = '" . $this->db->escape($data['company']) . "', website = '" . $this->db->escape($data['website']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city_id = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "', code = '" . $this->db->escape($code) . "', commission = '" . (float)$this->config->get('config_affiliate_commission') . "', tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', paypal = '" . $this->db->escape($data['paypal']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "', status = '1', approved = '" . (int)!$this->config->get('config_affiliate_approval') . "', date_added = NOW()";
		
		$this->db->query($sql);

		$affiliate_id = $this->db->getLastId();

		//add url alias
		$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'referral_id=" . (int)$affiliate_id . "', keyword = '" . strtolower($this->db->escape($code)) . "'");
		
		$this->event->trigger('post.affiliate.add', $affiliate_id);

		return $affiliate_id;
	}

	public function checkAffiliateCode($affiliate_code) {
		$query = $this->db->query("SELECT " . DB_PREFIX . "affiliate.code FROM " . DB_PREFIX . "affiliate WHERE " . DB_PREFIX . "affiliate.code LIKE '%" . $affiliate_code . "%' ORDER BY date_added DESC");

		return $query->num_rows;
	}

	public function editAffiliate($data) {
		$this->event->trigger('pre.affiliate.edit', $data);

		if(!empty($data['name']))
		{
			$customer_name = explode(' ',$data['name']);
			$data['firstname']='';
			$data['lastname'] = '';
			if(isset($customer_name[0])){
				$data['firstname'] = $customer_name[0];
			}
			if(isset($customer_name[1])) {
				$data['lastname'] .= $customer_name[1];
			}
			if(isset($customer_name[2])) {
				$data['lastname'] .= ' '.$customer_name[2];
			}
			if(isset($customer_name[3])) {
				$data['lastname'] .= ' '.$customer_name[3];
			}
		}

		$affiliate_id = $this->affiliate->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', company = '" . $this->db->escape($data['company']) . "', website = '" . $this->db->escape($data['website']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city_id = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int)$data['country_id'] . "', zone_id = '" . (int)$data['zone_id'] . "' WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		$this->event->trigger('post.affiliate.edit', $affiliate_id);
	}

	public function editAffiliateFromCustomer($data) {

		$this->event->trigger('pre.affiliate.edit', $data);

		if(!empty($data['name']))
		{
			$customer_name = explode(' ',$data['name']);
			$data['firstname']='';
			$data['lastname'] = '';
			if(isset($customer_name[0])){
				$data['firstname'] = $customer_name[0];
			}
			if(isset($customer_name[1])) {
				$data['lastname'] .= $customer_name[1];
			}
			if(isset($customer_name[2])) {
				$data['lastname'] .= ' '.$customer_name[2];
			}
			if(isset($customer_name[3])) {
				$data['lastname'] .= ' '.$customer_name[3];
			}
		}

		$affiliate_id = $this->affiliate->getId();

		$sql = "UPDATE " . DB_PREFIX . "affiliate SET ";

		if(isset($data['firstname'])){
			$sql .= "firstname = '" . $this->db->escape($data['firstname']) . "'";
		}

		if(isset($data['lastname'])){
			$sql .= ",lastname = '" . $this->db->escape($data['lastname']) . "'"; 
		}

		if(isset($data['email'])){
			$sql .= ",email = '" . $this->db->escape($data['email']) . "'"; 
		}

		if(isset($data['telephone'])){
			$sql .= ",telephone = '" . $this->db->escape($data['telephone']) . "'"; 
		}

		if(isset($data['fax'])){
			$sql .= ",fax = '" . $this->db->escape($data['fax']) . "', "; 
		}

		if(isset($data['company'])){
			$sql .= ",company = '" . $this->db->escape($data['company']) . "'"; 
		}

		if(isset($data['website'])){
			$sql .= ",website = '" . $this->db->escape($data['website']) . "'"; 
		}

		if(isset($data['address_1'])){
			$sql .= ",address_1 = '" . $this->db->escape($data['address_1']) . "'"; 
		}

		if(isset($data['address_2'])){
			$sql .= ",address_2 = '" . $this->db->escape($data['address_2']) . "'"; 
		}

		if(isset($data['city'])){
			$sql .= ",city_id = '" . $this->db->escape($data['city']) . "'"; 
		}

		if(isset($data['postcode'])){
			$sql .= ",postcode = '" . $this->db->escape($data['postcode']) . "'"; 
		}

		if(isset($data['country_id'])){
			$sql .= ",country_id = '" . (int)$data['country_id'] . "'"; 
		}

		if(isset($data['zone_id'])){
			$sql .= ",zone_id = '" . (int)$data['zone_id'] . "'"; 
		}

		$sql .= " WHERE affiliate_id = '" . (int)$affiliate_id . "'";
		/*$this->db->query("
			UPDATE " . DB_PREFIX . "affiliate SET 
				firstname = '" . $this->db->escape($data['firstname']) . "', 
				lastname = '" . $this->db->escape($data['lastname']) . "', 
				email = '" . $this->db->escape($data['email']) . "', 
				telephone = '" . $this->db->escape($data['telephone']) . "', 
				fax = '" . $this->db->escape($data['fax']) . "', 
				company = '" . $this->db->escape($data['company']) . "', 
				website = '" . $this->db->escape($data['website']) . "', 
				address_1 = '" . $this->db->escape($data['address_1']) . "', 
				address_2 = '" . $this->db->escape($data['address_2']) . "', 
				city_id = '" . $this->db->escape($data['city']) . "', 
				postcode = '" . $this->db->escape($data['postcode']) . "', 
				country_id = '" . (int)$data['country_id'] . "', 
				zone_id = '" . (int)$data['zone_id'] . "' 
			WHERE affiliate_id = '" . (int)$affiliate_id . "'");*/
			
		$this->db->query($sql);

		$this->event->trigger('post.affiliate.edit', $affiliate_id);
	}

	public function editPayment($data) {
		$this->event->trigger('pre.affiliate.edit.payment', $data);

		$affiliate_id = $this->affiliate->getId();

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', paypal = '" . $this->db->escape($data['paypal']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "' WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		$this->event->trigger('post.affiliate.edit.payment', $affiliate_id);
	}

	public function editPassword($email, $password) {
		$affiliate_id = $this->affiliate->getId();

		$this->event->trigger('pre.affiliate.edit.password', $affiliate_id);

		$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		$this->event->trigger('post.affiliate.edit.password', $affiliate_id);
	}

	public function getAffiliate($affiliate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		return $query->row;
	}

	public function getAffiliateByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}

	public function getAffiliateByCode($code) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE code = '" . $this->db->escape($code) . "'");

		return $query->row;
	}

	public function getAffiliateByCodeOnly($code) {
		$query = $this->db->query("SELECT affiliate_id, firstname, lastname,code FROM " . DB_PREFIX . "affiliate WHERE code = '" . $this->db->escape($code) . "'");

		return $query->row;
	}

	public function getTotalAffiliatesByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}

	public function addTransaction($affiliate_id, $amount = '', $order_id = 0) {
		$affiliate_info = $this->getAffiliate($affiliate_id);

		if ($affiliate_info) {
			$this->event->trigger('pre.affiliate.add.transaction');

			$this->load->language('mail/affiliate');

			$this->db->query("INSERT INTO " . DB_PREFIX . "affiliate_transaction SET affiliate_id = '" . (int)$affiliate_id . "', order_id = '" . (float)$order_id . "', description = '" . $this->db->escape($this->language->get('text_order_id') . ' #' . $order_id) . "', amount = '" . (float)$amount . "', date_added = NOW()");

			$affiliate_transaction_id = $this->db->getLastId();

			$message  = sprintf($this->language->get('text_transaction_received'), $this->currency->format($amount, $this->config->get('config_currency'))) . "\n\n";
			$message .= sprintf($this->language->get('text_transaction_total'), $this->currency->format($this->getTransactionTotal($affiliate_id), $this->config->get('config_currency')));

			$mail = new Mail($this->config->get('config_mail'));
			$mail->setTo($affiliate_info['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(sprintf($this->language->get('text_transaction_subject'), $this->config->get('config_name')));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();

			$this->event->trigger('post.affiliate.add.transaction', $affiliate_transaction_id);
		}
	}

	public function deleteTransaction($order_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "affiliate_transaction WHERE order_id = '" . (int)$order_id . "'");
	}

	public function getTransactionTotal($affiliate_id) {
		$query = $this->db->query("SELECT SUM(amount) AS total FROM " . DB_PREFIX . "affiliate_transaction WHERE affiliate_id = '" . (int)$affiliate_id . "'");

		return $query->row['total'];
	}
	
	public function addLoginAttempt($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate_login WHERE email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");
		
		if (!$query->num_rows) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "affiliate_login SET email = '" . $this->db->escape(utf8_strtolower((string)$email)) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', total = 1, date_added = '" . $this->db->escape(date('Y-m-d H:i:s')) . "', date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "'");
		} else {
			$this->db->query("UPDATE " . DB_PREFIX . "affiliate_login SET total = (total + 1), date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "' WHERE affiliate_login_id = '" . (int)$query->row['affiliate_login_id'] . "'");
		}			
	}	
	
	public function getLoginAttempts($email) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "affiliate_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row;
	}
	
	public function deleteLoginAttempts($email) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "affiliate_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}	
}