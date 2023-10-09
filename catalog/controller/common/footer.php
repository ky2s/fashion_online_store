<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

		$this->load->model('catalog/information');

		//HELP INFO
		$data['help_informations'] = array();
		$limit_offset = array('limit'=> 0, 'offset'=>6);		
		foreach ($this->model_catalog_information->getLimitInformations($limit_offset) as $help_result) {
			if ($help_result['bottom']) {
				if($help_result['information_id'] == 14){ //14 = information contact id
					$data['help_informations'][] = array(
						'title' => $help_result['title'],
						'href'  => HTTP_SERVER.'contact'
					);
				}else{
					$data['help_informations'][] = array(
						'title' => $help_result['title'],
						'href'  => $this->url->link('information/information', 'information_id=' . $help_result['information_id'])
					);
				}
			}
		}

		//HELP COMPANY
		$data['company_informations'] = array();
		$company_limit_offset = array('limit'=> 6, 'offset'=>4);

		foreach ($this->model_catalog_information->getLimitInformations($company_limit_offset) as $company_result) {
			if ($company_result['bottom'] && $company_result['information_id'] !=14) { //14 is information_id = Contact US
				$data['company_informations'][] = array(
					'title' => $company_result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $company_result['information_id'])
				);
			}

			if ($company_result['information_id'] == 14 ) { //14 is information_id = Contact US
				$data['company_informations'][] = array(
					'title' => $company_result['title'],
					'href'  => $this->config->get('config_url').'contact'
				);
			}
		}

		/*$data['informations'] = array();
		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}*/

		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', 'SSL');
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

		$data['powered'] = $this->language->get('text_powered');

		## CUSTOM BY STEPH##

		$data['config_newsletter_status'] = $this->config->get('config_newsletter_status');
		$data['isLogged']          = $this->customer->isLogged();
		$data['symbolLeft']        = $this->currency->getSymbolLeft();
		$data['couponValue']       = number_format($this->config->get('config_newsletter_discount'),0,'.','.');
		$data['action_newsletter'] = $this->url->link('common/footer/newsletter');

		if(isset($this->session->data['newsletter'])) {
			$data['isSessionExist'] = true;
		} else {
			$data['isSessionExist'] = false;
		}								
		
		$social_media['facebook'] = '';
		$social_media['twitter'] = '';
		$social_media['instagram'] = '';
		$social_media['snapchat'] = '';
		if ($this->config->get('config_facebook')) {
			$social_media['facebook'] = $this->config->get('config_facebook');
		}
		if ($this->config->get('config_twitter')) {
			$social_media['twitter'] = $this->config->get('config_twitter');
		}
		if ($this->config->get('config_instagram')) {
			$social_media['instagram'] = $this->config->get('config_instagram');
		}
		if ($this->config->get('config_snapchat')) {
			$social_media['snapchat'] = $this->config->get('config_snapchat');
		}

//		if($this->request->get['information_id'] == 4){ //4 = information id
			//social media
			$data['facebook'] = '';
			$data['twitter'] = '';
			$data['instagram'] = '';
			$data['snapchat'] = '';
			//pre($this->config->get('config_twitter'));
			if ($this->config->get('config_facebook')) {
				$social_media['facebook'] = $this->config->get('config_facebook');
			}
			if ($this->config->get('config_twitter')) {
				$social_media['twitter'] = $this->config->get('config_twitter');
			}
			if ($this->config->get('config_instagram')) {
				$social_media['instagram'] = $this->config->get('config_instagram');
			}
			if ($this->config->get('config_snapchat')) {
				$social_media['snapchat'] = $this->config->get('config_snapchat');
			}
//		}
		
		$data['social_media'] = $social_media;
		## ##
		//refferal link
		if($this->customer->isLogged()){
			$this->load->model('affiliate/affiliate');
			$this->load->model('account/customer');

			//get customer data\
			$customer = $this->model_account_customer->getCustomer($this->session->data['customer_id']);

			$data['referral_url'] = NULL;			
			$affiliate = $this->model_affiliate_affiliate->getAffiliateByEmail($customer['email']);
			//pre($affiliate);
			if($affiliate){
				if ($this->request->server['HTTPS']) {
					$base = HTTPS_SERVER;
				} else {
					$base = HTTP_SERVER;
				}
				$data['referral_url'] = $base.'r/'. $affiliate['code'] ;		
			}
		}
			//pre($data['referral_url']);
		$data['refund_url'] = 'refund' ;
		$data['blog_url'] = $this->url->link('simple_blog/article') ;

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}

	public function newsletter() {
		if (!$this->customer->isLogged()) {
		$json = array();

		//cek if email correct
		if (filter_var($this->request->post['newsletter_email'], FILTER_VALIDATE_EMAIL)) {

			if(strlen($this->request->post['newsletter_email']) > 100) {
				$json['error'] = "No more than 100 character";
			} else {
				//cek if email not exist
			    $query = $this->db->query("SELECT newsletter_email FROM newsletter WHERE newsletter_email = '".$this->request->post['newsletter_email']."'");
				if ($query->row) {
					$json['error'] = "Email is already registered";
				} else {
					//save to newsletter
					$this->db->query("INSERT INTO " . DB_PREFIX . "newsletter SET 
						newsletter_email = '" . $this->db->escape($this->request->post['newsletter_email']) . "', 
						newsletter_gender = '" . $this->db->escape($this->request->post['newsletter_gender']) . "', 
						newsletter_status = 1");

					$newsletter_id = $this->db->getLastId();

					//create coupon
					$code = substr(base_convert(sha1(uniqid(mt_rand())), 16, 36), 0, 10);
					$this->db->query("INSERT INTO " . DB_PREFIX . "coupon SET 
						newsletter_id = ".$newsletter_id.",
						name = '".$this->db->escape($this->request->post['newsletter_email'])." newsletter', 
						code = '" . $this->db->escape($code) . "', 
						discount = '" . $this->config->get('config_newsletter_discount') . "', 
						type = 'F', 
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
     			$total = $this->currency->format($this->config->get('config_newsletter_total'), $this->config->get('config_currency'));

					//send email	
					
					$this->load->language('mail/newsletter');

					$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

					$message = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";

					$message .= $this->url->link('account/login', '', 'SSL') . "\n\n";
					$message .= sprintf($this->language->get('text_coupon'), $amount, $total) . "\n\n";
					$message .= sprintf($this->language->get('text_coupon_code'), $code) . "\n\n";
					$message .= sprintf($this->language->get('text_coupon_valid'), date('d M Y'), date("d M Y",strtotime("+1 week"))) . "\n\n";					
					$message .= $this->language->get('text_thanks') . "\n";
					$message .= $this->config->get('config_name');

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

					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/newsletter.tpl')) {
						$html = $this->load->view($this->config->get('config_template') . '/template/mail/newsletter.tpl', $data);
					} else {
						$html = $this->load->view('default/template/mail/newsletter.tpl', $data);
					}

					$mail = new Mail($this->config->get('config_mail'));
					$mail->setTo($this->request->post['newsletter_email']);
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender($this->config->get('config_name'));
					$mail->setSubject($subject);
					$mail->setHtml($html);
					$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
					$mail->send();

					$this->session->data['newsletter'] = true;
				}
			}		    		   
		} else {
			$json['error'] = "Email address seems not valid";
		}
		echo json_encode($json);
		}
	} // end newsletter
}