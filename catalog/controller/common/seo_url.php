<?php
class ControllerCommonSeoUrl extends Controller {

	private $url_list = array (
        'common/home'           => 'home',
        'checkout/cart'         => 'cart',
        'checkout/checkout'     => 'checkout',
        'checkout/refund'     => 'refund',
        'checkout/refund_success'     => 'refund-success',
        'account/voucher'       => 'voucher',
        'product/special'       => 'special',
        'affiliate/account'     => 'affiliate',
        'product/manufacturer'  => 'brand',
        'information/contact'   => 'contact',
        'information/sitemap'   => 'sitemap',        
		'information/payment_confirmation'   => 'payment-confirmation',
		'information/payment_confirmation_success'   => 'payment-confirmation-success',
        'account/register'      => 'register',
        'account/wishlist'      => 'wishlist',
        'account/login'         => 'login',
        'account/logout'        => 'logout',
		'account/forgotten'     => 'forgot-password',
        'account/return/add'    => 'return',
        'account/newsletter'    => 'newsletter',
        'account/order'         => 'order',
        'account/account'       => 'account',
        'account/transaction'   => 'referral',
        'account/edit'          => 'edit-profile',
        'account/password'      => 'edit-password',
        'account/address'       => 'address-book',
        'account/return'        => 'account/return',
        'account/download'      => 'download',
        'account/reward'        => 'reward',
        'account/recurring'     => 'recurring',
        'common/influencer'     => 'influencer',
        'simple_blog/article'     => 'blog',
        'common/referral'     => 'referral-page',
        );

	public function index() {

		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}

		// Decode URL
		if (isset($this->request->get['_route_'])) 
		{
			if ($this->request->server['HTTPS']) {
   				$base = HTTPS_SERVER;
   			} else {
   				$base = HTTP_SERVER;
   			}

			$parts = explode('/', $this->request->get['_route_']);
			$ref = $parts;
			//pre($ref);
			if(count($ref) == 2 && $ref[0] == 'r'){
				$part = $ref[1];

				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

				if ($query->num_rows) {

					$url = explode('=', $query->row['query']);
					
					if ($url[0] == 'referral_id') {

						$this->load->model('affiliate/affiliate');
						$affiliate = $this->model_affiliate_affiliate->getAffiliate($url[1]);
						
						$this->session->data['affiliate_code'] = $affiliate['code'];
						$this->response->redirect($this->url->link('common/referral'));
					}
					else{
						$this->response->redirect($base);	
					}
					
					/* SEO Custom URL */
		          	if ( $_s = $this->setURL($this->request->get['_route_']) ) {
			            $this->request->get['route'] = $_s;
			            //break;              
		          	}/* SEO Custom URL */

				} else {
					$this->response->redirect($base);
					//$this->request->get['route'] = 'error/not_found';
					//break;
				}
			}
			else{
				// remove any empty arrays from trailing
				if (utf8_strlen(end($parts)) == 0) {
					array_pop($parts);
				}

				foreach ($parts as $part) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

					if ($query->num_rows) {
						$url = explode('=', $query->row['query']);
						// /pre($url);
						if ($url[0] == 'product_id') {
							$this->request->get['product_id'] = $url[1];
						}

						if ($url[0] == 'category_id') {
							if (!isset($this->request->get['path'])) {
								$this->request->get['path'] = $url[1];
							} else {
								$this->request->get['path'] .= '_' . $url[1];
							}
						}

						if ($url[0] == 'manufacturer_id') {
							$this->request->get['manufacturer_id'] = $url[1];
						}

						if ($url[0] == 'information_id') {
							$this->request->get['information_id'] = $url[1];
						}

						if ($url[0] == 'simple_blog_article_id') {
							$this->request->get['simple_blog_article_id'] = $url[1];
						}

						if ($url[0] == 'simple_blog_category_id') {
							$this->request->get['simple_blog_category_id'] = $url[1];
						}

						if ($url[0] == 'common/referral') {
							//$this->request->get['simple_blog_category_id'] = $url[1];
						}

						if ($query->row['query'] && $url[0] != 'information_id' && $url[0] != 'manufacturer_id' && $url[0] != 'category_id' && $url[0] != 'product_id' && $url[0] != 'simple_blog_article_id' && $url[0] != 'simple_blog_category_id') {
							$this->request->get['route'] = $query->row['query'];
						}
						/* SEO Custom URL */
			          	if ( $_s = $this->setURL($this->request->get['_route_']) ) {
				            $this->request->get['route'] = $_s;
				            break;              
			          	}/* SEO Custom URL */

					} else {
						$this->response->redirect($base);
						//$this->request->get['route'] = 'error/not_found';
						//pre('k');
						//$this->request->get['route'] = 'http://lab.gositus.com/roepistore2/';
						break;
					}				
				}

			}

			//echo $this->request->get['route']; exit;  

			if (!isset($this->request->get['route'])) {
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				} elseif (isset($this->request->get['path'])) {
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';
				} elseif (isset($this->request->get['simple_blog_article_id'])) {
					$this->request->get['route'] = 'simple_blog/article/view';
				}elseif (isset($this->request->get['simple_blog_category_id'])) {
					$this->request->get['route'] = 'simple_blog/category';
				}
			}

			if (isset($this->request->get['route'])) {
				
				return new Action($this->request->get['route']);
			}
		}
	}

	public function rewrite($link) {
		$url_info = parse_url(str_replace('&amp;', '&', $link));

		$url = '';

		$data = array();

		parse_str($url_info['query'], $data);

		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id') || ($data['route'] == 'simple_blog/article/view' && $key == 'simple_blog_article_id') || ($data['route'] == 'simple_blog/category' && $key == 'simple_blog_category_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'];

						unset($data[$key]);
					}				
				} elseif ($key == 'path') {
					$categories = explode('_', $value);

					foreach ($categories as $category) {
						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}

					unset($data[$key]);
				}

				/* SEO Custom URL */
        if( $_u = $this->getURL($data['route']) ){
            $url .= $_u;
            unset($data[$key]);
        }/* SEO Custom URL */ 
			}
		}

		if ($url) {
			unset($data['route']);

			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((string)$value);
				}

				if ($query) {
					$query = '?' . str_replace('&', '&amp;', trim($query, '&'));
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {
			return $link;
		}
	}

	/* SEO Custom URL */
  public function getURL($route) {
    if( count($this->url_list) > 0) {
         foreach ($this->url_list as $key => $value) {
            if($route == $key) {
                return '/'.$value;
            }
         }
    }
    return false;
  }
  public function setURL($_route) {
    if( count($this->url_list) > 0 ){
         foreach ($this->url_list as $key => $value) {
            if($_route == $value) {
                return $key;
            }
         }
    }
    return false;
  }/* SEO Custom URL */	
}
