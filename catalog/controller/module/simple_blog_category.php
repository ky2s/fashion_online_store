<?php
	class ControllerModuleSimpleBlogCategory extends Controller {
		public function index($setting) {
			$this->language->load('module/simple_blog_category');
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$this->load->model('simple_blog/article');
			
			$data['text_search_article'] = $this->language->get('text_search_article');
			$data['button_search'] = $this->language->get('button_search');
			
			if (isset($this->request->get['simple_blog_category_id'])) {
				$parts = explode('_', (string)$this->request->get['simple_blog_category_id']);
			} else {
				$parts = array();
			}
			
			if (isset($parts[0])) {
				$data['category_id'] = $parts[0];
			} else {
				$data['category_id'] = 0;
			}
			//pre($data['category_id'] );
			if (isset($parts[1])) {
				$data['child_id'] = $parts[1];
			} else {
				$data['child_id'] = 0;
			}
			
			$this->load->model('simple_blog/article');
			
			$data['categories'] = array();
			
			$categories = $this->model_simple_blog_article->getCategories(0);
			
			foreach ($categories as $category) {
				
				$children_data = array();
	
				$children = $this->model_simple_blog_article->getCategories($category['simple_blog_category_id']);
				
				foreach ($children as $child) {
					
					$article_total = $this->model_simple_blog_article->getTotalArticles($child['simple_blog_category_id']);
			
					$children_data[] = array(
						'category_id' => $child['simple_blog_category_id'],
						'name'  => $child['name'],
						'href'  => $this->url->link('simple_blog/category', 'simple_blog_category_id=' . $category['simple_blog_category_id'] . '_' . $child['simple_blog_category_id'])
					);		
				}
	
				$data['categories'][] = array(
					'simple_blog_category_id' => $category['simple_blog_category_id'],
					'name'     => $category['name'],
					'children' => $children_data,
					'href'     => $this->url->link('simple_blog/category', 'simple_blog_category_id=' . $category['simple_blog_category_id'])
				);
			}
			//pre($data['categories']);
            if($this->config->has('simple_blog_category_search_article')) {
                $data['simple_blog_category_search_article'] = $this->config->get('simple_blog_category_search_article');
            }

            //category for article detail
            $article = $this->model_simple_blog_article->getArticle($this->request->get['simple_blog_article_id']);
            if($article){
            	$data['category_id'] = $article['simple_blog_category_id'];
            }

			if (isset($this->request->get['blog_search'])) {
				$data['blog_search'] = $this->request->get['blog_search'];
			} else {
				$data['blog_search'] = '';
			}

			//archive
			$data['archives']="";
			$archive_data = array('archive_data' => true);
			$archives = $this->model_simple_blog_article->getArticles($archive_data);
			foreach ($archives as $archive) {
				$year = date('Y', strtotime($archive['date_post']));
				
				$data_month =array();
				$months = $this->model_simple_blog_article->getMonth($year);
				foreach ($months as $m=>$month) {
					$data_month[$m] = array(
						'month_name' => $month['month_name'],
						'url' => $this->url->link('simple_blog/article&year='.$year.'&month='. date('m', strtotime($month['month_name']))),
						'total' => $month['total'],
					); 
				}

				$data['archives'][] = array(
					'year' => $year,
					'total' => $this->model_simple_blog_article->getTotalArticle(array('year'=>$year)),
					'url' => $this->url->link('simple_blog/article&year='. date('Y', strtotime($archive['date_post']))),
					'months' => $data_month
				);
			}
			
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/simple_blog_category.tpl')) {
    			return $this->load->view($this->config->get('config_template') . '/template/module/simple_blog_category.tpl', $data);
    		} else {
    			return $this->load->view('default/template/module/simple_blog_category.tpl', $data);
    		}		
		}
	}
?>