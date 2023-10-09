<?php
class ControllerCommonQuicksignup extends Controller {

	private $error = array();

	public function index() {
		$this->load->language('common/quicksignup');

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');

		$data['text_loading'] = $this->language->get('text_loading');
		$data['text_details'] = $this->language->get('text_details');
		$data['text_signin_register'] = $this->language->get('text_signin_register');
		$data['text_new_customer'] = $this->language->get('text_new_customer');
		$data['text_returning'] = $this->language->get('text_returning');
		$data['text_returning_customer'] = $this->language->get('text_returning_customer');		
		
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_email'] = $this->language->get('entry_email');
		$data['entry_birth_date'] = $this->language->get('entry_birth_date');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['text_forgotten_email'] = $this->language->get('text_forgotten_email');

		//custom
		$data['text_wellcome'] = $this->language->get('text_wellcome');
		$data['text_continue'] = $this->language->get('text_continue');

		$data['button_login'] = $this->language->get('button_login');
		$data['button_continue'] = $this->language->get('button_continue');
		
		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		//if($this->config->get('config_store_id') <= 0){
		$store_id = (int)$this->config->get('config_store_id');
		$providers =  $this->config->get('hybrid_auth') ;

		$data['provider'] = array();
		foreach ($providers as $key => $provider) {
			if($provider['store_id']==$store_id){
				$data['provider'][]=$provider;
				break;
			}
		}
		
		//}
		$data['store_url'] = $this->config->get('config_url');
		$data['hybrid_success'] = $data['store_url'].'index.php?route=hybrid/auth/success';

		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			if ($information_info) {
				$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$data['text_agree'] = '';
			}
		} else {
			$data['text_agree'] = '';
		}

		// Custom Fields
		$this->load->model('account/custom_field');
		$data['custom_fields'] = $this->model_account_custom_field->getCustomFields();

		if (isset($this->request->post['custom_field'])) {
			if (isset($this->request->post['custom_field']['account'])) {
				$account_custom_field = $this->request->post['custom_field']['account'];
			} else {
				$account_custom_field = array();
			}
			
			if (isset($this->request->post['custom_field']['address'])) {
				$address_custom_field = $this->request->post['custom_field']['address'];
			} else {
				$address_custom_field = array();
			}			
			
			$data['register_custom_field'] = $account_custom_field + $address_custom_field;
		} else {
			$data['register_custom_field'] = array();
		}

		//CUSTOMER GROUP
		$data['customer_groups'] = array();

		if (is_array($this->config->get('config_customer_group_display'))) {
			$this->load->model('account/customer_group');

			$customer_groups = $this->model_account_customer_group->getCustomerGroups();

			foreach ($customer_groups as $customer_group) {
				if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$data['customer_groups'][] = $customer_group;
				}
			}
		}
		
		if (isset($this->request->post['customer_group_id'])) {
			$data['customer_group_id'] = $this->request->post['customer_group_id'];
		} else {
			$data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/quicksignup.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/quicksignup.tpl', $data);
		} else {
			return $this->load->view('default/template/common/quicksignup.tpl', $data);
		}
	}
	
	public function register() 
	{
		$json =array();
		$this->language->load('common/quicksignup');
		$this->language->load('account/success');
		$this->load->model('account/customer');
		$this->load->model('catalog/information');
		$this->load->model('account/quicksignup');
		
		if ($this->customer->isLogged()) {
			$json['islogged'] = true;
		}
		else if(isset($this->request->post)) 
		{
			if ((utf8_strlen(trim($this->request->post['name'])) < 1) || (utf8_strlen(trim($this->request->post['name'])) > 32)) {
				$json['error'] = $json['error_name'] = $this->language->get('error_name');
			}
			
			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
				$json['error'] = $json['error_email'] = $this->language->get('error_email');
			}

			if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
				$json['error'] = $json['error_email'] = $this->language->get('error_exists');
			}
			
			if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
				$json['error'] = $json['error_password'] = $this->language->get('error_password');
			}	

			// Customer Group
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
				$customer_group_id = $this->request->post['customer_group_id'];
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}

			// Custom field validation
			$this->load->model('account/custom_field');
			$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);
			foreach ($custom_fields as $custom_field) {
				if($custom_field['location'] == 'account'){
					if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {				
						$json['custom_field_error'][$custom_field['custom_field_id']] = sprintf('Data %s is required', $custom_field['name']);
					}
				}
			}

			// Agree to terms
			if ($this->config->get('config_account_id')) {
				$this->load->model('catalog/information');

				$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
				// if ($information_info && !isset($this->request->post['agree'])) {
				// 	$json['error'] = sprintf($this->language->get('error_agree'), $information_info['title']);
				// }
			}
		}
		else{
			$json['error'] = $this->language->get('error_warning');
		}
		
		if(!$json) {

			//ADD AFFILIATE
			$this->load->model('affiliate/affiliate');
			$data_post = array(
				'name' => $this->request->post['name'],
				'email' => $this->request->post['email'],
				'password' => $this->request->post['password'],
				'telephone' => '0',
				'fax' => '0',
				'company' => '0',
				'address_1' => '0',
				'address_2' => '0',
				'city' => '0',
				'postcode' => '0',
				'country_id' => 0,
				'zone_id' => 0,
			);

			$affiliate_id = $this->model_affiliate_affiliate->addAffiliate($data_post);
			$this->session->data['affiliate_id'] = $affiliate_id; //add session affiliate (afiliat eauto login)

			$this->model_account_customer->addCustomer($this->request->post);

			$this->session->data['tracking'] = (isset($this->request->cookie['tracking'])) ? $this->request->cookie['tracking'] : false;

			$json['success'] = true;
			$this->customer->login($this->request->post['email'], $this->request->post['password']);

			unset($this->session->data['guest']);

			// Add to activity log
			$this->load->model('account/activity');

			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->request->post['name']
			);

			$this->model_account_activity->addActivity('register', $activity_data);
			
			if ($this->customer->isLogged()) {
				$json['now_login'] = true;
			}
			
			
			$json['heading_title'] = $this->language->get('heading_title');

			$this->load->model('account/customer_group');

			$customer_group_info = $this->model_account_customer_group->getCustomerGroup($this->config->get('config_customer_group_id'));

			if ($customer_group_info && !$customer_group_info['approval']) {
				$json['text_message'] = sprintf($this->language->get('text_message'), $this->config->get('config_name'), $this->url->link('information/contact'));
			} 
			else {
				$json['text_message'] = sprintf($this->language->get('text_approval'), $this->config->get('config_name'), $this->url->link('information/contact'));
			}
			
			if ($this->cart->hasProducts()) 
			{
				$json['continue'] = $this->url->link('checkout/cart');
			} 
			else {
				$json['continue'] = $this->url->link('account/account', '', 'SSL');
			}

			$json['button_continue'] = $this->language->get('button_continue');			
		}		

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	//check email
	public function check_login() 
	{
		$this->language->load('common/quicksignup');
		$this->load->language('account/register');

		$json =array();
		$this->load->model('account/customer');
		$email = $this->request->post['email'];

		if(!empty($email)){
			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $this->request->post['email'])) {
				$json['error'] = $this->language->get('error_email');
				$json['data'] = false;			
			}else{
				$check_email = $this->model_account_customer->getCustomerByEmail($email);
				if($check_email){
					$json['success'] = true;	
					$json['data'] = $check_email;	
				}
				else{
					$json['error'] = true;
					$json['data'] = $email;				
				}
			}
		}
		else{
			$json['error'] = $this->language->get('error_email');
			$json['data'] = false;				
		}
		
		//send respond
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function login() 
	{		
		$json =array();
		$json['redirect'] = '';
		$json['store_url'] = $this->config->get('config_url');
		$this->language->load('common/quicksignup');
		$this->load->model('account/customer');
		
		if ($this->customer->isLogged()) {
			$json['islogged'] = true;
		}
		else if(isset($this->request->post)) 
		{			
			if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$json['error'] = $this->language->get('error_login');
			}

			$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
			if ($customer_info && !$customer_info['approved']) {
				$json['error'] = $this->language->get('error_approved');
			}
		}
		else{
			$json['error'] = $this->language->get('error_warning');
		}
		
		if(empty($json['error'])) 
		{
			$json['success'] = true;
			unset($this->session->data['guest']);

			// Default Shipping Address
			$this->load->model('account/address');

			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->session->data['payment_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if ($this->config->get('config_tax_customer') == 'shipping') {
				$this->session->data['shipping_address'] = $this->model_account_address->getAddress($this->customer->getAddressId());
			}

			if (isset($this->request->post['redirect']) && $this->request->post['redirect']=='payment-confirmation') {
				$json['redirect']= $this->url->link('information/payment_confirmation', '', 'SSL');
			}

			//ADD SESSION AFFILIATE
			$this->load->model('affiliate/affiliate');
			$affiliate_id = $this->model_affiliate_affiliate->getAffiliateByEmail($this->request->post['email']);			
			$this->session->data['affiliate_id'] = $affiliate_id['affiliate_id'];

			$this->session->data['tracking'] = (isset($this->request->cookie['tracking'])) ? $this->request->cookie['tracking'] : false;

			$json['aff_session'] = $affiliate_id;
			$json['islogged'] = true;

			// Add to activity log
			$this->load->model('account/activity');
			$activity_data = array(
				'customer_id' => $this->customer->getId(),
				'name'        => $this->customer->getFirstName() . ' ' . $this->customer->getLastName()
			);
			$this->model_account_activity->addActivity('login', $activity_data);
		}
		
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function forgot_password() 
	{
		if ($this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
		}

		$this->load->language('account/forgotten');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');

		if(!empty($this->request->post['email']))
		{
			if($this->validate()) 
			{
				$this->load->language('mail/forgotten');

				$password = substr(sha1(uniqid(mt_rand(), true)), 0, 10);
				
				$this->model_account_customer->editPassword($this->request->post['email'], $password);

				$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));

				/*EMAIL FORGOTTEN HTML*/
				if ($this->request->server['HTTPS']) {
					$base = HTTPS_SERVER;
				} else {
					$base = HTTP_SERVER;
				}

				$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
				
				$data['url_image'] 		= $this->config->get('config_url');
				$data['logo']       	= $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');
				$data['store_name']     = $this->config->get('config_name');
				$data['config_name']  	= $this->config->get('config_name');
				$data['is_password']  	= $password;
				$data['base']           = $base;
				$data['base_contact']   = $this->config->get('config_url').'contact';
				$data['base_login']     = $this->config->get('config_url').'login';
				$data['title']          = 'Reset Password';
				$data['fullname']		= $customer_info['firstname'] . ' ' . $customer_info['lastname'];
				$data['text_greeting']  = sprintf($this->language->get('text_greeting'), $this->config->get('config_name'));
				$data['text_new_password']  = $this->language->get('text_password');
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/forgotten.tpl')) {
					$html = $this->load->view($this->config->get('config_template') . '/template/mail/forgotten.tpl', $data);
				} else {
					$html = $this->load->view('default/template/mail/forgotten.tpl', $data);
				}
				
				// $message  =  . "\n\n";
				// $message .=  . "\n\n";
				// $message .= $password;


				$mail = new Mail($this->config->get('config_mail'));
				$mail->setTo($this->request->post['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject($subject);
				$mail->setHtml($html);
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();

				$this->session->data['success'] = $this->language->get('text_success');

				// Add to activity log
				
				if ($customer_info) {
					$this->load->model('account/activity');

					$activity_data = array(
						'customer_id' => $customer_info['customer_id'],
						'name'        => $customer_info['firstname'] . ' ' . $customer_info['lastname']
					);

					$this->model_account_activity->addActivity('forgotten', $activity_data);
				}
				$json['success'] = true;
				$json['text_message'] = $this->language->get('text_success');
			}
			else{
				$json['success'] = false;
				$json['error_email'] = $this->language->get('error_email');			
			}
		}
		else{
			//input empty
			$json['success'] = false;
			$json['error_email'] = $this->language->get('error_email');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function validate() 
	{

		if (!isset($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');
		} 
		elseif (!$this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_email');

		}
/*
		// Customer Group
		if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $this->request->post['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}

		// Custom field validation
		$this->load->model('account/custom_field');
		$custom_fields = $this->model_account_custom_field->getCustomFields($customer_group_id);

		foreach ($custom_fields as $custom_field) {
			if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}

		// Custom field validation
		$this->load->model('account/custom_field');

		$custom_fields = $this->model_account_custom_field->getCustomFields();

		foreach ($custom_fields as $custom_field) {
			if ($custom_field['required'] && empty($this->request->post['custom_field'][$custom_field['location']][$custom_field['custom_field_id']])) {
				$this->error['custom_field'][$custom_field['custom_field_id']] = sprintf($this->language->get('error_custom_field'), $custom_field['name']);
			}
		}*/

		return !$this->error;
	}
}