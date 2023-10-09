<?php



/*

 * To change this template, choose Tools | Templates

 * and open the template in the editor.

 */



/**

 * Description of Myshortcart

 *

 * @lordsanjay

 */

 

class ModelPaymentMyshortcart extends Model

{

    public function getMethod($address, $total)

		{

        

				$this->load->language('payment/myshortcart');

				

				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone" .

																	" WHERE geo_zone_id = '" . (int) $this->config->get('myshortcart_geo_zone_id') . "'" .

																	" AND country_id = '" . (int) $address['country_id'] . "'" .

																	" AND (zone_id = '" . (int) $address['zone_id'] . "' OR zone_id = '0')");

				

				if ($this->config->get('myshortcart_minimal_amount') == 999999999999) 

				{

						$status = true;

				}

				elseif ($this->config->get('myshortcart_minimal_amount') > $total) 

				{

						$status = false;

				} 

				elseif (!$this->config->get('myshortcart_geo_zone_id')) 

				{

						$status = true;

				} 

				elseif ($query->num_rows) 

				{

						$status = true;

				} 

				else 

				{

						$status = false;

				}	

				

				$method_data = array();

			

				if ( $status )

				{  

					$method_data = array( 
						'code'       => 'myshortcart',
						'title'      => $this->config->get('myshortcart_payment_name'),
		        		'terms'      => '<p>' . $this->language->get('text_logo') . '</p>',
						'sort_order' => $this->config->get('myshortcart_sort_order')
					);

				}

			 

				return $method_data;

		

  	}    

}



?>

