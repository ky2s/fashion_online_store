<?php
class ControllerTotalWrapping extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('total/wrapping');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			
			foreach ($this->request->post['wrapping_option'] as $key => $value) {
				if($value['image'] == '' && $value['name'] == '' && $value['price'] == '' && $value['order'] == '') {
					unset($this->request->post['wrapping_option'][$key]);
				}
			}

			$this->model_setting_setting->editSetting('wrapping', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		
		$data['text_default']  = $this->language->get('text_default');
		$data['text_edit']     = $this->language->get('text_edit');
		$data['text_enabled']  = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_none'] 	   = $this->language->get('text_none');

		$data['entry_status']                  = $this->language->get('entry_status');
		$data['entry_sort_order']              = $this->language->get('entry_sort_order');
		$data['entry_width']                   = $this->language->get('entry_width');
		$data['entry_height']                  = $this->language->get('entry_height');
		$data['entry_image_gift_wrap']         = $this->language->get('entry_image_gift_wrap');
		$data['entry_image_gift_wrap_preview'] = $this->language->get('entry_image_gift_wrap_preview');

		$data['text_image'] = $this->language->get('text_image');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_name']  = $this->language->get('text_name');
		$data['text_price'] = $this->language->get('text_price');

		$data['button_save']         = $this->language->get('button_save');
		$data['button_cancel']       = $this->language->get('button_cancel');
		$data['button_remove']       = $this->language->get('button_remove');
		$data['button_add_wrapping'] = $this->language->get('button_add_wrapping');
		
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
			'href' => $this->url->link('total/wrapping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['action'] = $this->url->link('total/wrapping', 'token=' . $this->session->data['token'], 'SSL');

		$data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');


		if (isset($this->request->post['wrapping_status'])) {
			$data['wrapping_status'] = $this->request->post['wrapping_status'];
		} else {
			$data['wrapping_status'] = $this->config->get('wrapping_status');
		}

		if (isset($this->request->post['wrapping_width'])) {
			$data['wrapping_width'] = $this->request->post['wrapping_width'];
		} else {
			$data['wrapping_width'] = $this->config->get('wrapping_width');
		}

		if (isset($this->request->post['wrapping_height'])) {
			$data['wrapping_height'] = $this->request->post['wrapping_height'];
		} else {
			$data['wrapping_height'] = $this->config->get('wrapping_height');
		}

		if (isset($this->request->post['wrapping_width_preview'])) {
			$data['wrapping_width_preview'] = $this->request->post['wrapping_width_preview'];
		} else {
			$data['wrapping_width_preview'] = $this->config->get('wrapping_width_preview');
		}

		if (isset($this->request->post['wrapping_height_preview'])) {
			$data['wrapping_height_preview'] = $this->request->post['wrapping_height_preview'];
		} else {
			$data['wrapping_height_preview'] = $this->config->get('wrapping_height_preview');
		}

		if (isset($this->request->post['wrapping_option'])) {
			$data['wrapping_option'] = $this->request->post['wrapping_option'];
		} else {
			$data['wrapping_option'] = $this->config->get('wrapping_option');
		}

		if (isset($this->request->post['wrapping_sort_order'])) {
			$data['wrapping_sort_order'] = $this->request->post['wrapping_sort_order'];
		} else {
			$data['wrapping_sort_order'] = $this->config->get('wrapping_sort_order');
		}

		$this->load->model('tool/image');
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$arr_tmp = array();
		foreach ($data['wrapping_option'] as $key => $value) {			
			$arr_tmp[$key] = array(
					'name'  => $value['name'],
					'image' => $value['image'],
					'id'    => $value['id'],
					'thumb' => $this->model_tool_image->resize($value['image'], 100, 100),
					'price' => $value['price'],
					'order' => $value['order'],
				);
		}

		$data['wrapping_option'] = $arr_tmp;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('total/wrapping.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'total/wrapping')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['wrapping_width'] || !$this->request->post['wrapping_height']) {
			$this->error['size'] = $this->language->get('error_image_gift_wrap');
		}

		if (!$this->request->post['wrapping_width_preview'] || !$this->request->post['wrapping_height_preview']) {
			$this->error['preview'] = $this->language->get('error_image_preview_gift_wrap');
		}

		return !$this->error;
	}
}