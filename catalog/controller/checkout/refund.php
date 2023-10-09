<?php
class ControllerCheckoutRefund extends Controller {	
	private $error = array();

	public function index() {

		//cek customer login
		if (!$this->customer->isLogged()) {
			$this->response->redirect('login');
		}

		$this->load->language('checkout/refund');
		$this->document->setTitle($this->language->get('heading_title'));
		$data['refund'] = $this->language->get('heading_title');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			/************************** Upload File *********************************/
			if (!empty($this->request->files['attachment_file']['name']) && is_file($this->request->files['attachment_file']['tmp_name'])) {
				$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['attachment_file']['name'], ENT_QUOTES, 'UTF-8')));

				// Validate the filename length
				if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
					$this->error['attachment_file'] = $this->language->get('error_attachment_filename');
				}

				// Allowed file extension types
				$allowed = array(
					'png',
					'jpeg',
					'jpg',
					'bmp',
				);

				if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
					$this->error['attachment_file'] = $this->language->get('error_attachment_filetype');
				}

				// Allowed file extension types
				$allowed = array(
					'image/png',
					'image/jpeg',
					'image/bmp',
				);

				if (!in_array($this->request->files['attachment_file']['type'], $allowed)) {
					$this->error['attachment_file'] = $this->language->get('error_attachment_file');
				}

				// Check to see if any PHP files are trying to be uploaded
				$content = file_get_contents($this->request->files['attachment_file']['tmp_name']);

				if (preg_match('/\<\?php/i', $content)) {
					$this->error['attachment_file'] = $this->language->get('error_attachment_filetype');
				}

				// Return any upload error
				if ($this->request->files['attachment_file']['error'] != UPLOAD_ERR_OK) {
					$this->error['attachment_file'] = $this->language->get('error_attachment_fileupload');
				}else {
					$filename = str_replace(" ","_", $filename);
					$file = $filename;
					move_uploaded_file($this->request->files['attachment_file']['tmp_name'], 'image/file_upload/' . $file);
					
					// Hide the uploaded file name so people can not link to it directly.
					$this->load->model('tool/upload');

					$fileupload = $this->model_tool_upload->addUpload($filename, $file);
					$filelink = HTTP_SERVER.'image/file_upload/'.$file;
				}
			}
			/** End Upload File **/

			$order_id = $this->request->post['order_id'];
			$customer_email = $this->request->post['email'];
			$amount = $this->request->post['amount'];
			$reason = $this->request->post['reason'];
			$account_name = $this->request->post['account_name'];
			$account_bank = $this->request->post['account_bank'];
			$account_number = $this->request->post['account_number'];
			
			//orders
			$this->load->model('checkout/order');
			$order_info  = $this->model_checkout_order->getOrder($order_id);

			// Load the language for any mails that might be required to be sent out
			$language = new Language($order_info['language_directory']);
			$language->load('default');
			$language->load('mail/refund');
			
			$subject = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);

			$text = "";
			
			$this->load->model('setting/setting');
			$config_store = $this->model_setting_setting->getSetting('config', $this->config->get('config_store_id'));
					
			// HTML Mail
			$data = array();

			$data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'), $order_id);
			$data['text_greeting'] = sprintf($language->get('text_new_received'), html_entity_decode($order_info['store_name'], ENT_QUOTES, 'UTF-8'));
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
			//$data['text_footer'] = $language->get('text_new_footer');

			/*TEXT REFUN DETAIL*/
			$data['customer_email'] = $customer_email;
			$data['amount'] = $amount;
			$data['reason'] = $reason;
			$data['account_name'] = $account_name;
			$data['account_bank'] = $account_bank;
			$data['account_number'] = $account_number;
			$data['file_name'] = $filename;
			$data['file_link'] = $filelink;
			

			$data['text_refund'] = $language->get('text_refund');
			$data['text_amount'] = $language->get('text_amount');
			$data['text_reason'] = $language->get('text_reason');
			$data['text_name'] = $language->get('text_name');
			$data['text_bank'] = $language->get('text_bank');
			$data['text_bank_number'] = $language->get('text_bank_number');
			$data['text_attachment']        = $language->get('text_attachment');

			$data['url_image'] = $this->config->get('config_url');
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
			$data['full_name'] = $config_store['config_owner'];
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
			$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");

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
					'code' => $total['code'],
					'text'  => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
				);
			}
			
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/refund.tpl')) {
				$html = $this->load->view($this->config->get('config_template') . '/template/mail/refund.tpl', $data);
			} else {
				$html = $this->load->view('default/template/mail/refund.tpl', $data);
			}
				
			if($this->config->get('config_email_refund')){

				$mail = new Mail($this->config->get('config_mail'));

				$mail->setTo($this->config->get('config_email_refund'));
				$mail->setFrom($customer_email);
				$mail->setSender($account_name);
				$mail->setSubject($subject);
				$mail->setHtml($html);
				$mail->send();
			}
			
			$refund_data = array(
				'order_id' => $order_id,
				'customer_email' => $customer_email,
				'amount' => $amount,
				'account_name' => $account_name,
				'account_bank' => $account_bank,
				'account_number' => $account_number,
				);

			$this->session->data['refund_data'] = $refund_data;
			
			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->request->post['firstname'] . ' ' . $this->request->post['lastname']
			);

			$this->model_account_activity->addActivity('register', $activity_data);

			// paksa redirect ke home
			$refund_success_url = 'refund-success';
			
			$this->response->redirect($refund_success_url);
		}
		
		$data['action'] = $this->url->link('checkout/refund', '', 'SSL');

		$this->load->model('account/order');
        $filter = array(
            'order_status_id' => 17, //Completed status ID
            'order_last_date' => 1, // 1 = last 1 month
        );

        $data['orders'] = array();
        $orders = $this->model_account_order->getOrders(0,0,$filter);
        foreach($orders as $item){
            $total = $this->currency->format($item['total'], $item['currency_code'], $item['currency_value']);
            
            //added by wian
            $date_order = date_create(date('d-m-Y',strtotime($item['date_added'])));
            $date_now = date_create(date('d-m-Y'));
            $payment_date = date_diff($date_now, $date_order)->format('%a');
            //added by wian

            $data['orders'][] = array(
                'order_id' => $item['order_id'],
                'email'    => $item['email'],
                'total'    => floor($item['total']),
                'payment_date'  => $payment_date,
                'label'    => "#{$item['order_id']}, ". (date('d M Y',strtotime($item['date_added']))) . " ({$total})" 
            );    
        }   
        
        if(empty($data['orders'])){
			$this->session->data['error'] = $this->language->get('error_no_refund');
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
        }

		//warning =============================================
		if (isset($this->error['order_id'])) {
			$data['error_order_id'] = $this->error['order_id'];
		} else {
			$data['error_order_id'] = '';
		}

		if (isset($this->error['email'])) {
			$data['error_email'] = $this->error['email'];
		} else {
			$data['error_email'] = '';
		}

		if (isset($this->error['amount'])) {
			$data['error_amount'] = $this->error['amount'];
		} else {
			$data['error_amount'] = '';
		}

		if (isset($this->error['reason'])) {
			$data['error_reason'] = $this->error['reason'];
		} else {
			$data['error_reason'] = '';
		}

		if (isset($this->error['account_name'])) {
			$data['error_account_name'] = $this->error['account_name'];
		} else {
			$data['error_account_name'] = '';
		}

		if (isset($this->error['account_bank'])) {
			$data['error_account_bank'] = $this->error['account_bank'];
		} else {
			$data['error_account_bank'] = '';
		}

		if (isset($this->error['account_number'])) {
			$data['error_account_number'] = $this->error['account_number'];
		} else {
			$data['error_account_number'] = '';
		}

		if (isset($this->error['attachment_file'])) {
			$data['error_attachment_file'] = $this->error['attachment_file'];
		} else {
			$data['error_attachment_file'] = '';
		}

		//callback =============================================
		if (isset($this->request->post['order_id'])) {
			$data['order_id'] = $this->request->post['order_id'];
		} else {
			$data['order_id'] = '';
		}

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['amount'])) {
			$data['amount'] = $this->request->post['amount'];
		} else {
			$data['amount'] = '';
		}

		if (isset($this->request->post['account_name'])) {
			$data['account_name'] = $this->request->post['account_name'];
		} else {
			$data['account_name'] = '';
		}
		
		if (isset($this->request->post['account_bank'])) {
			$data['account_bank'] = $this->request->post['account_bank'];
		} else {
			$data['account_bank'] = '';
		}

		if (isset($this->request->post['account_number'])) {
			$data['account_number'] = $this->request->post['account_number'];
		} else {
			$data['account_number'] = '';
		}
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/refund.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/refund.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/refund.tpl', $data));
		}
	}

	public function validate(){

		if ((utf8_strlen(trim($this->request->post['order_id'])) < 1) || (utf8_strlen(trim($this->request->post['order_id'])) > 32)) {
			$this->error['order_id'] = $this->language->get('error_order_id');
		}

		if ((utf8_strlen(trim($this->request->post['email'])) < 1) || (utf8_strlen(trim($this->request->post['email'])) > 32)) {
			$this->error['email'] = $this->language->get('error_email');
		}

		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_email_format');
		}

		if ((utf8_strlen(trim($this->request->post['amount'])) < 1) || (utf8_strlen(trim($this->request->post['amount'])) > 32)) {
			$this->error['amount'] = $this->language->get('error_amount');
		}

		if ((utf8_strlen(trim($this->request->post['reason'])) < 1)) {
			$this->error['reason'] = $this->language->get('error_reason');
		}

		if ((utf8_strlen(trim($this->request->post['account_name'])) < 1) || (utf8_strlen(trim($this->request->post['account_name'])) > 32)) {
			$this->error['account_name'] = $this->language->get('error_account_name');
		}	

		if ((utf8_strlen(trim($this->request->post['account_bank'])) < 1) || (utf8_strlen(trim($this->request->post['account_bank'])) > 32)) {
			$this->error['account_bank'] = $this->language->get('error_account_bank');
		}

		if ((utf8_strlen(trim($this->request->post['account_number'])) < 1) || (utf8_strlen(trim($this->request->post['account_number'])) > 32)) {
			$this->error['account_number'] = $this->language->get('error_account_number');
		}	

		if (empty($this->request->files['attachment_file']['tmp_name'])) {
        	$this->error['attachment_file'] = $this->language->get('error_file_empty');
		}

		return !$this->error;	
	}
}