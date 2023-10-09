<?php
class ControllerInformationPaymentConfirmation extends Controller {
    private $error = array();
	public function index() {
		
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('information/payment_confirmation', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
        
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
		$this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
		$this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');
        
		$this->load->language('information/payment_confirmation');
        $this->document->setTitle($this->language->get('heading_title'));
        $data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('catalog/payment_confirmation');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('information/payment_confirmation', '', 'SSL')
		);
		$this->session->data['redirect'] = $this->url->link('information/payment_confirmation', '', 'SSL');
        	
        $data['action'] = $this->url->link('information/payment_confirmation', '', 'SSL');
        $data['back'] = $this->url->link('account/account', '', 'SSL');
        
        $data['text_bank'] = $this->language->get('text_bank');
        $data['text_payment'] = $this->language->get('text_payment');
        
        $data['text_user_bank'] = $this->language->get('text_user_bank');
        $data['text_user_account'] = $this->language->get('text_user_account');
        $data['text_user_name'] = $this->language->get('text_user_name');
        $data['text_payment_order'] = $this->language->get('text_payment_order');
        $data['text_payment_bank'] = $this->language->get('text_payment_bank');
        $data['text_payment_total'] = $this->language->get('text_payment_total');
        $data['text_payment_date'] = $this->language->get('text_payment_date');
        $data['text_payment_memo'] = $this->language->get('text_payment_memo');
        $data['text_payment_captcha'] = $this->language->get('text_payment_captcha');
        $data['text_select_bank'] = $this->language->get('text_select_bank');
        $data['text_select_order'] = $this->language->get('text_select_order');        
        
        $data['button_continue'] = $this->language->get('button_continue');
        $data['button_back'] = $this->language->get('button_back');
        
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			/** Upload File **/
			if (!empty($this->request->files['file_upload']['name']) && is_file($this->request->files['file_upload']['tmp_name'])) {

				$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file_upload']['name'], ENT_QUOTES, 'UTF-8')));

				if(!$this->error){
					$filename = str_replace(" ","_", $filename);
					$filename = explode('.', $filename);
					$file = $this->request->post['payment_order'].'.'.$filename[1];
					move_uploaded_file($this->request->files['file_upload']['tmp_name'], 'image/file_upload/' . $file);
					
					// Hide the uploaded file name so people can not link to it directly.
					$this->load->model('tool/upload');

					$fileupload = $this->model_tool_upload->addUpload($filename, $file);
					$filelink = HTTP_SERVER.'image/file_upload/'.$file;
				}
			}
			/** End Upload File **/

		      unset($this->session->data['captcha']);
			  //$this->model_catalog_payment_confirmation->confirm($this->request->post);
              $this->load->model('checkout/order');
              $order_id = (int)$this->request->post['payment_order'];
              $order_status_id = 19;
              
              $memo = strip_tags($this->request->post['payment_memo']);
              $tanggal = date('d M Y',strtotime($this->request->post['payment_date']));
              $bank = $this->request->post['payment_bank'];
		      $this->load->language("payment/{$bank}");
              $title = $this->language->get('text_title');
              $accountno   = $this->config->get("{$bank}_accountno");
              $accountname = $this->config->get("{$bank}_accountname");
              $rekening = "
                <br>Transfer via {$title}
                <br>Account Number: {$accountno}
                <br>Account Name: {$accountname}
              ";  
              
              $comment = "<b>Data pembayar</b>
		                  Bank: {$this->request->post['user_bank']} <br>
		                  No. Rekening: {$this->request->post['user_account']} <br>
		                  Atas Nama: {$this->request->post['user_name']} <br>

		                  <br><b>Data pembayaran</b> <br>
		                  Rekening Tujuan: {$rekening} <br> 
		                  Jumlah Bayar: {$this->request->post['payment_total']} <br>
		                  Tanggal Bayar: {$tanggal} <br>
		                  Memo: <br>
		                  {$memo} <br>
              ";

              if(! empty($filelink)){
	              $comment .= "
	                  <br>File:
	                  <a href='{$filelink}' target='_blank'>Lihat file</a>
	              ";
              }
              $notify = 0;
              
              $this->model_checkout_order->addOrderHistory($order_id, $order_status_id, $comment, $notify);

	          	//SEND NOTIFICATION TO ADMIN
	          	$history_result = $this->model_checkout_order->getOrder($order_id);

				$subject = sprintf('%s - Payment Confirmation', $this->config->get('config_name'));

				$message  = sprintf('Payment Confirmation from %s', $this->config->get('config_name')) . "\n\n";
				$message  .= "Pesanan anda telah diperbaharui ke status berikut: ". $history_result['order_status'] ."\n\n";
				$message  .= "No. Pesanan:  ". $history_result['order_id'] ."\n\n";
				$message  .= "Untuk melihat pesanan anda klik pada link di bawah:  "."\n\n";
				$message .= $history_result['store_url']. "roepi-adm/index.php?route=sale/order/info&token=". $this->session->data['token'] ."&order_id=". $history_result['order_id'];

				$mail = new Mail($this->config->get('config_mail'));
				$mail->setTo($this->config->get('config_email'));
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject($subject);
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
              
			  $this->session->data['success'] = $this->language->get('text_success');
			  $this->response->redirect('payment-confirmation-success');
            
		}
        
        // Payment Methods
		$results = $this->model_catalog_payment_confirmation->getBank();

		foreach ($results as $result) {
			if ($this->config->get($result['code'] . '_status')) {
			    $this->load->language("payment/{$result['code']}");
                $title = $this->language->get('text_title');
                $accountno   = $this->config->get("{$result['code'] }_accountno");
                $accountname = $this->config->get("{$result['code'] }_accountname");
				if ($title && $accountno && $accountname) {
				    $data['payment_banks'][$result['code']] = array(
                        'accountno' => $accountno,
                        'accountname' => $accountname,
                        'code'  => $result['code'],
                        'title' => $title
                    );
				}
			}
		}
        
        // order no
        $this->load->model('account/order');
        $filter = array(
            'order_status_id' => 1
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
                'total'    => floor($item['total']),
                'payment_date'  => $payment_date,
                'label'    => "#{$item['order_id']}, ". (date('d M Y',strtotime($item['date_added']))) . " ({$total})" 
            );    
        }
		
        if(empty($data['orders'])){
			  $this->session->data['error'] = $this->language->get('error_no_order');
			  $this->response->redirect($this->url->link('account/account', '', 'SSL'));
        }
        
        if (isset($this->error['captcha'])) {
			$data['error_captcha'] = $this->error['captcha'];
		} else {
			$data['error_captcha'] = '';
		}
        
        if (isset($this->request->post['captcha'])) {
			$data['captcha'] = $this->request->post['captcha'];
		} else {
			$data['captcha'] = '';
		}
                
        if (isset($this->error['user_bank'])) {
			$data['error_user_bank'] = $this->error['user_bank'];
		} else {
			$data['error_user_bank'] = '';
		}
        
        if (isset($this->request->post['user_bank'])) {
			$data['user_bank'] = $this->request->post['user_bank'];
		} else {
			$data['user_bank'] = '';
		}
                
        if (isset($this->error['user_account'])) {
			$data['error_user_account'] = $this->error['user_account'];
		} else {
			$data['error_user_account'] = '';
		}
        
        if (isset($this->request->post['user_account'])) {
			$data['user_account'] = $this->request->post['user_account'];
		} else {
			$data['user_account'] = '';
		}
        
        if (isset($this->error['user_name'])) {
			$data['error_user_name'] = $this->error['user_name'];
		} else {
			$data['error_user_name'] = '';
		}
        
        if (isset($this->request->post['user_name'])) {
			$data['user_name'] = $this->request->post['user_name'];
		} else {
			$data['user_name'] = '';
		}
                
        if (isset($this->error['payment_order'])) {
			$data['error_payment_order'] = $this->error['payment_order'];
		} else {
			$data['error_payment_order'] = '';
		}
        
        if (isset($this->request->post['payment_order'])) {
			$data['payment_order'] = $this->request->post['payment_order'];
		} else {
			$data['payment_order'] = '';
		}
                
        if (isset($this->error['payment_bank'])) {
			$data['error_payment_bank'] = $this->error['payment_bank'];
		} else {
			$data['error_payment_bank'] = '';
		}
        
        if (isset($this->request->post['payment_bank'])) {
			$data['payment_bank'] = $this->request->post['payment_bank'];
		} else {
			$data['payment_bank'] = '';
		}
        
  //       if (isset($this->error['payment_total'])) {
		// 	$data['error_payment_total'] = $this->error['payment_total'];
		// } else {
		// 	$data['error_payment_total'] = '';
		// }
        
        if (isset($this->request->post['payment_total'])) {
			$data['payment_total'] = $this->request->post['payment_total'];
		} else {
			$data['payment_total'] = '';
		}
        
        if (isset($this->error['payment_date'])) {
			$data['error_payment_date'] = $this->error['payment_date'];
		} else {
			$data['error_payment_date'] = '';
		}
        
        if (isset($this->request->post['payment_date'])) {
			$data['payment_date'] = $this->request->post['payment_date'];
		} else {
			$data['payment_date'] = '';
		}
        
        if (isset($this->error['payment_memo'])) {
			$data['error_payment_memo'] = $this->error['payment_memo'];
		} else {
			$data['error_payment_memo'] = '';
		}
        
        if (isset($this->request->post['payment_memo'])) {
			$data['payment_memo'] = $this->request->post['payment_memo'];
		} else {
			$data['payment_memo'] = '';
		}
		
		if (isset($this->error['attachment_file'])) {
			$data['error_file_upload'] = $this->error['attachment_file'];
		} else {
			$data['error_file_upload'] = '';
		}
       
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		//$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
         
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/payment_confirmation.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/payment_confirmation.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/information/payment_confirmation.tpl', $data));
		}
	}
    
	protected function validate() {
        $this->load->model('account/order');
        $order = $this->model_account_order->getOrder((int)$this->request->post['payment_order']);
       
		if ((utf8_strlen(trim($this->request->post['user_bank'])) < 1)) {
			$this->error['user_bank'] = $this->language->get('error_user_bank');
		}
        
        /*if ((utf8_strlen(trim($this->request->post['user_account'])) < 1)) {
			$this->error['user_account'] = $this->language->get('error_user_account');
		}*/
        
        if ((utf8_strlen(trim($this->request->post['user_name'])) < 1)) {
			$this->error['user_name'] = $this->language->get('error_user_name');
		}
        
        if (empty($order) || $order['order_status_id']!= 1) {
			$this->error['payment_order'] = $this->language->get('error_payment_order');
		}
        
        if ((utf8_strlen(trim($this->request->post['payment_bank'])) < 1 || ! $this->config->get($this->request->post['payment_bank'] . '_status'))) {
			$this->error['payment_bank'] = $this->language->get('error_payment_bank');
		}
        
  		//if (empty($order) || (int)$order['total'] != (int)$this->request->post['payment_total']) {
		// 	$this->error['payment_total'] = $this->language->get('error_payment_total');
		// }
        
        if ((utf8_strlen(trim($this->request->post['payment_date'])) < 1)) {
			$this->error['payment_date'] = $this->language->get('error_payment_date');
		}
        
        if ((utf8_strlen(trim($this->request->post['payment_memo'])) > 36)) {
			$this->error['payment_memo'] = $this->language->get('error_payment_memo');
		}
        
        /*if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}*/

        if (empty($this->request->files['file_upload']['tmp_name'])) {
        	$this->error['attachment_file'] = $this->language->get('error_file_empty');
		}

		$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file_upload']['name'], ENT_QUOTES, 'UTF-8')));

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
			'pdf',
		);

		if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
			//pre('ko');
			$this->error['attachment_file'] = $this->language->get('error_attachment_filetype');
		}

		// Allowed file extension types
		$allowed = array(
			'image/png',
			'image/jpeg',
			'image/bmp',
			'application/pdf',
		);

		if (!in_array($this->request->files['file_upload']['type'], $allowed)) {
			//pre('ko');
			$this->error['attachment_file'] = $this->language->get('error_attachment_file');
		}

		// Check to see if any PHP files are trying to be uploaded
		$content = file_get_contents($this->request->files['file_upload']['tmp_name']);

		if (preg_match('/\<\?php/i', $content)) {
			$this->error['attachment_file'] = $this->language->get('error_attachment_filetype');
		}

		// Return any upload error
		if ($this->request->files['file_upload']['error'] != UPLOAD_ERR_OK) {
			$this->error['attachment_file'] = $this->language->get('error_attachment_fileupload');
		}

		return !$this->error;
	}
}