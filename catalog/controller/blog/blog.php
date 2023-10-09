<?php
class ControllerBlogBlog extends Controller {

	public function index() {
        
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');
        
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/blog/blog.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/blog/blog.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/blog/blog.tpl', $data));
		}
	}
    
}