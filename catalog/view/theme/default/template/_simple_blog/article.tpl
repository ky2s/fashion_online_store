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

                        <div class="row">                           
                            <div class="col-sm-12">
                                <div class="head-blog">                     
                                    <h5><?php echo (isset($category_name)) ? $category_name : "" ; ?></h5>
                                    <h1>Blog</h1>
                                </div>
                                <br>
                                <br>
                            </div>
                        </div>
                        
                        <?php if($articles) { ?>
                            <?php foreach($articles as $article) { ?>    
                                <div class="item-blog">
                                    <a href="<?php echo $article['href']?>">                         
                                        <div class="head-item-blog">
                                            <span>Posted on <b><?php echo $article['date_post']?></b></span>
                                            <h1><?php echo $article['article_title']?></h1>
                                        </div>
                                        
                                        <?php if($article['image']){ ?>
                                            <img src="<?php echo $article['image']?>" alt="Blog">
                                        <?php }?>

                                        <div class="desc-blog">
                                            <p><?php echo $article['description']?></p>
                                        </div>
                                    </a>
                                    <div class="foot-blog"> 
                                        <div class="row">   
                                            <div class="col-sm-6 text-left">
                                                <span>Posted in <b><?php echo $article['category_name']?></b></span>
                                            </div>
                                            <div class="col-sm-6 text-right">
                                                <a href="<?php echo $article['href']?>" class="btn btn-default btn-grey">Read More</a>
                                            </div>
                                        </div>                      
                                    </div>
                                </div>
                            <?php }?>
                        <?php }else{?>
                            <h3 class="text-center"><?php echo $text_no_found; ?></h3>
                        <?php } ?>

                        <!-- paging -->     
                        <div class="row">
                            <div class="col-sm-12">
                                <?php echo $pagination; ?>
                            </div>
                        </div>  

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
</script>

<?php echo $footer; ?>