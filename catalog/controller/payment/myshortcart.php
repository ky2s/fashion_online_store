<?php
class ControllerPaymentMyshortcart extends Controller {
    
    private $ip_range = "103.10.128.";
   
    public function index() {

        $data = $this->getServerConfig();
        
		$this->language->load('payment/myshortcart');
		$this->load->model('checkout/order');
				
		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
						
		# PRODUCT ITEM
		$StringProduk = '' ;
		$total = 0;
		foreach ($this->cart->getProducts() as $product) 
		{
			$product_name = preg_replace("/([^a-zA-Z0-9.\-,=:;&% ]+)/", " ", $product['name']);
			
			$StringProduk .= str_replace(array('.',','), '', $product_name).',';
			$StringProduk .= $product['price'].',';
			$StringProduk .= $product['quantity'].',';
			$StringProduk .= $product['total'].';';
			
			$total += $product['total'];	    		    
		}

		$data['data_product'] = $StringProduk;
		
		# COUPON
		if ( isset($this->session->data['coupon']) )
		{
			$coupon = $this->model_checkout_coupon->getCoupon($this->session->data['coupon']);
			
			switch ( $coupon['type'] )
			{
				case "F":
					$coupon_amount = $coupon['discount'];
				break;
					
				case "P":
					$coupon_amount = ( $coupon['discount'] * $total ) / 100;
				break;
			}
			
			$coupon_amount = number_format( $coupon_amount, 2, '.', '' );
			$data['data_product'] .= "Coupon,-$coupon_amount,1,-$coupon_amount;";
			
			$total = number_format( $total - $coupon_amount, 2, '.', '' );
		}
		else
		{
			$total = number_format( $total, 2, '.', '' );
		}
		
		# TAX		
		$total_tax = $this->tax->getTax($total, $product['tax_class_id']);
		$total_tax = number_format( $total_tax, 2, '.', '' );
		$tax = "Tax,$total_tax,1,$total_tax;";
		$data['data_product'] .= $tax;		
		
		# SHIPPING
		if ( !empty($this->session->data['shipping_method']['cost']) )
		{
			$shipping_cost = number_format( $this->session->data['shipping_method']['cost'], 2, '.', '' );
			$ship = "Shipping,$shipping_cost,1,$shipping_cost;";
			$data['data_product'] .= $ship;
		}
		
		# VOUCHER
		if ( isset($this->session->data['voucher']) )
		{
			$voucher = $this->model_checkout_voucher->getVoucher($this->session->data['voucher']);		    
			$voucher_amount = number_format( $voucher['amount'], 2, '.', '' );
			
			if ( !empty($voucher_amount) )
			{
				$data['data_product'] .= "Voucher,-$voucher_amount,1,-$voucher_amount;";
			}
		}

		/*Omomart discount*/
		/*
		$this->load->model('total/discount');
		$discount_total = array();
		$discount_value = 0;
		$discount_taxes = $this->cart->getTaxes();
		$this->model_total_discount->getTotal($discount_total,$discount_value,$discount_taxes);
		
		if(! empty($discount_total[0])){
			$data['data_product'] .= "Discount Omomart,{$discount_total[0]['value']},1,{$discount_total[0]['value']};";
		}
		*/
		
		$data['msc_amount'] = number_format($order_info['total'], 2, '.', '');
		$this->load->model('extension/extension');
		$results = $this->model_extension_extension->getExtensions('total');
		$xfee = array();
		foreach ($results as $result) {
			if ( strpos($result['code'], 'xfee') !== false && $this->config->get($result['code'] . '_status')) {
				$this->load->model('total/' . $result['code']);

				$this->{'model_total_' . $result['code']}->getTotal($xfee, $total, $product['tax_class_id']);
			}
		}

		foreach($xfee as $fee){
			$data['data_product'] .= "{$fee['title']},{$fee['value']},1,{$fee['value']};";
		}
    
		if ($this->customer->isLogged())
		{	        
			$data['email'] 	          = $this->customer->getEmail();
			$data['telephone'] 	      = $this->customer->getTelephone();
							
			$this->load->model('account/address');
			//pre($this->session->data);
			$trx_data = $this->session->data['shipping_address'];			    
		}
		elseif (isset($this->session->data['guest']))            
		{
			$data['email'] 	          = $this->session->data['guest']['email'];
			$data['telephone'] 	      = $this->session->data['guest']['telephone'];
					
			$trx_data = $this->session->data['guest']['payment'];
		}
	    
		$data['button_confirm']      = $this->language->get('button_confirm');
		$data['transidmerchant']     = $this->session->data['order_id'];
		$data['msc_transidmerchant'] = $data['msc_prefix'] . "_" . $this->session->data['order_id'];
		$data['msc_words']           = sha1(trim($data['msc_amount']).trim($data['msc_sharedkey']).trim($data['msc_transidmerchant']));
		$data['msc_allname']         = $trx_data['firstname'] .' '.$trx_data['lastname'] ;        
		$data['msc_address_1']       = $trx_data['address_1'].' ';
		$data['msc_address_2']       = $trx_data['address_2'];
		$data['msc_city']            = $trx_data['city'];
		$data['msc_postcode']        = $trx_data['postcode'];
		$data['msc_zone']            = $trx_data['zone'];
		$data['msc_country_id']      = $trx_data['country_id'];

		$trx['ip_address']           = $this->getipaddress();
		$trx['process_datetime']     = date("Y-m-d H:i:s");
		$trx['process_type']         = 'REQUEST';
		$trx['transidmerchant']      = $this->session->data['order_id'];
		$trx['msc_transidmerchant']  = $data['msc_transidmerchant'];
		$trx['amount']               = $data['msc_amount'];
		$trx['words']                = $data['msc_words'];
											
        $this->add_myshortcart($trx);
	
		$this->load->model('checkout/voucher');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/myshortcart.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/payment/myshortcart.tpl', $data);
		} else {
			return $this->load->view('default/template/payment/myshortcart.tpl', $data);
		}

    }	 
	
	public function myverify(){
		$data = $this->getServerConfig();
        //pre($data);
        if ( empty($this->request->post) )
        {
            echo "Stop : Access Not Valid";
			$this->log->write("Myshortcart Verify Not in Correct Format - IP Logged ".$this->getipaddress());	    
            die;
        }
                        
        if (substr($this->getipaddress(),0,strlen($this->ip_range)) !== $this->ip_range)
        {
            echo "Stop : IP Not Allowed";
			$this->log->write("Myshortcart Verify From IP Not Allowed - IP Logged ".$this->getipaddress());
        }
        else
        {	    
			$trx = array();
			
			$transidmerchant = explode( "_", $this->request->post['TRANSIDMERCHANT'] );
			
			$trx['words']                     = $this->request->post['WORDS'];
			$trx['amount']                    = $this->request->post['AMOUNT'];
			$trx['transidmerchant']           = $transidmerchant[1];
			$trx['msc_transidmerchant']       = $this->request->post['TRANSIDMERCHANT'];


			$words =  sha1(trim($trx['amount']).
					  trim($data['msc_sharedkey']).
					  trim($trx['msc_transidmerchant']));
	        
	        if ( $trx['words']==$words )
	        {		    
		        $trx['ip_address']            = $this->getipaddress();
            	$trx['process_datetime']      = date("Y-m-d H:i:s");
				$trx['process_type']          = 'VERIFY';
		        		        
		        $result = $this->checkTrx($trx);
		        
		        if ( $result < 1 )
		        {
		            echo "Stop : Transaction Not Found";
						$this->log->write("Myshortcart Verify Can Not Find Transactions - IP Logged ".$this->getipaddress());
		            die;		    
		        }
		        else
		        {
		            $this->add_myshortcart($trx);
		            $this->load->model('checkout/order');
                	$this->model_checkout_order->addOrderHistory($trx['transidmerchant'], 1, 'Myshortcart Transaction Verify');								
                    
		            echo "Continue";
		        }
	        }
	        else
	        {
		        echo "Stop : Request Not Valid";
					$this->log->write("Myshortcart Verify Words Not Correct - IP Logged ".$this->getipaddress());
		        die;
	        }
        }        
    }
        
	public function mynotify(){
		$data = $this->getServerConfig();

        if ( empty($this->request->post) )
        {
            echo "Stop : Access Not Valid";
			$this->log->write("Myshortcart Notify Not in Correct Format - IP Logged ".$this->getipaddress());	    
            die;
        }
                        
        if (substr($this->getipaddress(),0,strlen($this->ip_range)) !== $this->ip_range)
        {
            echo "Stop : IP Not Allowed";
			$this->log->write("Myshortcart Notify From IP Not Allowed - IP Logged ".$this->getipaddress());
        }
        else
        {	    
			$trx = array();						
			$transidmerchant = explode( "_", $this->request->post['TRANSIDMERCHANT'] );
			
			$trx['amount']              = $this->request->post['AMOUNT'];
			$trx['transidmerchant']     = $transidmerchant[1];
			$trx['msc_transidmerchant'] = $this->request->post['TRANSIDMERCHANT'];
			$trx['result_msg']          = $this->request->post['RESULT'];
    		$trx['ip_address']          = $this->getipaddress();
			$trx['process_datetime']    = date("Y-m-d H:i:s");
			$trx['process_type']        = 'NOTIFY';
		        
	        $result = $this->checkTrx($trx);
	        
	        if ( $result < 1 )
	        {
	            echo "Stop : Transaction Not Found";
				$this->log->write("Myshortcart Notify Can Not Find Transactions - IP Logged ".$this->getipaddress());
	            die;		    
	        }
	        else
	        {
	            $this->add_myshortcart($trx);
	            $this->load->model('checkout/order');

				if ( strtolower($trx['result_msg'])=="success" )
				{
					$this->model_checkout_order->addOrderHistory($trx['transidmerchant'], 17, 'Myshortcart Payment Success', true);
					$this->clearCustomerCart();
				}
				else
				{
					$this->model_checkout_order->addOrderHistory($trx['transidmerchant'], 7, 'Myshortcart Payment Failed', true);
				}
						                 
				$this->updateTrx($trx);										 
							   
	            echo "Continue";
	        }
        }        
    }
        
    public function myredirect(){
    	$data = $this->getServerConfig();

        if ( empty($this->request->post) )
        {
            echo "Stop : Access Not Valid";
				$this->log->write("Myshortcart Redirect Not in Correct Format - IP Logged ".$this->getipaddress());	    
            die;
        }

		$transidmerchant = explode( "_", $this->request->post['TRANSIDMERCHANT'] );
						
        $trx['amount']               = $this->request->post['AMOUNT'];
		$trx['transidmerchant']      = $transidmerchant[1];
		$trx['msc_transidmerchant']  = $this->request->post['TRANSIDMERCHANT'];
        $trx['status_code']          = $this->request->post['STATUSCODE'];
        
        if ( isset($this->request->post['PAYMENTCODE']) ) $data['payment_code'] = $this->getipaddress();
       
		$trx['result_msg']       = $this->request->post['RESULT'];
		$trx['payment_datetime'] = $this->request->post['TRANSDATE'];
		$trx['payment_channel']  = $this->request->post['PTYPE'];
		$trx['extra_info']       = $this->request->post['EXTRAINFO'];
		$trx['ip_address']       = $this->getipaddress();
		$trx['process_datetime'] = date("Y-m-d H:i:s");
		$trx['process_type']     = 'REDIRECT';
 
		$this->add_myshortcart($trx);
		$this->load->model('checkout/order');
						
		if ( $trx['status_code']=="00" || strtolower($trx['result_msg']) == 'success' )
		{
			$this->clearCustomerCart();
			$this->myshortcartsuccess();						
		}
		else
		{
			$result = $this->checkTrx($trx);
			
			if ( ( strtolower($trx['payment_channel'])=="bank transfer" || strtolower($trx['payment_channel'])=="alfamart" ) && $result > 0  )
			{
				$this->model_checkout_order->addOrderHistory($trx['transidmerchant'], 1, 'Myshortcart Payment Pending');
				$this->myshortcartpending();		
			}
			else
			{
				$this->model_checkout_order->addOrderHistory($trx['transidmerchant'], 7, 'Myshortcart Payment Failed', true);
				$this->myshortcartcancel();		
			}
		}            

    }

    public function myshortcartcancel()
    {
        $this->load->model('checkout/order');
        $this->response->redirect($this->url->link('checkout/myshortcart_cancel'));
    }

    public function myshortcartpending()
    {
        $this->load->model('checkout/order');
        $this->response->redirect($this->url->link('checkout/myshortcart_pending'));
    }
		
    public function myshortcartsuccess() 
    {
        $this->load->model('checkout/order');
        $this->response->redirect($this->url->link('checkout/success'));
    }
        
    private function checkTrx($trx)
    {
    	$sql = "SELECT * FROM " . DB_PREFIX . "myshortcart" .
		                              " WHERE process_type = 'REQUEST'" .
		                              " AND transidmerchant = '" . $trx['transidmerchant'] . "'" .
		                              " AND amount = '". $trx['amount'] . "'" .
							          " AND check_flag = 0";
        $query = $this->db->query( $sql );
				
        return $query->num_rows;
    }

    private function updateTrx($trx)
    {
				$query = $this->db->query("UPDATE " . DB_PREFIX . "myshortcart" .
										              " SET check_flag = 1".
										              " WHERE process_type = 'REQUEST'" .
										              " AND transidmerchant = '" . $trx['transidmerchant'] . "'" .
										              " AND amount = '". $trx['amount'] . "'" );     
				
        return TRUE;
    }
        
    private function add_myshortcart($datainsert) 
    {
        $SQL = "";
        
        foreach ( $datainsert as $field_name=>$field_data )
        {
            $SQL .= " $field_name = '$field_data',";
        }
        $SQL = substr( $SQL, 0, -1 );

        $this->db->query("INSERT INTO " . DB_PREFIX . "myshortcart SET $SQL");
    }
     
    private function getipaddress()    
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP']))
        {
            $ip=$_SERVER['HTTP_CLIENT_IP'];
        }
        elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
        {
            $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
        }
        else
        {
            $ip=$_SERVER['REMOTE_ADDR'];
        }

        return $ip;
    }
		
    private function clearCustomerCart()
    {
    
				$this->cart->clear();

				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
				unset($this->session->data['guest']);
				unset($this->session->data['comment']);
				unset($this->session->data['order_id']);	
				unset($this->session->data['coupon']);
				unset($this->session->data['reward']);
				unset($this->session->data['voucher']);
				unset($this->session->data['vouchers']);
    
    }

    private function getServerConfig()
    {
		$data['msc_action']         = 'https://apps.myshortcart.com/payment/request-payment/';
		$data['msc_storeid']        = $this->config->get('myshortcart_storeid');
		$data['msc_sharedkey']      = $this->config->get('myshortcart_sharedkey');
		$data['msc_prefix']         = $this->config->get('myshortcart_prefix');    

		return $data;
    }
    
    public function myprocess()
    {
        $transidmerchant = $this->request->post['TRANSIDMERCHANT'];
        $this->load->model('checkout/order');        
        //$this->model_checkout_order->confirm($transidmerchant, $this->config->get('myshortcart_order_status_id'));
        $this->model_checkout_order->addOrderHistory($transidmerchant, $this->config->get('myshortcart_order_status_id'), 'Myshortcart Payment Initiate');
    }
		
}

?>
