<?php
	class ControllerModuleSimpleBlogRelatedArticle extends Controller {
		public function index($setting) {
			$this->language->load('module/simple_blog_related_article');
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$this->load->model('simple_blog/article');
			
			$data['text_search_article'] = $this->language->get('text_search_article');
			$data['button_search'] = $this->language->get('button_search');
			
			/*if (isset($this->request->get['simple_blog_category_id'])) {
				$parts = explode('_', (string)$this->request->get['simple_blog_category_id']);
			} else {
				$parts = array();
			}
			
			if (isset($parts[0])) {
				$data['category_id'] = $parts[0];
			} else {
				$data['category_id'] = 0;
			}
			
			if (isset($parts[1])) {
				$data['child_id'] = $parts[1];
			} else {
				$data['child_id'] = 0;
			}*/
			if(isset($this->request->get['simple_blog_article_id'])) {
				$simple_blog_article_id = $this->request->get['simple_blog_article_id'];
			} else {
				$simple_blog_article_id = 0;
			}

			if($simple_blog_article_id) {
				$data['related_articles'] = array();
			
				$articles = $this->model_simple_blog_article->getRelatedArticles($simple_blog_article_id);
				
				//pre($articles);
				
				$data['related_articles'] = array();

				foreach ($articles as $article) {
					
					$data['related_articles'][] = array(
	    						'simple_blog_article_id'	=> $article['simple_blog_article_id'],
	    						'article_title'				=> $article['article_title'],
	                            'article_href'      		=> $this->url->link('simple_blog/article/view', 'simple_blog_article_id=' . $article['simple_blog_article_id'], 'SSL'),
	                            'article_category'				=> $article['article_category'],
	                            'date_added'					=> $article['date_added'],
	                            'image'					=> $article['image']
	    					);
				}
			}/*
			else {
				pre("rel_artcl_id is blank");
			}*/

			
			
            //print "<pre>"; print_r($data['categories']); die;
            
            /*if($this->config->has('simple_blog_category_search_article')) {
                $data['simple_blog_category_search_article'] = $this->config->get('simple_blog_category_search_article');
            }*/
            
			//print "<pre>"; print_r($data['categories']); exit;
			/*if (isset($this->request->get['blog_search'])) {
				$data['blog_search'] = $this->request->get['blog_search'];
			} else {
				$data['blog_search'] = '';
			}*/
			
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/simple_blog_related_article.tpl')) {
    			return $this->load->view($this->config->get('config_template') . '/template/module/simple_blog_related_article.tpl', $data);
    		} else {
    			return $this->load->view('default/template/module/simple_blog_related_article.tpl', $data);
    		}		
		}
	}
?>