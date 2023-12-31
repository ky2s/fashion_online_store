<?php echo $header; ?>
    <div class="container">
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
        
        <div class="row">
            <?php echo $column_left; ?>
            <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
            <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
            <?php } ?>
            
            <div id="content" class="<?php echo $class; ?>">
                <?php echo $content_top; ?>
                
                <div class="row">
                    <?php if($articles) { ?>
                        <?php foreach($articles as $article) { ?>                            
                            <div class="col-sm-4">
                                <a title="<?php echo ucwords($article['article_title']); ?>" href="<?php echo $article['href']; ?>">
                                
                                <?php if($article['image']) { ?>
                                
        							<?php if($article['featured_found']) { ?>
        								<div class="article-image">
        									<img src="<?php echo $article['image']; ?>" alt="<?php echo $article['article_title']; ?>" />
                                            <i class="fa fa-caret-up"></i>
        								</div>
        							<?php } else { ?>
        								<div class="article-image">
        									<img src="<?php echo $article['image']; ?>" alt="<?php echo $article['article_title']; ?>" />
        									<span class="article-description">
        										<?php echo $article['description']; ?>
        									</span>
        								</div>
        							<?php } ?>
        						<?php }else{ ?>
        								<div style="height: 180px;margin-bottom: 5px"></div>
        						<?php } ?>
                                </a>

                                <div class="article-sub-title">
        							<span class="article-date"><?php echo $article['date_added']; ?></span>
        							<span> | </span>
        							<span class="article-author"><a href="<?php echo $article['category_href']; ?>"><?php echo $article['category_name']; ?></a></span>        							
        							<?php if($article['allow_comment']) { ?>
        								<span class="bullet">&bull;</span>
        								<span class="article-comment"><a href="<?php echo $article['comment_href']; ?>#comment-section"><?php echo $article['total_comment']; ?></a></span>
        							<?php } ?>
        							
        						</div>
                                
                                <?php if($article['featured_found']) { ?>						
        							<a class="article-description" href="<?php echo $article['href']; ?>">
        								<p class="article-title" title="<?php echo ucwords($article['article_title']); ?>"><?php echo ucwords($article['article_title_short']); ?></p>

        								<?php echo $article['description']; ?>
        							</a>
        						<?php } else { ?>
        							<a class="article-description" href="<?php echo $article['href']; ?>">
        								<p class="article-title" title="<?php echo ucwords($article['article_title']); ?>"><?php echo ucwords($article['article_title_short']); ?></p>

        								<?php echo $article['description']; ?>
        							</a>
        						<?php } ?>
                                
                                <?php /*if(!$article['featured_found']) { ?>
        							//<div class="article-thumbnail-found"></div>
        						<?php */ 
        						?>                              
                            </div>
                        <?php } ?>
                        
                        <div class="col-sm-12">
	                        <div class="row">
	                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
	                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
                        	</div>
                        </div>
                           
                    <?php } else { ?>
                        <h3 class="text-center"><?php echo $text_no_found; ?></h3>
                    <?php } ?>
                </div>               
                
                <?php echo $content_bottom; ?>
            </div>            
            
            <?php echo $column_right; ?>
        </div>        
    </div>    
<?php echo $footer; ?>