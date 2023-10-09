<?php

class ControllerCommonHome extends Controller {

	

	public function index() {

		

		/*$str = explode('-','kyky-3');

		$last = end($str);

		$key = key($str); 

		$str[$key] = (int)$last + 1;

	    $code = implode($str,'-');	

		pre($code);*/

		/*$this->load->model('affiliate/affiliate');

		$affiliate = $this->model_affiliate_affiliate->checkAffiliateCode('ando');

		pre($affiliate['code']);*/



		// Affiliate

		$this->load->model('affiliate/affiliate');



		//$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

		//if($affiliate_info){

			//$this->response->redirect($this->url->link('common/referral', '', 'SSL'));			

		//}

		//pre($this->request->cookie['tracking']);

		//pre($affiliate_info);

		

		$this->document->setTitle($this->config->get('config_meta_title'));

		$this->document->setDescription($this->config->get('config_meta_description'));

		$this->document->setKeywords($this->config->get('config_meta_keyword'));



		if (isset($this->request->get['route'])) {

			$this->document->addLink(HTTP_SERVER, 'canonical');

		}

		

		## CUSTOM BY STEPH ##

		$this->load->model('setting/setting');

		$this->load->model('design/banner');

		$this->load->model('tool/image');



		$data['banners'] = array();

		

		$config = $this->model_setting_setting->getSetting('config', $this->config->get('config_store_id'));

		$results = $this->model_design_banner->getBanner($config['config_banner_id']);

		foreach ($results as $result) {

			if (is_file(DIR_IMAGE . $result['image'])) {

				if($config['config_banner_status']){

					

					$data['banners'][] = array(

						'title' => $result['title'],

						'link'  => $result['link'],

						'image' => $this->model_tool_image->resize($result['image'], $config['config_banner_width'], $config['config_banner_height'])

					);

				}

			}

		}

		

		//essential

		$this->load->model('catalog/information');

		$store_user = array(
			0 => 22,
			1 => 37, //omar
			10 => 38, //Riska
			17 => 39, //Stella
		);



		$data['essential'] = array();

		foreach ($store_user as $store_id => $information_id) {

			if($this->config->get('config_store_id') == $store_id){

				$essential_result = $this->model_catalog_information->getInformation($information_id);

				if(!empty($essential_result['description'])){

					$data['essential'] = $essential_result['description'];

				}

				break;

			}

		}



		$data['column_left'] = $this->load->controller('common/column_left');

		$data['column_right'] = $this->load->controller('common/column_right');

		$data['content_top'] = $this->load->controller('common/content_top');

		$data['content_bottom'] = $this->load->controller('common/content_bottom');

		$data['footer'] = $this->load->controller('common/footer');

		$data['header'] = $this->load->controller('common/header_home');

	

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {

			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/home.tpl', $data));

		} else {

			$this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));

		}

	}

}