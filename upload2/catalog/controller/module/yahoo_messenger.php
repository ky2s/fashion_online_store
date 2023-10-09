<?php
class ControllerModuleYahooMessenger extends Controller {
	public function index($setting) {
		$this->language->load('module/yahoo_messenger');

    	$data['heading_title'] = $this->language->get('heading_title');
        
        $codes = $setting['yahoomessenger_code'];
        
        if(!$codes){return true;}
        
		$t  = strip_tags($setting['yahoomessenger_style']);
		$tmp = array();

		foreach ($codes as $code){
			$tmp[] = array(
					'link'  => 'ymsgr:sendim?'.html_entity_decode($code['yahooid']),
					'src'   => 'http://opi.yahoo.com/online?u='.html_entity_decode($code['yahooid']).'&amp;m=g&amp;t=' . $t,
					'title' =>  html_entity_decode($code['yahooname'])
				);
		}
		
		$data['codes'] = $tmp;
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/yahoo_messenger.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/yahoo_messenger.tpl', $data);
		} else {
			return $this->load->view('default/template/module/yahoo_messenger.tpl', $data);
		}
	}
}