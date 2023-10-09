<?php
class ControllerTotalGiftCard extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('total/gift_card');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			
			foreach ($this->request->post['gift_card_option'] as $key => $value) {
				if($value['image'] == '' && $value['name'] == '' && $value['price'] == '' && $value['order'] == '') {
					unset($this->request->post['gift_card_option'][$key]);
				}
			}

			$this->model_setting_setting->editSetting('gift_card', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_default'] 	= $this->language->get('text_default');	
		$data['text_edit'] 			= $this->language->get('text_edit');
		$data['text_enabled'] 	= $this->language->get('text_enabled');
		$data['text_disabled'] 	= $this->language->get('text_disabled');
		$data['text_none'] 			= $this->language->get('text_none');

		$data['entry_status'] 								 	= $this->language->get('entry_status');
		$data['entry_sort_order'] 						 	= $this->language->get('entry_sort_order');
		$data['entry_width'] 									 	= $this->language->get('entry_width');
		$data['entry_height'] 								 	= $this->language->get('entry_height');
		$data['entry_image_gift_card'] 				 	= $this->language->get('entry_image_gift_card');
		$data['entry_image_gift_card_preview']	= $this->language->get('entry_image_gift_card_preview');

		$data['text_image'] = $this->language->get('text_image');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_name']  = $this->language->get('text_name');
		$data['text_price'] = $this->language->get('text_price');

		$data['button_save']   				= $this->language->get('button_save');
		$data['button_cancel'] 				= $this->language->get('button_cancel');
		$data['button_remove'] 				= $this->language->get('button_remove');
		$data['button_add_gift_card'] = $this->language->get('button_add_gift_card');
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['size'])) {
			$data['error_size'] = $this->error['size'];
		} else {
			$data['error_size'] = '';
		}

		if (isset($this->error['preview'])) {
			$data['error_preview'] = $this->error['preview'];
		} else {
			$data['error_preview'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_total'),
			'href' => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('total/gift_card', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('total/gift_card', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['gift_card_status'])) {
			$data['gift_card_status'] = $this->request->post['gift_card_status'];
		} else {
			$data['gift_card_status'] = $this->config->get('gift_card_status');
		}

		if (isset($this->request->post['gift_card_width'])) {
			$data['gift_card_width'] = $this->request->post['gift_card_width'];
		} else {
			$data['gift_card_width'] = $this->config->get('gift_card_width');
		}

		if (isset($this->request->post['gift_card_height'])) {
			$data['gift_card_height'] = $this->request->post['gift_card_height'];
		} else {
			$data['gift_card_height'] = $this->config->get('gift_card_height');
		}

		if (isset($this->request->post['gift_card_width_preview'])) {
			$data['gift_card_width_preview'] = $this->request->post['gift_card_width_preview'];
		} else {
			$data['gift_card_width_preview'] = $this->config->get('gift_card_width_preview');
		}

		if (isset($this->request->post['gift_card_height_preview'])) {
			$data['gift_card_height_preview'] = $this->request->post['gift_card_height_preview'];
		} else {
			$data['gift_card_height_preview'] = $this->config->get('gift_card_height_preview');
		}

		if (isset($this->request->post['gift_card_option'])) {
			$data['gift_card_option'] = $this->request->post['gift_card_option'];
		} else {
			$data['gift_card_option'] = $this->config->get('gift_card_option');
		}

		if (isset($this->request->post['gift_card_sort_order'])) {
			$data['gift_card_sort_order'] = $this->request->post['gift_card_sort_order'];
		} else {
			$data['gift_card_sort_order'] = $this->config->get('gift_card_sort_order');
		}

		$this->load->model('tool/image');
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$arr_tmp = array();
		foreach ($data['gift_card_option'] as $key => $value) {			
			$arr_tmp[$key] = array(
					'name'  => $value['name'],
					'image' => $value['image'],
					'id'    => $value['id'],
					'thumb' => $this->model_tool_image->resize($value['image'], 100, 100),
					'price' => $value['price'],
					'order' => $value['order'],
				);
		}

		$data['gift_card_option'] = $arr_tmp;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('total/gift_card.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'total/gift_card')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['gift_card_width'] || !$this->request->post['gift_card_height']) {
			$this->error['size'] = $this->language->get('error_image_gift_card');
		}

		if (!$this->request->post['gift_card_width_preview'] || !$this->request->post['gift_card_height_preview']) {
			$this->error['preview'] = $this->language->get('error_image_preview_gift_card');
		}

		return !$this->error;
	}
}