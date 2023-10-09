<?php 
class ControllerPaymentTrfDanamon extends Controller {
	private $error = array(); 

	public function index() {
		$this->load->language('payment/trf_danamon');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
		
			$this->request->post['trf_danamon_image'] = $this->language->get('logo_image');
			$this->request->post['trf_danamon_title'] = $this->language->get('logo_title');
			$this->model_setting_setting->editSetting('trf_danamon', $this->request->post);	
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_logo'] = $this->language->get('text_trf_danamon');
		$data['text_edit'] = $this->language->get('text_edit');
        $data['text_payment_confirmation'] = $this->language->get('text_payment_confirmation');
		
		$data['entry_bank_name'] = $this->language->get('entry_bank_name');
		$data['entry_accountno'] = $this->language->get('entry_accountno');
		$data['entry_accountname'] = $this->language->get('entry_accountname');
		#$data['entry_total'] = $this->language->get('entry_total');	
		$data['entry_order_status'] = $this->language->get('entry_order_status');		
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['accountno'])) {
			$data['error_accountno'] = $this->error['accountno'];
		} else {
			$data['error_accountno'] = '';
		}

  		if (isset($this->error['accountname'])) {
			$data['error_accountname'] = $this->error['accountname'];
		} else {
			$data['error_accountname'] = '';
		}
	
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();
		$data['languages'] = $languages;

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/trf_danamon', 'token=' . $this->session->data['token'], 'SSL')
		);
				
		$data['action'] = $this->url->link('payment/trf_danamon', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['trf_danamon_accountno'])) {
			$data['trf_danamon_accountno'] = $this->request->post['trf_danamon_accountno'];
		} else {
			$data['trf_danamon_accountno'] = $this->config->get('trf_danamon_accountno');
		}
		
		if (isset($this->request->post['trf_danamon_accountname'])) {
			$data['trf_danamon_accountname'] = $this->request->post['trf_danamon_accountname'];
		} else {
			$data['trf_danamon_accountname'] = $this->config->get('trf_danamon_accountname');
		}
		
		if (isset($this->request->post['trf_danamon_total'])) {
			$data['trf_danamon_total'] = $this->request->post['trf_danamon_total'];
		} else {
			$data['trf_danamon_total'] = $this->config->get('trf_danamon_total');
		}
				
		if (isset($this->request->post['trf_danamon_order_status_id'])) {
			$data['trf_danamon_order_status_id'] = $this->request->post['trf_danamon_order_status_id'];
		} else {
			$data['trf_danamon_order_status_id'] = $this->config->get('trf_danamon_order_status_id');
		} 
		
		$this->load->model('localisation/order_status');
		
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		
		if (isset($this->request->post['trf_danamon_geo_zone_id'])) {
			$data['trf_danamon_geo_zone_id'] = $this->request->post['trf_danamon_geo_zone_id'];
		} else {
			$data['trf_danamon_geo_zone_id'] = $this->config->get('trf_danamon_geo_zone_id');
		} 
		
		$this->load->model('localisation/geo_zone');
										
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
		
		if (isset($this->request->post['trf_danamon_status'])) {
			$data['trf_danamon_status'] = $this->request->post['trf_danamon_status'];
		} else {
			$data['trf_danamon_status'] = $this->config->get('trf_danamon_status');
		}
        
		if (isset($this->request->post['trf_danamon_payment_confirmation'])) {
			$data['trf_danamon_payment_confirmation'] = $this->request->post['trf_danamon_payment_confirmation'];
		} else {
			$data['trf_danamon_payment_confirmation'] = $this->config->get('trf_danamon_payment_confirmation');
		}
		
		if (isset($this->request->post['trf_danamon_sort_order'])) {
			$data['trf_danamon_sort_order'] = $this->request->post['trf_danamon_sort_order'];
		} else {
			$data['trf_danamon_sort_order'] = $this->config->get('trf_danamon_sort_order');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');	
		$this->response->setOutput($this->load->view('payment/trf_danamon.tpl', $data));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/trf_danamon')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (empty($this->request->post['trf_danamon_accountno'])) {
			$this->error['accountno'] = $this->language->get('error_accountno');
		}

		if (empty($this->request->post['trf_danamon_accountname'])) {
			$this->error['accountname'] = $this->language->get('error_accountname');
		}
		
		return !$this->error;
	}
}
?>
