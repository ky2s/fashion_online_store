<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">        
        <div class="row">

            <div id="content" class="blog-page col-sm-12">              
                <div class="row " id="content-row" data-sticky_parent>
                    
                    <?php echo $column_left; ?>
                    <?php if ($column_left && $column_right) { ?>
                        <?php $class = 'col-sm-6'; ?>
                    <?php } elseif ($column_left || $column_right) { ?>
                        <?php $class = 'col-sm-10'; ?>
                    <?php } else { ?>
                        <?php $class = 'col-sm-12'; ?>
                    <?php } ?>

                    <div class="intro-padding-right <?php echo $class ?>">
                        
                        <?php echo $content_top; ?>

                        <?php if(isset($article_info_found)) { ?>
                            <div class="item-blog detail">
                                <div class="head-item-blog">
                                    <span>Posted on <b><?php echo $article_date_added; ?></b></span>
                                    <h1><?php echo $article_info['article_title'] ?></h1>
                                </div>

                                <div class="row ">
                                    <div class="col-sm-12">
                                        <div class="img-detail">
                                            <?php if($article_info['image']){ ?>
                                                <img src="<?php echo $article_info['image'] ?>" alt="Blog Detail">
                                                <span><?php echo $article_info['additional_description'] ?></span>
                                            <?php }?>
                                        </div>
                                        <div class="desc-blog">
                                            <?php echo $article_info['description'] ?>
                                        </div>

                                        <div class="next-prev-blog">
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <?php if($prev_article['url']){ ?>
                                                        <a href="<?php echo $prev_article['url'] ?>">
                                                            <span>Previous Blog</span>
                                                            <h5><?php echo $prev_article['article_title'] ?></h5>
                                                        </a>
                                                    <?php }?>
                                                </div>
                                                <div class="col-sm-6 text-right">
                                                    <?php if($next_article['url']){ ?>
                                                        <a href="<?php echo $next_article['url'] ?>">
                                                            <span>Next Blog</span>
                                                            <h5><?php echo $next_article['article_title'] ?></h5>
                                                        </a>
                                                    <?php }?>
                                                </div>
                                            </div>
                                        </div>

                                        <br>

                                        <?php if($recents){ ?>
                                        <!-- <div class="row"> -->
                                            <div class="recent-post">
                                                <h3>Recent Post</h3>
                                                <div class="row clearfix">                                                    
                                                    <?php foreach($recents as $recent){ ?>
                                                        <div class="col-sm-6">                                                            
                                                            <div class="item-recent">
                                                                <div class="row">
                                                                    <a href="<?php echo $recent['url'] ?>">                                             
                                                                        <div class="col-sm-4">
                                                                            <?php if($recent['image']){ ?>
                                                                                <img src="<?php echo $recent['image'] ?>" alt="Recent">
                                                                            <?php }else{
                                                                            ?>
                                                                                <img src="http://placehold.it/142x142" alt="">
                                                                            <?php
                                                                            } ?>
                                                                        </div>
                                                                        <div class="col-sm-8">
                                                                            <h5><?php echo $recent['article_title'] ?></h5>
                                                                            <span><?php echo $recent['date_post'] ?></span>
                                                                            <p><?php echo html_entity_decode($recent['description']) ?>...</p>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <?php }?>
                                                </div>
                                            </div>
                                        <!-- </div>                              -->
                                        <?php }?>

                                        <?php if($related_articles){ ?>
                                        <!-- <div class="row"> -->
                                            <div class="recent-post">
                                                <h3>Related Post</h3>
                                                <div class="row">                                                    
                                                    <?php foreach($related_articles as $related){ ?>
                                                        <div class="col-sm-6">                                                            
                                                            <div class="item-recent">
                                                                <div class="row">
                                                                    <a href="<?php echo $related['article_href'] ?>">                                             
                                                                        <div class="col-sm-4">
                                                                            <?php if($related['image']){ ?>
                                                                                <img src="<?php echo $related['image'] ?>" alt="Recent">
                                                                            <?php }?>
                                                                        </div>
                                                                        <div class="col-sm-8">
                                                                            <h5><?php echo $related['article_title'] ?></h5>
                                                                            <span><?php echo $related['date_post'] ?></span>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <?php }?>                                            
                                                </div>
                                            </div>
                                        <!-- </div> -->
                                        <?php }?>

                                        <div class="comments">
                                            <h3>Comments</h3>
                                            <div id="fb-root"></div>
                                            <script>(function(d, s, id) {
                                              var js, fjs = d.getElementsByTagName(s)[0];
                                              if (d.getElementById(id)) return;
                                              js = d.createElement(s); js.id = id;
                                              js.src = "//connect.facebook.net/id_ID/sdk.js#xfbml=1&version=v2.8&appId=1233483383338474";
                                              fjs.parentNode.insertBefore(js, fjs);
                                            }(document, 'script', 'facebook-jssdk'));</script>

                                            <div class="fb-comments" data-href="<?php echo $comment_url ?>" data-numposts="1"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <?php } else { ?>
                            <h3 class="text-center"><?php echo $text_no_found; ?></h3>
                        <?php } ?> 

                        <?php echo $content_bottom; ?>

                    </div>

                </div>
            </div>
            
        </div>
    </div>
</div>  

<script type="text/javascript">
    $(document).ready(function(){
        var width = $(this).width();
        if(width <= 992){
            $("[data-sticky_column]").trigger("sticky_kit:detach");
        }

        //replace grid default content left  OC
        $("#column-left").removeClass("col-sm-3");
        $("#column-left").addClass("col-sm-2");
    });

    // STICKY
    $("[data-sticky_column]").stick_in_parent({
        parent: "[data-sticky_parent]",
        offset_top : $('header').outerHeight() + parseInt(20),    
    });
    // STICKY

    $('.year li a').click(function(){
        if($(this).next().hasClass('open')){
            $(this).next().slideUp();
            $(this).next().removeClass('open');
        }else{
            $(this).next().slideDown();
            $(this).next().addClass('open');
        }
    });
</script>

<?php echo $footer; ?>