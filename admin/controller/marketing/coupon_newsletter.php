<?php  
class ControllerMarketingCouponNewsletter extends Controller {
	private $error = array();

	public function index() {

		$this->language->load('marketing/coupon_newsletter');

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled']  = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_edit']     = $this->language->get('text_edit');
		$data['text_yes'] 	   = $this->language->get('text_yes');
		$data['text_no'] 		   = $this->language->get('text_no');		

		$data['entry_discount'] = $this->language->get('entry_discount');
		$data['entry_logged']   = $this->language->get('entry_logged');
		$data['entry_total'] 	  = $this->language->get('entry_total');
		$data['entry_shipping'] = $this->language->get('entry_shipping');
		$data['entry_status']   = $this->language->get('entry_status');

		$data['help_logged']    = $this->language->get('help_logged');
		$data['help_total']     = $this->language->get('help_total');		
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('setting/setting');			
			
			$this->model_setting_setting->editSetting('config_newsletter', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('marketing/coupon_newsletter', 'token=' . $this->session->data['token'], 'SSL'));			
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['discount'])) {
			$data['error_discount'] = $this->error['discount'];
		} else {
			$data['error_discount'] = '';
		}

		if (isset($this->error['total'])) {
			$data['error_total'] = $this->error['total'];
		} else {
			$data['error_total'] = '';
		}

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('marketing/coupon_newsletter', 'token=' . $this->session->data['token'], 'SSL'),			
		);

		$data['heading_title'] = $this->language->get('heading_title');		
		$this->document->setTitle($this->language->get('heading_title'));

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		$data['action']        = $this->url->link('marketing/coupon_newsletter', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel']        = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] 	       = $this->session->data['token'];
		$data['button_save']   = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['tab_setting']   = $this->language->get('tab_setting');
		$data['tab_history']   = $this->language->get('tab_history');
        
		$data['config_url'] = HTTP_CATALOG;

		if (isset($this->request->post['config_newsletter_discount'])) {
			$data['config_newsletter_discount'] = $this->request->post['config_newsletter_discount'];
		} else {
			$data['config_newsletter_discount'] = $this->config->get('config_newsletter_discount');
		}

		if (isset($this->request->post['config_newsletter_total'])) {
			$data['config_newsletter_total'] = $this->request->post['config_newsletter_total'];
		} else {
			$data['config_newsletter_total'] = $this->config->get('config_newsletter_total');
		}

		if (isset($this->request->post['config_newsletter_logged'])) {
			$data['config_newsletter_logged'] = $this->request->post['config_newsletter_logged'];
		} else {
			$data['config_newsletter_logged'] = $this->config->get('config_newsletter_logged');
		}

		if (isset($this->request->post['config_newsletter_shipping'])) {
			$data['config_newsletter_shipping'] = $this->request->post['config_newsletter_shipping'];
		} else {
			$data['config_newsletter_shipping'] = $this->config->get('config_newsletter_shipping');
		}

		if (isset($this->request->post['config_newsletter_status'])) {
			$data['config_newsletter_status'] = $this->request->post['config_newsletter_status'];
		} else {
			$data['config_newsletter_status'] = $this->config->get('config_newsletter_status');
		}

		$data['header']      = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer']      = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('marketing/coupon_newsletter.tpl', $data));

	}

	public function history() {
		//history
		$this->language->load('marketing/coupon_newsletter');

		$this->load->model('marketing/coupon');

		$data['text_no_results'] = $this->language->get('text_no_results');

		$data['column_order_id'] 					= $this->language->get('column_order_id');
		$data['column_customer'] 				  = $this->language->get('column_customer');
		$data['column_amount']            = $this->language->get('column_amount');
		$data['column_date_added']        = $this->language->get('column_date_added');
		$data['column_coupon_date_added'] = $this->language->get('column_coupon_date_added');
		$data['column_coupon_date_end']   = $this->language->get('column_coupon_date_end');
		$data['column_email']             = $this->language->get('column_email');
		$data['column_gender'] 					  = $this->language->get('column_gender');
		$data['column_coupon_value'] 			= $this->language->get('column_coupon_value');
		$data['column_coupon_code'] 			= $this->language->get('column_coupon_code');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  

		$this->load->model('marketing/coupon');
		$data['histories'] = array();

		$results = $this->model_marketing_coupon->getCouponHistoriesNewsletter(($page - 1) * 50, 50);		

		foreach ($results as $result) {
			if($result['date_added']) {
				$date_added = date($this->language->get('date_format_short'), strtotime($result['date_added']));
			} else {
				$date_added = '';
			}
			$data['histories'][] = array(
				'order_id'   				=> $result['order_id'],
				'customer'   				=> $result['customer'],
				'amount'     				=> $result['amount'],
				'code'       				=> $result['code'],
				'value'      				=> $result['discount'],
				'email'      				=> $result['newsletter_email'],
				'gender'     				=> $result['newsletter_gender'],
				'date_added'        => $date_added,
				'status'            => $result['newsletter_status'],
				'date_coupon_added' => date($this->language->get('date_format_short'), strtotime($result['coupon_added'])),
				'date_coupon_end'   => date($this->language->get('date_format_short'), strtotime($result['coupon_end'])),
			);
		}

		$history_total = $this->model_marketing_coupon->getTotalCouponHistoriesNewsletter();

		$pagination = new Pagination();
		$pagination->total = $history_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->url = $this->url->link('marketing/coupon_newsletter/history', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($history_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($history_total - 10)) ? $history_total : ((($page - 1) * 10) + 10), $history_total, ceil($history_total / 10));

		$this->response->setOutput($this->load->view('marketing/coupon_newsletter_history.tpl', $data));

		//---
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'setting/setting')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        
		if (!$this->request->post['config_newsletter_discount']) {
			$this->error['discount'] = $this->language->get('error_newsletter_discount_required');
		}   

		if ( !is_numeric($this->request->post['config_newsletter_discount']) ) {
			$this->error['discount'] = $this->language->get('error_newsletter_discount_number');
		} 

		if ( $this->request->post['config_newsletter_total'] && !is_numeric($this->request->post['config_newsletter_total']) ) {
			$this->error['total'] = $this->language->get('config_newsletter_total');
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}
}
?>