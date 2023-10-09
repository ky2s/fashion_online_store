<?php echo $header; ?>
<div id="center-other-page">
    
    <!-- CATEGORY THUMB IMAGE ====================================== -->    
    <?php if ($thumb) { ?>
        <div class="row">
            <?php if ($thumb) { ?>
                <div class="banner-page">
                    <img src="<?php echo $thumb ?>" alt="Category Woman">
                </div>
            <?php } ?>
        </div>
        <!-- <hr> -->
    <?php } ?>

    <div class="container">
        <div class="intro-padding">
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
                    <!-- <h2 class="no-margin"><?php //echo $heading_title; ?></h2> -->


                    <?php if ($groups) { ?>
                       
                        <!-- Row list ======================== -->      
                        <div class="row">
                            <?php foreach ($groups as $group) { ?>
                                <div class="row col-md-12 group">
                                    <h3><?=$group['group_data']['group_name']?></h3>

                                    <!-- PRODUCT ITEM -->
                                    <?php foreach($group['product_data'] as $product){ ?>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 wow fadeInUp">
                                        <div class="product-item">
                                            <div class="image">

                                                <a href="<?php echo $product['href']; ?>">                                        
                                                  <?php foreach($product['thumb'] as $i=>$thumb){?>
                                                      <?php 
                                                      $img_count =count($product['thumb']);
                                                      if($img_count > 1){?>
                                                      <!-- http://lab.gositus.com/ocGositus/image/cache/placeholder-200x200.png -->
                                                          <img src="<?php echo $thumb; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive <?php echo ($i == 0) ? 'to-first' : 'to-hover' ?>" />
                                                      <?php }else{?>
                                                          <img src="<?php echo $thumb; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive " />
                                                      <?php }?>
                                                      <?php if($img_count == 1){ break; }?>
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

                    <?php } ?>

                    <?php if (!$groups) { ?>
                        <div class="no-data">                            
                            <p><?php echo $text_empty; ?></p>
                        </div>
                    <?php } ?>

                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
