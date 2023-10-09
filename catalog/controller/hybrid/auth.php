<?php

/**
 * OpenCart Ukrainian Community
 *
 * LICENSE
 *
 * This source file is subject to the GNU General Public License, Version 3
 * It is also available through the world-wide-web at this URL:
 * http://www.gnu.org/copyleft/gpl.html
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email

 *
 * @category   OpenCart
 * @package    OCU HybridAuth
 * @copyright  Copyright (c) 2011 Eugene Lifescale by OpenCart Ukrainian Community (http://opencart-ukraine.tumblr.com)
 * @license    http://www.gnu.org/copyleft/gpl.html     GNU General Public License, Version 3
 */



/**
 * @category   OpenCart
 * @package    OCU HybridAuth
 * @copyright  Copyright (c) 2011 Eugene Lifescale by OpenCart Ukrainian Community (http://opencart-ukraine.tumblr.com)
 */

class ControllerHybridAuth extends Controller {

    private $_config = array();
    private $_redirect;

    public function index() {
        
        $this->_prepare();


        // Check if Logged
        if ($this->customer->isLogged()) {
            $this->response->redirect($this->_redirect);
        }

        // Check if module is Enabled
        if (!$this->config->get('hybrid_auth_status')) {
            $this->response->redirect($this->_redirect);
        }

        // Dependencies
        $this->language->load('hybrid/auth');
        require_once(DIR_SYSTEM . 'library/Hybrid/Auth.php');
        $this->load->model('hybrid/auth');

        // Load Config
        $store_url = $this->config->get('config_url');
        $this->_config['base_url']   = $store_url . 'hybridauth.php';
        $this->_config['debug_file'] = DIR_SYSTEM . 'logs/hybridauth.txt';
        $this->_config['debug_mode'] = (bool) $this->config->get('hybrid_auth_debug');
        
        $settings = array();
        $store_id = (int)$this->config->get('config_store_id');
        $providers =  $this->config->get('hybrid_auth') ;
        foreach ($providers as $key => $provider) {
            if($provider['store_id']==$store_id){
                $settings[]=$provider;
                break;
            }
        }

        foreach ($settings as $config) {
            $this->_config['providers'][$config['provider']] = array('enabled' => (bool) $config['enabled'],
                                                                     'keys'    => array('id'     => $config['key'],
                                                                                        'key'    => $config['key'],
                                                                                        'secret' => $config['secret'],
                                                                                        'scope'  => $config['scope']));
        }

        // Receive request
        if (isset($this->request->get['provider'])) {
            $provider = $this->request->get['provider'];
        } else {

            // Save error to the System Log
            $this->log->write('Missing application provider.');

            // Set Message
            $this->session->data['error'] = sprintf("An error occurred, please <a href=\"%s\">notify</a> the administrator.",
                                                    $this->url->link('information/contact'));

            // Redirect to the Login Page
            $this->response->redirect($this->_redirect);
        }

        $this->load->model('affiliate/affiliate');
        $this->load->model('account/customer');
        
        for ($i=1; $i <= 3; $i++) {

            try {
                // Authentication Begin
                $auth = new Hybrid_Auth($this->_config); 
                
                $adapter = $auth->authenticate($provider);     
                
                $user_profile = $adapter->getUserProfile(); 
                //pre($user_profile);
                // 1 - check if user already have authenticated using this provider before
                $customer_id = $this->model_hybrid_auth->findCustomerByIdentifier($provider, $user_profile->identifier);  
                
                if ($customer_id) {
                    
                    $customer_data = $this->model_account_customer->getCustomer($customer_id);
                    
                    $affiliate_data = $this->model_affiliate_affiliate->getTotalAffiliatesByEmail($customer_data['email']);

                    if(!$affiliate_data){
                        //register to affiliate
                        $data_post = array(
                            'name' => $user_profile->firstName.' '. $user_profile->lastName,
                            'email' => $user_profile->email,
                            'telephone' => $user_profile->phone,
                            'address_1' => ($user_address) ? implode(', ', $user_address) : false,
                            'country_id' => $this->model_hybrid_auth->findCountry($user_profile->country),
                            'zone_id' => $this->model_hybrid_auth->findZone($user_profile->region),
                            'city' => $user_profile->city,
                            'postcode' => $user_profile->zip,
                            'password' => substr(rand().microtime(), 0, 6),
                            'confirm' => 1,
                        );
                        $affiliate_id = $this->model_affiliate_affiliate->addAffiliate($data_post);

                        //ADD SESSION AFFILIATE (Affiliate auto login)      
                        $this->session->data['affiliate_id'] = $affiliate_id;
                    }
                    else{
                        //ADD SESSION AFFILIATE (Affiliate auto login)      
                        $this->session->data['affiliate_id'] = $affiliate_data['affiliate_id'];   
                    }

                    // 1.1 Login
                    $this->model_hybrid_auth->login($customer_id);
                   
                    // 1.2 Redirect to Refer Page (auth/success)
                    $this->response->redirect($this->_redirect);
                    //$this->redirect($this->url->link('account/account', '', 'SSL'));
                }

                // 2 - else, here lets check if the user email we got from the provider already exists in our database ( for this example the email is UNIQUE for each user )
                // if authentication does not exist, but the email address returned  by the provider does exist in database,
                // then we tell the user that the email  is already in use
                // but, its up to you if you want to associate the authentication with the user having the address email in the database
                if ($user_profile->email){
                    
                    $customer_id = $this->model_hybrid_auth->findCustomerByEmail($user_profile->email);

                    if ($customer_id) {
                        //pre('cust_id_exist');
                        $affiliate_data = $this->model_affiliate_affiliate->getTotalAffiliatesByEmail($user_profile->email);
                        if(!$affiliate_data){
                            //register to affiliate
                            $data_post = array(
                                'name' => $user_profile->firstName.' '. $user_profile->lastName,
                                'email' => $user_profile->email,
                                'telephone' => $user_profile->phone,
                                'address_1' => ($user_address) ? implode(', ', $user_address) : false,
                                'country_id' => $this->model_hybrid_auth->findCountry($user_profile->country),
                                'zone_id' => $this->model_hybrid_auth->findZone($user_profile->region),
                                'city' => $user_profile->city,
                                'postcode' => $user_profile->zip,
                                'password' => substr(rand().microtime(), 0, 6),
                                'confirm' => 1,
                            );
                            $affiliate_id = $this->model_affiliate_affiliate->addAffiliate($data_post);

                            //ADD SESSION AFFILIATE (Affiliate auto login)      
                            $this->session->data['affiliate_id'] = $affiliate_id;
                        }
                        else{
                            //ADD SESSION AFFILIATE (Affiliate auto login)      
                            $this->session->data['affiliate_id'] = $affiliate_data['affiliate_id'];   
                        }

                        /* Custom */
                        $this->model_hybrid_auth->login($customer_id);
                        $this->response->redirect($this->_redirect);
                        /* End */
                    }
                }

                // 3 - if authentication does not exist and email is not in use, then we create a new user
                $user_address = array();
                if (!empty($user_profile->address)) {
                    $user_address[] = $user_profile->address;
                }

                if (!empty($user_profile->region)) {
                    $user_address[] = $user_profile->region;
                }

                if (!empty($user_profile->country)) {
                    $user_address[] = $user_profile->country;
                }
                
                $birth_date = trim("{$user_profile->birthDay} {$user_profile->birthMonth} {$user_profile->birthYear}");
                if($birth_date) $birth_date = date('Y-m-d',strtotime($birth_date)); 
              
                // 3.1 - create new customer
                $customer_id = $this->model_hybrid_auth->addCustomer(
                    array('email'           => $user_profile->email,
                          'firstname'       => $user_profile->firstName,
                          'lastname'        => $user_profile->lastName,
                          'telephone'       => $user_profile->phone,
                          'fax'             => false,
                          'newsletter'      => true,
                          'gender'          => $user_profile->gender,
                          'company'         => false,
                          'address_1'       => ($user_address ? implode(', ', $user_address) : false),
                          'address_2'       => false,
                          'city'            => $user_profile->city,
                          'postcode'        => $user_profile->zip,
                          'country_id'      => $this->model_hybrid_auth->findCountry($user_profile->country),
                          'zone_id'         => $this->model_hybrid_auth->findZone($user_profile->region),
                          'register_method' => 'facebook',
                          'birth_date'      => $birth_date,
                          'password'        => substr(rand().microtime(), 0, 6)));
                
                //register to affiliate
                $data_post = array(
                    'name' => $user_profile->firstName.' '. $user_profile->lastName,
                    'email' => $user_profile->email,
                    'telephone' => $user_profile->phone,
                    'address_1' => ($user_address) ? implode(', ', $user_address) : false,
                    'country_id' => $this->model_hybrid_auth->findCountry($user_profile->country),
                    'zone_id' => $this->model_hybrid_auth->findZone($user_profile->region),
                    'city' => $user_profile->city,
                    'postcode' => $user_profile->zip,
                    'password' => substr(rand().microtime(), 0, 6),
                    'confirm' => 1,
                );
                $affiliate_id = $this->model_affiliate_affiliate->addAffiliate($data_post);

                //ADD SESSION AFFILIATE (Affiliate auto login)      
                $this->session->data['affiliate_id'] = $affiliate_id;

                // 3.2 - create a new authentication for him
                $this->model_hybrid_auth->addAuthentication(
                    array('customer_id' => (int) $customer_id,
                        'provider' => $provider,
                        'identifier' => $user_profile->identifier,
                        'web_site_url' => $user_profile->webSiteURL,
                        'profile_url' => $user_profile->profileURL,
                        'photo_url' => $user_profile->photoURL,
                        'display_name' => $user_profile->displayName,
                        'description' => $user_profile->description,
                        'first_name' => $user_profile->firstName,
                        'last_name' => $user_profile->lastName,
                        'gender' => $user_profile->gender,
                        'language' => $user_profile->language,
                        'age' => $user_profile->age,
                        'birth_day' => $user_profile->birthDay,
                        'birth_month' => $user_profile->birthMonth,
                        'birth_year' => $user_profile->birthYear,
                        'email' => $user_profile->email,
                        'email_verified' => $user_profile->emailVerified,
                        'phone' => $user_profile->phone,
                        'address' => $user_profile->address,
                        'country' => $user_profile->country,
                        'region' => $user_profile->region,
                        'city' => $user_profile->city,
                        'zip' => $user_profile->zip));

                // 3.3 - login
                $this->model_hybrid_auth->login($customer_id);
                
                // 3.4 - redirect to Refer Page
                $this->response->redirect($this->_redirect);

                break;

            } catch (Exception $e) {

                // Error Descriptions
                switch ($e->getCode()){
                    case 0 : $error = "Unspecified error."; break;
                    case 1 : $error = "Hybriauth configuration error."; break;
                    case 2 : $error = "Provider not properly configured."; break;
                    case 3 : $error = "Unknown or disabled provider."; break;
                    case 4 : $error = "Missing provider application credentials."; break;
                    case 5 : $error = "Authentication failed. The user has canceled the authentication or the provider refused the connection."; break;
                    case 6 : $error = "User profile request failed. Most likely the user is not connected to the provider and he should to authenticate again.";
                             $adapter->logout();
                             break;
                    case 7 : $error = "User not connected to the provider.";
                             $adapter->logout();
                             break;
                }

                $error .= "\n\nHybridAuth Error: " . $e->getMessage();
                $error .= "\n\nTrace:\n " . $e->getTraceAsString();

                $this->log->write($error);
            }

            // sleep 200ms to give the MySQL server time to come back up
            usleep(200000);
       }
    }
    
    private function get_user_data($accsess_token) 
    {
        $context = stream_context_create(array(
            'http' => array(
                'ignore_errors'=>true,
                'method'=>'GET'
            )
        ));
        $graph_url = "https://graph.facebook.com/me?fields=id,name,&access_token=" . $accsess_token;
        $user = json_decode(file_get_contents($graph_url,TRUE,$context));        
        
        return $user;
    }

    private function _prepare() {

        // Some API returns encoded URL
        if (isset($this->request->get) && isset($_GET)) {

            // Prepare for OpenCart
            foreach ($this->request->get as $key => $value) {
                $this->request->get[str_replace('amp;', '', $key)] = $value;
            }

            // Prepare for Library
            foreach ($_GET as $key => $value) {
                $_GET[str_replace('amp;', '', $key)] = $value;
            }
        }

        // Base64 URL Decode
        if (isset($this->request->get['redirect'])) {
            $this->_redirect = base64_decode($this->request->get['redirect']);
        } else {
            $this->_redirect = $this->url->link('account/account');
        }
    }
    
    
    public function success() 
    {

        // paksa redirect ke home
        $data['store_url'] = $this->config->get('config_url');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/hybrid/success.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/hybrid/success.tpl';
        } 
        else {
            $this->template = 'default/template/hybrid/success.tpl';
        }

        $this->response->setOutput($this->load->view($this->template,$data));
    }
    
}
