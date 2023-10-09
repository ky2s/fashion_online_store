<?php echo $header; ?>
<!-- <div class="container">
    <div class="row"> -->
        <?php echo $column_left; ?>

        <?php if ($column_left && $column_right) { ?>
            <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
            <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
            <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        
        <div id="wr-content">                
            <div id="content" class="<?php echo $class; ?> no-padding">

                <!-- content top -->
                <?php echo $content_top; ?>
                
                <!-- banner custom -->
                <?php if($banners) { ?>
                    <div id="wrap-banner"> 
                        <div id="slick-banner">
                            <?php foreach ($banners as $banner) { ?>
                                <?php if($banner['link']){ ?>
                                    <a href="<?php echo $banner['link'];?>" target="_blank">                                        
                                        <div class="item-slick-banner">
                                            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"/>
                                        </div>
                                    </a>
                                <?php }else{ ?>
                                    <div class="item-slick-banner">
                                        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"/>
                                    </div>
                                <?php }?>
                            <?php } ?>
                        </div>

                        <script type="text/javascript">
                            $("#slick-banner").slick({
                                fade: true,
                                cssEase: 'linear',
                                dots: true,
                                arrows: false,
                                infinite: true,
                                speed: 1800,
                                autoplaySpeed: 6000,
                                autoplay: true,
                                pauseOnFocus:false,
                                pauseOnHover:false
                            });     
                        </script>
                    </div>
                <?php } ?>

                <!-- ESSENTIAL -->
                <div class="wrap-essential">                    
                    <div class="container"> 
                        <div class="offsetButton">            
                            <?php echo html_entity_decode($essential) ?>

                            <div class="row text-center">                  
                                <a href="about-us" class="btn-scroll button--animated btn-animate">
                                    <span class="button__h-borders">ABOUT THE BRAND</span>
                                </a>
                            </div>

                        </div>
                    </div>
                </div>
                <script>          
                    $(document).ready(function(){
                        $(window).scroll(function(){
                            var offsetButton = $('.offsetButton').offset().top;

                            if($(window).scrollTop() >= offsetButton - 380){
                                $('.btn-animate').addClass('is-in-view is-past-bottom is-past-quarter');
                            }else{
                                $('.btn-animate').removeClass('is-in-view is-past-bottom is-past-quarter');
                            }
                        });        
                    });
                </script>

                <!-- content bottom -->
                <?php echo $content_bottom; ?>

            </div>
        
        </div>
        <?php echo $column_right; ?>
<!--     </div>
</div> -->
<?php echo $footer; ?>