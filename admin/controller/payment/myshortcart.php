<?php
class ControllerPaymentMyshortcart extends Controller {
	private $error = array(); 

                             
    public function index() 
    {
						
				# Set Initial Parameters
				$this->load->language('payment/myshortcart');
				$this->document->setTitle($this->language->get('heading_title'));		
				$this->load->model('setting/setting');
					
				if ( ($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() ) 
				{
						$this->model_setting_setting->editSetting('myshortcart', $this->request->post);							
						$this->session->data['success'] = $this->language->get('text_success');
						$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
				}
		
						
				# Get Form Data
				$data['heading_title']         = $this->language->get('heading_title');        
				$data['server_params']         = $this->language->get('server_params');
				$data['opencart_params']       = $this->language->get('opencart_params');
				$data['paymentchannel_params'] = $this->language->get('paymentchannel_params');        
				$data['entry_storeid']         = $this->language->get('entry_storeid');
				$data['entry_sharedkey']       = $this->language->get('entry_sharedkey');
				$data['entry_prefix']          = $this->language->get('entry_prefix');
				$data['entry_payment_name']    = $this->language->get('entry_payment_name');
				$data['entry_status']          = $this->language->get('entry_status');
				$data['entry_order_status']    = $this->language->get('entry_order_status');        
				$data['text_all_zones']        = $this->language->get('text_all_zones');
				$data['entry_geo_zone']        = $this->language->get('entry_geo_zone');
				$data['entry_minimal_amount']  = $this->language->get('entry_minimal_amount');
				$data['entry_sort_order']      = $this->language->get('entry_sort_order');
				$data['text_enabled']          = $this->language->get('text_enabled');
				$data['text_disabled']         = $this->language->get('text_disabled');
				$data['text_edit']         	   = "";
				$data['url_title']             = $this->language->get('url_title');
				$data['url_verify']            = $this->language->get('url_verify');
				$data['url_notify']            = $this->language->get('url_notify');
				$data['url_redirect']          = $this->language->get('url_redirect');
				$data['url_cancel']            = $this->language->get('url_cancel');
				$data['button_save']           = $this->language->get('button_save');
				$data['button_cancel']         = $this->language->get('button_cancel');
						
						
				# Set Error Message
				if ( isset($this->error['warning']) ) 
				{
						$data['error_warning'] = $this->error['warning'];
				} 
				else 
				{
						$data['error_warning'] = '';
				}
				
				if ( isset($this->error['storeid']) ) 
				{
						$data['error_storeid'] = $this->error['storeid'];
				} 
				else 
				{
						$data['error_storeid'] = '';
				}
		
				if ( isset($this->error['sharedkey']) ) 
				{
						$data['error_sharedkey'] = $this->error['sharedkey'];
				} 
				else 
				{
						$data['error_sharedkey'] = '';
				}

				if ( isset($this->error['prefix']) ) 
				{
						$data['error_prefix'] = $this->error['prefix'];
				} 
				else 
				{
						$data['error_prefix'] = '';
				}
				
				if ( isset($this->error['payment_method']) ) 
				{
						$data['error_payment_method'] = $this->error['payment_method'];
				} 
				else 
				{
						$data['error_payment_method'] = '';
				}
		
				if ( isset($this->error['minimal_amount']) ) 
				{
						$data['error_minimal_amount'] = $this->error['minimal_amount'];
				} 
				else 
				{
						$data['error_minimal_amount'] = '';
				}
		
				if ( isset($this->error['payment_name']) ) 
				{
						$data['error_payment_name'] = $this->error['payment_name'];
				} 
				else 
				{
						$data['error_payment_name'] = '';
				}
					
						
				# Get POST or Config Data      
				if ( isset($this->request->post['myshortcart_storeid']) ) 
				{
						$data['myshortcart_storeid'] = $this->request->post['myshortcart_storeid'];
				} 
				else 
				{
						$data['myshortcart_storeid'] = $this->config->get('myshortcart_storeid');
				}
				
				if ( isset($this->request->post['myshortcart_sharedkey']) ) 
				{
						$data['myshortcart_sharedkey'] = $this->request->post['myshortcart_sharedkey'];
				} 
				else 
				{
						$data['myshortcart_sharedkey'] = $this->config->get('myshortcart_sharedkey');
				}                  

				if ( isset($this->request->post['myshortcart_prefix']) ) 
				{
						$data['myshortcart_prefix'] = $this->request->post['myshortcart_prefix'];
				} 
				else 
				{
						$data['myshortcart_prefix'] = $this->config->get('myshortcart_prefix');
				}
				
				if ( isset($this->request->post['myshortcart_payment_method']) ) 
				{
						$data['myshortcart_payment_method'] = $this->request->post['myshortcart_payment_method'];
				} 
				else 
				{
						$data['myshortcart_payment_method'] = $this->config->get('myshortcart_payment_method');
				}        
											
				if ( isset($this->request->post['myshortcart_order_status_id']) ) 
				{
						$data['myshortcart_order_status_id'] = $this->request->post['myshortcart_order_status_id'];
				} 
				else 
				{
						$data['myshortcart_order_status_id'] = $this->config->get('myshortcart_order_status_id'); 
				}
				
			
			
				# Payment Channel	
				if ( isset($this->request->post['myshortcart_payment_name']) ) 
				{
						$data['myshortcart_payment_name'] = $this->request->post['myshortcart_payment_name'];
				} 
				else 
				{
						$data['myshortcart_payment_name'] = $this->config->get('myshortcart_payment_name'); 
				}
		
				$this->load->model('localisation/order_status');		
				$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
				
				if ( isset($this->request->post['myshortcart_geo_zone_id']) ) 
				{
						$data['myshortcart_geo_zone_id'] = $this->request->post['myshortcart_geo_zone_id'];
				} 
				else 
				{
						$data['myshortcart_geo_zone_id'] = $this->config->get('myshortcart_geo_zone_id'); 
				} 
		
				$this->load->model('localisation/geo_zone');										
				$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
				
				if ( isset($this->request->post['myshortcart_status']) ) 
				{
						$data['myshortcart_status'] = $this->request->post['myshortcart_status'];
				} 
				else 
				{
						$data['myshortcart_status'] = $this->config->get('myshortcart_status');
				}
		
				if ( isset($this->request->post['myshortcart_minimal_amount']) ) 
				{
						$data['myshortcart_minimal_amount'] = $this->request->post['myshortcart_minimal_amount'];
				} 
				else 
				{
						$data['myshortcart_minimal_amount'] = $this->config->get('myshortcart_minimal_amount'); 
				}
						
				if ( isset($this->request->post['myshortcart_sort_order']) ) 
				{
						$data['myshortcart_sort_order'] = $this->request->post['myshortcart_sort_order'];
				} 
				else 
				{
						$data['myshortcart_sort_order'] = $this->config->get('myshortcart_sort_order');
				}
		
				# Set Breadcrumbs
				$data['breadcrumbs'] = array();
		
				$data['breadcrumbs'][] = array(
					 'text'      => $this->language->get('text_home'),
					 'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
					 'separator' => false
				);
		
				$data['breadcrumbs'][] = array(
					 'text'      => $this->language->get('text_payment'),
					 'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
					 'separator' => ' :: '
				);
		
				$data['breadcrumbs'][] = array(
					 'text'      => $this->language->get('heading_title'),
					 'href'      => $this->url->link('payment/myshortcart', 'token=' . $this->session->data['token'], 'SSL'),
					 'separator' => ' :: '
				);
								
				$data['action'] = $this->url->link('payment/myshortcart', 'token=' . $this->session->data['token'], 'SSL');        
				$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

				$data['header'] = $this->load->controller('common/header');
				$data['column_left'] = $this->load->controller('common/column_left');
				$data['footer'] = $this->load->controller('common/footer');	
				$this->response->setOutput($this->load->view('payment/myshortcart.tpl', $data));				
				
		}

    private function validate()
    {
        if ( !$this->user->hasPermission('modify', 'payment/myshortcart') ) 
        {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ( !$this->request->post['myshortcart_storeid'] ) 
        {
            $this->error['storeid'] = $this->language->get('error_storeid');
        }
        
        if ( !$this->request->post['myshortcart_sharedkey'] ) 
        {
            $this->error['sharedkey'] = $this->language->get('error_sharedkey');
        }        

        if ( !$this->request->post['myshortcart_prefix']  || strlen($this->request->post['myshortcart_prefix']) <> 4 || strpos( $this->request->post['myshortcart_prefix'], "_" ) !== FALSE ) 
        {
            $this->error['prefix'] = $this->language->get('error_prefix');
        }
				
        if ( !$this->request->post['myshortcart_minimal_amount'] || $this->request->post['myshortcart_minimal_amount'] < 1 ) 
        {
            $this->error['minimal_amount'] = $this->language->get('error_minimal_amount');
        }        
				
        if ( !$this->request->post['myshortcart_payment_name'] ) 
        {
            $this->error['payment_name'] = $this->language->get('error_payment_name');
        }
	
				if ( !$this->error ) 
				{
						return true;
				} 
				else 
				{
						return false;
				}	
		}
}

?>
