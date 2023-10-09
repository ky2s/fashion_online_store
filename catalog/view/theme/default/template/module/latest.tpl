<div id="center-content">
    <div class="container">
        <div class="row">
            
            <div class="intro text-center">
                <h3 class="box-title"><?php echo $module_name ;?></h3>
                
                <div class="row">
                    <div class="intro-padding">
                        <?php foreach ($groups as $group) { ?>
                        <div class="row col-md-12 group">
                            <h3 class="wow fadeIn"><?=$group['group_data']['group_name']?></h3>
                            <!-- PRODUCT ITEM -->
                            <?php foreach($group['product_data'] as $product){ ?>
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 wow fadeInUp" data-wow-duration="1">
                                <div class="product-item">
                                    <div class="image">
                                        <a href="<?php echo $product['href']; ?>">
                                            <?php foreach($product['thumb'] as $i=>$thumb){?>
                                            <?php
                                            $img_count =count($product['thumb']);
                                            if($img_count > 1){?>
                                            <img src="<?php echo $thumb; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive <?php echo ($i == 0) ? 'to-first' : 'to-hover' ?>" />
                                            <?php }else{?>
                                            <img src="<?php echo $thumb; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive " />
                                            <?php }?>
                                            <?php if($i == 1){ break; } ?>
                                            <?php }?>
                                        </a>
                                        <!-- quick add color -->
                                        <?php if($product['size']){?>
                                        <div class="wr-quick">
                                            <div class="quick-add">
                                                <p>+ Quick Add</p>
                                                <div class="size">
                                                    <ul>
                                                        <?php foreach($product['size'][0]['product_option_value'] as $size){?>
                                                        <li><a href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>','1','<?php echo $product['size'][0]['product_option_id'] ?>','<?php echo $size['product_option_value_id'] ?>');" ><?php echo $size['name'] ?> </a></li>
                                                        <?php }?>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <?php } ?>
                                    </div>
                                    <div class="caption">
                                        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                                        <p class="price">
                                            <?php if (!$product['special']) { ?>
                                            <?php echo $product['price']; ?>
                                            <?php } else { ?>
                                            <span class="price-old"><?php echo $product['price']; ?></span>
                                            <span class="price-new"><?php echo $product['special']; ?></span>
                                            <?php } ?>
                                            <?php if ($product['tax']) { ?>
                                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                            <?php } ?>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <?php }?>
                            <!-- //PRODUCT ITEM -->
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <!-- <h3><?php echo $heading_title; ?></h3>
            <div class="row">
                <?php foreach ($products as $product) { ?>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="product-thumb transition">
                        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
                        <div class="caption">
                            <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                            <p><?php echo $product['description']; ?></p>
                            <?php if ($product['rating']) { ?>
                            <div class="rating">
                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                <?php if ($product['rating'] < $i) { ?>
                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                <?php } else { ?>
                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                <?php } ?>
                                <?php } ?>
                            </div>
                            <?php } ?>
                            <?php if ($product['price']) { ?>
                            <p class="price">
                                <?php if (!$product['special']) { ?>
                                <?php echo $product['price']; ?>
                                <?php } else { ?>
                                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                                <?php } ?>
                                <?php if ($product['tax']) { ?>
                                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                <?php } ?>
                            </p>
                            <?php } ?>
                        </div>
                        <div class="button-group">
                            <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                            <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                            <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                        </div>
                    </div>
                </div>
                <?php } ?>
            </div> -->
        </div>
    </div>
    <!-- Think Essential -->
    <div class="container">
        <?php echo html_entity_decode($essential) ?>
        <div class="row text-center">
            <a href="<?php echo $about_brand ?>" class="btn-hov-black"><h4 class="box-title about-brand">ABOUT THE BRAND</h4></a>
        </div>
    </div>
    
</div>

<script>
    $(function(){
        var canvasHeight = $('#wrap-banner').height();   
        $('#center-content').css({'margin-top': canvasHeight});    

        wow = new WOW(
            {
             mobile: true
            } 
          )
        wow.init();    
    })

    // $(window).on("load",function() {
    //   $(window).scroll(function() {
    //     $(".fade").each(function() {
    //       /* Check the location of each desired element */
    //       var objectBottom = $(this).offset().top + $(this).outerHeight();
    //       var windowBottom = $(window).scrollTop() + $(window).innerHeight();
          
    //        If the element is completely within bounds of the window, fade it in 
    //       if (objectBottom < windowBottom) { //object comes into view (scrolling down)
    //         if ($(this).css("opacity")==0) {$(this).fadeTo(500,1);}
    //       } else { //object goes out of view (scrolling up)
    //         if ($(this).css("opacity")==1) {$(this).fadeTo(500,0);}
    //       }
    //     });
    //   }); $(window).scroll(); //invoke scroll-handler on page-load
    // });
</script>

<!-- <div class="container">    
        <div class="row">        
            <div class="intro-padding">            
            <h3 class="title-clear text-center wow fadeIn">THINK ESSENTIALS</h3>


                <div class="qoute-title text-center wow fadeIn">                "We want to show people that "Made in Indonesia" can be blended and mixed with essential lifestyle"            
                </div>


                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">                <div class="qoute-caption wow fadeIn">                    <p>                        One ovening, our team brainstrom togethher why there are no mass-produced Indonesian brands have yet to scale globally. Since then. It becomes our mission to decode what is happening in our society towards "Made in Indonesia". We want to try make a good product with a good quality of fabric but with belom average price.                    </p>


                    </div>
                </div>


                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">                <div class="qoute-caption wow fadeIn">                    <p>                        While designing, we focus on the aesthetic and pragmatic aspects of our products: a purse should be pretty, and useful.                        Our products are manufactured in Indonesia,                        and our manufacture is experienced in producing global brand like Zara, GAP, Uniqlo, etc, which allows us to achieve highest quality.                    </p>
                    </div>
                </div>

            </div>
        </div>


        <div class="row text-center">        
          <a href="javascript:;" class="btn-hov-black"><h4 class="box-title about-brand">ABOUT THE BRAND</h4></a>
        </div>
    </div> -->