<?php
class ControllerModuleYahooMessenger extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/yahoo_messenger');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('yahoo_messenger', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['heading_yahoo_style'] = $this->language->get('heading_yahoo_style');
		$data['heading_yahoo_user'] = $this->language->get('heading_yahoo_user');
		
		$data['text_edit']     = $this->language->get('text_edit');
		$data['text_enabled']  = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		
		$data['entry_name']   = $this->language->get('entry_name');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['entry_yahoo_display_name'] = $this->language->get('entry_yahoo_display_name');
		$data['entry_yahoo_id']           = $this->language->get('entry_yahoo_id');		

		$data['button_save']   = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/yahoo_messenger', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/yahoo_messenger', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);			
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/yahoo_messenger', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/yahoo_messenger', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($module_info)) {
			$data['name'] = $module_info['name'];
		} else {
			$data['name'] = '';
		}
							
		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = '';
		}

		if (isset($this->request->post['yahoomessenger_code'])) {
			$data['yahoomessenger_code'] = $this->request->post['yahoomessenger_code'];
		} elseif (!empty($module_info)) {
			$data['yahoomessenger_code'] = $module_info['yahoomessenger_code'];
		} else {
			$data['yahoomessenger_code'] = '';
		}

		if (isset($this->request->post['yahoomessenger_style'])) {
			$data['yahoomessenger_style'] = $this->request->post['yahoomessenger_style'];
		} elseif (!empty($module_info)) {
			$data['yahoomessenger_style'] = $module_info['yahoomessenger_style'];
		} else {
			$data['yahoomessenger_style'] = '';
		}

		if (isset($this->request->post['yahoomessenger_module'])) {
			$data['modules'] = $this->request->post['yahoomessenger_module'];
		} elseif (!empty($module_info)) {
			$data['modules'] = $module_info['yahoomessenger_module'];
		} else {
			$data['modules'] = array();
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/yahoo_messenger.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/yahoo_messenger')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (! isset($this->request->post['yahoomessenger_code'])) {
			$this->error['code'] = $this->language->get('error_code');
		}
		
		if (! isset($this->request->post['yahoomessenger_style'])) {
			$this->error['style'] = $this->language->get('error_style');
		}
		
		return !$this->error;
	}
}