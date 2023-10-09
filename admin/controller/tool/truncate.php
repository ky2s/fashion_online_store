<?php
class ControllerToolTruncate extends Controller {
   public function __construct($params) {
      parent::__construct($params);
      $this->load->model('tool/truncate');
   }
    
    public function order(){
        $this->model_tool_truncate->order();
        $this->session->data['success'] = 'Truncate Success';
        $this->response->redirect($this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    }
    
    public function coupon(){
        $this->model_tool_truncate->coupon();
        $this->session->data['success'] = 'Truncate Success';
        $this->response->redirect($this->url->link('marketing/coupon', 'token=' . $this->session->data['token'] . $url, 'SSL'));    }
    
    public function customer(){
        $this->model_tool_truncate->customer();
        $this->session->data['success'] = 'Truncate Success';
        $this->response->redirect($this->url->link('sale/customer', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    }
}