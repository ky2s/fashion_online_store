<?php

class ControllerCommonReferral extends Controller {

	

	public function index() {

		

		if ($this->request->server['HTTPS']) {

			$base = HTTPS_SERVER;

		} else {

			$base = HTTP_SERVER;

		}



		$this->load->language('common/referral');

		$data['title'] = $this->language->get('heading_title');



		//CHECK WHO AFFILIATE

		$affiliate_code = (isset($this->session->data['affiliate_code'])) ? $this->session->data['affiliate_code'] : FALSE;

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



		//cookie tracking saved in session

		unset($_COOKIE['tracking']);

		setcookie("tracking", '');



		//check jika menggunkan link sendiri

		if(!$compare){			

			setcookie("tracking", $this->session->data['affiliate_code']);

			$this->session->data['tracking'] = (isset($this->request->cookie['tracking'])) ? $this->request->cookie['tracking'] : false;

			//cek jika sudah login

			if ($this->customer->isLogged()) {

				$this->session->data['tracking'] = (isset($this->request->cookie['tracking'])) ? $this->request->cookie['tracking'] : false;

				$this->response->redirect($base);

			}

		}

		else{

			$this->response->redirect($base);

		}
		
		if($this->config->get('config_store_id') != 0){
			unset($_COOKIE['tracking']);
			setcookie("tracking", '');			
		}
	

		$data['quicksignup'] = $this->load->controller('common/quicksignup');



		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/referral.tpl')) {

			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/referral.tpl', $data));

		} else {

			$this->response->setOutput($this->load->view('default/template/common/referral.tpl', $data));

		}

	}

}