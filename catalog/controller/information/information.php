<?php
class ControllerInformationInformation extends Controller {
	public function index() {

		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$this->document->addScript('catalog/view/javascript/slick/slick.js');
		$this->document->addScript('catalog/view/javascript/sticky/jquery.sticky.js');
		$this->document->addStyle('catalog/view/javascript/slick/slick.css');
		$this->document->addStyle('catalog/view/javascript/slick/slick-theme.css');


		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);


		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$information_info = $this->model_catalog_information->getInformation($information_id);
		//pre($information_info);
		if ($information_info) {
			$this->document->setTitle($information_info['meta_title']);
			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);
			$this->session->data['redirect'] = $this->url->link('information/information', 'information_id=' .  $information_id);

			$data['heading_title'] = "";

			$data['button_continue'] = $this->language->get('button_continue');

			/*BANNER*/
			//PRE($information_info['image']);
			$this->load->model('tool/image');
			$data['banner'] = $this->url->link($information_info['image']);
			if ($information_info['image']) {
				$data['banner'] = $this->model_tool_image->resize($information_info['image'], 1263, 406);
			} else {
				$data['banner'] = '';
			}
			//pre($data['banner']);

			$data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$data['continue'] = $this->url->link('common/home');
			$social_media = array();
			if($this->request->get['information_id'] == 4){ //4 = information id About US
				//social media
				$data['facebook'] = '';
				$data['twitter'] = '';
				$data['instagram'] = '';
				$data['snapchat'] = '';

				if ($this->config->get('config_facebook')) {
					$social_media[] = array(
						'name' => 'Facebook',
						'link' => $this->config->get('config_facebook'),
						'icon' => 'sosmed-fb',
					);
				}
				if ($this->config->get('config_twitter')) {
					$social_media[] = array(
						'name' => 'Twitter',
						'link' => $this->config->get('config_twitter'),
						'icon' => 'sosmed-twitter',
					);
				}
				if ($this->config->get('config_instagram')) {
					$social_media[] = array(
						'name' => 'Instagram',
						'link' => $this->config->get('config_instagram'),
						'icon' => 'sosmed-instagram',
					);
				}
				if ($this->config->get('config_snapchat')) {
					$social_media[] = array(
						'name' => 'Snapchat',
						'link' => $this->config->get('config_snapchat'),
						'icon' => 'sosmed-snapchat',
					);
				}
			}
			$data['social_media'] = $social_media;
			//pre($social_media);
			$data['banner_page'] = $this->request->get['information_id'];
			$data['column_left'] = "";
			$data['column_right'] = "";
			$data['content_top'] = "";
			$data['content_bottom'] = "";
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/information.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/information.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/information/information.tpl', $data));
			}
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);
			$this->session->data['redirect'] = $this->url->link('information/information', 'information_id=' .  $information_id);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}