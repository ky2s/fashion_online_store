<div id="center-content" class="featured">    
    <div class="container">
        <div class="row">
            
            <div class="intro text-center intro-featured">            
                <h3 class="box-title"><?php echo  $module_name; ?></h3>
                
                <div class="">
                    <div class="intro-padding">                    
                        <?php foreach ($groups as $group) { ?>
                            <div class="col-md-12 col-xs-12">
                                <h3 class="wow fadeIn"><?php echo $group['group_data']['group_name']?></h3>

                                <!-- PRODUCT ITEM -->
                                <div class="row">                                    
                                    <?php foreach($group['product_data'] as $product){ ?>
                                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-6 item-product wow fadeInUp" data-wow-duration="1s" data-wow-delay="0.1s">
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
                                                      <?php if($i == 1){ break; }?>
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
                                                                    <?php if($size['quantity'] > 0){ ?>
                                                                        <li><a href="javascript:;" onclick="cart.add('<?php echo $product['product_id']; ?>','1','<?php echo $product['size'][0]['product_option_id'] ?>','<?php echo $size['product_option_value_id'] ?>');" ><?php echo $size['name'] ?> </a></li>
                                                                    <?php }else{ ?>
                                                                        <li><a href="javascript:;" class="out-of-stock" ><?php echo $size['name'] ?> </a></li>
                                                                    <?php }?>
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
                                                        <?php /* if($store_id <= 0){ ?>
                                                            <span class="price-old"><?php echo $product['price']; ?></span>
                                                            <span class="price-new"><?php echo $product['special']; ?></span> 
                                                        <?php }else{?>
                                                            <span class="price-old"><?php echo $product['price']; ?></span>
                                                            <span class="price-new"><?php echo $product['special']; ?></span> 
                                                        <?php } */?>
                                                    <?php } ?>
                                                    <?php if ($product['tax']) { ?>
                                                        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                                    <?php } ?>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <?php }?>
                                </div>
                                <!-- //PRODUCT ITEM -->
                            </div>
                        <?php } ?>
                    </div>
                </div>
            </div>

        </div>
    </div>
    
</div>
<!-- is-in-view is-past-bottom is-past-quarter -->
<script>      
    
    $(document).ready(function(){
        
        wow = new WOW(
            {
             mobile: true
            } 
          )
        wow.init(); 
      
    });

</script>