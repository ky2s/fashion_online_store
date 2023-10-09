<?php echo $header; ?>
<div id="center-other-page"> 

    <div class="container">
        <div class="intro-padding product-detail-mobile">
            <div class="row">
                <?php echo $column_left; ?>
                <?php if ($column_left && $column_right) { ?>
                    <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                    <?php $class = 'col-sm-9'; ?>
                <?php } else { ?>
                    <?php $class = 'col-sm-12'; ?>
                <?php } ?>

                <div id="content" class="<?php echo $class; ?>" >
                    
                    <!-- CONTENT TOP -->
                    <?php echo $content_top; ?>

                    <div class="alert alert-success alert-mobile"><i class="fa fa-check-circle"></i> Products have been added, check <a href="cart">your shopping cart!</a>
                    </div>

                    <div class="row pos-relative"  data-sticky_parent>
                        <?php if ($column_left && $column_right) { ?>
                            <?php $class = 'col-sm-6'; ?>
                        <?php } elseif ($column_left || $column_right) { ?>
                            <?php $class = 'col-sm-6'; ?>
                        <?php } else { ?>
                            <?php $class = 'col-sm-8'; ?>
                        <?php } ?>
                        
                        
                        <!-- UNTUK HOVER COLOR   -->
                        <?php foreach($thumbs as $ky => $thumb){ ?>
                        <div class="get-h-img <?php echo $class; ?> <?php echo ($thumb['product_id'] == $current_product_id) ? 'color-main' : 'color-id-'.$thumb['product_id'] ?>" style="<?php echo ($thumb['product_id'] == $current_product_id) ? '' : 'display:none' ?>">
                            <div class="row">                                
                                <div class="col-sm-3 <?php echo ($thumb['product_id'] == $current_product_id) ? 'cia-sticky' : '' ?>">                                
                                    <div class="cov-img-additional" <?php echo ($thumb['product_id'] == $current_product_id) ? 'data-sticky_column' : '' ?>>
                                        <!-- images -->                                                
                                        <ul class="sticky-img-additional">                                    
                                            <?php if($thumb['image_data']['images']){ 
                                                foreach($thumb['image_data']['images'] as $key => $img){?>
                                                    <li class="image-additional">
                                                        <a class="thumbnail" href="javascript:;" data-click="to-<?php echo $key.$thumb['product_id'] ?>" title="<?php echo $img['item_name'] ?>">
                                                            <img src="<?php echo $img['thumb'] ?>" title="<?php echo $img['item_name'] ?>" alt="<?php echo $img['item_name'] ?>">
                                                        </a>
                                                    </li>                                
                                            <?php }}?>
                                            
                                            <!-- VIDEO ADDITIONAL -->
                                            <?php if($thumb['image_data']['video_cover']){ ?>
                                            <li class="image-additional">
                                                <a class="thumbnail" href="javascript:;" data-click="to-<?php echo $ky.$thumb['product_id'] ?>" title="<?php echo $th['item_name'] ?>">
                                                    <img src="<?php echo $thumb['image_data']['video_cover'] ?>" title="<?php echo $img['item_name'] ?>" alt="<?php echo $img['item_name'] ?>">
                                                </a>
                                            </li> 
                                            <?php }?>

                                        </ul>                                
                                    </div>
                                </div>
                                
                                <div class="col-sm-9 col-xs-12 cov-thumbnails">                                
                                    <ul class="thumbnails"> 

                                        <!-- thumbs -->
                                        <?php foreach($thumb['image_data']['thumbs'] as $key => $th){ ?>
                                        <li id="to-<?php echo $key.$thumb['product_id'] ?>" data-src="<?php echo $th['thumb'] ?>">
                                            <a class="thumbnail" href="<?php echo $th['popup'] ?>" title="<?php echo $th['item_name'] ?>">
                                                <img src="<?php echo $th['thumb'] ?>" title="<?php echo $th['item_name'] ?>" alt="<?php echo $th['item_name'] ?>">
                                            </a>
                                        </li>
                                        <?php }?>
                                        <!-- VIDEO THUMB -->
                                        <?php if($thumb['image_data']['video']){ ?>
                                        <li id="to-<?php echo $ky.$thumb['product_id'] ?>" data-src="<?php echo $th['popup'] ?>">
                                            <a id="video-thumbnail" class="thumbnail" href="<?php echo $th['popup'] ?>" title="<?php echo $th['item_name'] ?>">
                                                <?php echo html_entity_decode($thumb['image_data']['video']) ?>
                                            </a>
                                        </li> 
                                        <?php }?>

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <?php }?>
                        <!-- //UNTUK HOVER COLOR   -->

                        <!-- DETAIL -->
                        <?php if ($column_left && $column_right) { ?>
                            <?php $class = 'col-sm-6'; ?>
                        <?php } elseif ($column_left || $column_right) { ?>
                            <?php $class = 'col-sm-6'; ?>
                        <?php } else { ?>
                            <?php $class = 'col-sm-4'; ?>
                        <?php } ?>
                        <div class="<?php echo $class; ?> set-h-img">
                            <div data-sticky_column>                            
                                <h1 class="heading-prod-detail"><?php echo $group['group_name']; ?></h1>

                                <?php if ($price) { ?>
                                    <ul class="list-unstyled list-price-prod-detail text-center">
                                        <?php if (!$special) { ?>
                                            <li>
                                                <h4><?php echo $price; ?></h4>
                                            </li>
                                        <?php } else { ?>
                                            <li class="price-old"><h4><?php echo $price; ?></h4></li>
                                            <li class="price-new">
                                                <h4><?php echo $special; ?></h4>
                                            </li>
                                        <?php } ?>

                                        <?php if ($tax) { ?>
                                            <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                                        <?php } ?>

                                        <?php if ($points) { ?>
                                            <li><?php echo $text_points; ?> <?php echo $points; ?></li>
                                        <?php } ?>

                                        <?php if ($discounts) { ?>                                            
                                            <?php foreach ($discounts as $discount) { ?>
                                                <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                                            <?php } ?>
                                        <?php } ?>
                                    </ul>
                                <?php } ?>

                                <!-- COLOR -->
                                <?php if($colors){ ?>
                                <div id="product">
                                    <div class="form-group custom-check">
                                        <div id="input-option">                                                
                                            <?php foreach($colors as $c=>$color){?>
                                                <div class="radio">
                                                    <label data-hover="<?php echo ($color['product_id'] != $current_product_id) ? 'color-id-'.$color['product_id'] : '' ?>">
                                                        <input type="radio" onclick="document.location.href = '<?php echo $base_url ?>' + '&product_id='+'<?php echo $color['product_id'] ?>'+'&group_id='+'<?php echo $group['product_group_id'] ?>'" name="option_color" class="opt_color<?php echo $color['product_id']?>" data-color-id="" value="<?php echo $color['color'] ?>" <?php echo ($color['product_id'] == $current_product_id) ? 'checked' : '' ?>>
                                                        <div class="item-check">
                                                            <span class="color" style="background: <?php echo $color['color'] ?>"></span>
                                                        </div>
                                                    </label>
                                                </div>
                                            <?php }?>                                              
                                        </div>
                                    </div>
                                
                                <script>
                                    $('.custom-check label').hover(function(){
                                        var att = $(this).attr('data-hover') || '';

                                        if(att){                                                        
                                            $('.'+att).css({
                                                'position':'relative',
                                                'left': 0,
                                                'z-index' : 100,
                                                'display':'block'
                                            });
                                            $(".color-main").css({'opacity':0,'visibility':'hidden','display':'none'});

                                            $('.parent-size2.color-main .no-size').hide();
                                            $('.parent-size .no-size.active').hide();

                                        }else{
                                            return false;
                                        }
                                    },function(){
                                        var att = $(this).attr('data-hover') || '';
                                        if(att){                                                        
                                            $(".color-main").css({'opacity':1,'visibility':'visible','display':'block'});
                                            $('.'+att).css({
                                                'position':'relative',
                                                'left': 0,
                                                'z-index' : 100,
                                                'display':'none'
                                            });
                                            $('.parent-size2.color-main .no-size').show();
                                            $('.parent-size .no-size.active').hide();
                                        }else{
                                            return false;
                                        }
                                    })
                                </script>
                                <style type="text/css">
                                    .item-size{
                                        display: none;
                                    }
                                </style>
                                <?php }?> 
                                

                                <?php if ($options) { ?>
                                    <?php foreach ($options as $option) { ?>
                                        <?php if ($option['type'] == 'select') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                                    <option value=""><?php echo $text_select; ?></option>
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                        </optvion>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        <?php } ?>

                                        <?php if ($option['type'] == 'radio') { ?>                                                
                                            <!-- SIZE -->
                                            <div class="form-group <?php echo ($option['required'] ? ' required' : ''); ?> custom-check parent-size " >
                                                <?php foreach($sizes as $s=>$size){ ?>
                                                <div id="input-option<?php echo $option['product_option_id']; ?>" class="<?php echo ($current_product_id == $s) ? 'color-main' : 'color-id-'.$s ?>" style="<?php echo ($current_product_id == $s) ? '' : 'display:none;' ?>">
                                                    <?php foreach ($size['product_option_value'] as $option_value) { ?>
                                                        <div class="radio">
                                                            <label class="input-size" data-stock="<?php echo $option_value['quantity']; ?>" data-product-stock="<?php echo $size['product_quantity'] ?>">
                                                                <?php $tooltip = ($option_value['quantity'] > 0) ? '' : " data-toggle='tooltip' data-placement='top'"; ?>
                                                                <input type="radio"  name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php echo $tooltip ?>/>
                                                                <div class="item-check">                                                                        
                                                                    <span class="<?php echo ($option_value['quantity'] > 0 && $size['product_quantity'] > 0) ? '' : 'out-of-stock'; ?>" <?php echo $tooltip ?>>                                                                
                                                                        <?php echo $option_value['name']; ?>
                                                                    </span>
                                                                </div>
                                                            </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                                <?php }?>
                                            <div class="no-size">Out Of Stock</div>

                                            <!-- WARNING SESSION FROM CONTROLLER -->
                                            <?php if($error_cart_limit){ ?>
                                            <div class="no-size2 text-danger no-size-req waitlist-succes">Your cart is full</div>
                                            <?php }?>

                                            

                                            </div>
                                            <!-- //SIZE -->                                            
                                        <?php } ?>

                                        <script>
                                            $('.input-size').click(function(){
                                                var stock = $(this).attr('data-stock');
                                                var product_stock = $(this).attr('data-product-stock');
                                                if(stock < 1 || product_stock < 1){
                                                    //alert(stock);
                                                    if($('.button-cart').parent().hasClass('color-main')){                                                        
                                                        $('.to-add-bag .color-main .button-cart').addClass('disabled');
                                                        $(".to-add-bag .color-main .button-cart").text('SOLD OUT');

                                                        $('.parent-size2.color-main .no-size').fadeIn();
                                                        $('.parent-size .no-size').hide();
                                                        $('.parent-size .no-size').addClass('active');
                                                        $('.text-danger').remove();
                                                    }
                                                }else{
                                                    if($('.button-cart').parent().hasClass('color-main')){
                                                        $('.to-add-bag .color-main .button-cart').removeClass('disabled');
                                                        $(".to-add-bag .color-main .button-cart").text('ADD TO CART');
                                                        $('.parent-size2.color-main .no-size').fadeIn();
                                                        $('.parent-size .no-size').hide();
                                                        $('.parent-size .no-size').removeClass('active');
                                                        $('.text-danger').remove();
                                                    }
                                                }
                                            });
                                        </script>


                                        <?php if ($option['type'] == 'checkbox') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label"><?php echo $option['name']; ?></label>
                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="checkbox">
                                                          <label>
                                                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                            <?php echo $option_value['name']; ?>
                                                            <?php if ($option_value['price']) { ?>
                                                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                            <?php } ?>
                                                          </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'image') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label"><?php echo $option['name']; ?></label>
                                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="radio">
                                                            <label>
                                                                <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                                <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                                                                <?php if ($option_value['price']) { ?>
                                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                                <?php } ?>
                                                          </label>
                                                        </div>
                                                    <?php } ?>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'text') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'textarea') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'file') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label"><?php echo $option['name']; ?></label>
                                                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'date') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <div class="input-group date">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'datetime') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <div class="input-group datetime">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                        <?php if ($option['type'] == 'time') { ?>
                                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                                <div class="input-group time">
                                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                                    <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span>
                                                </div>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                <?php }else{ ?>
                                <!-- MENAMPILKAN SIZE UNTUK PRODUCT SELAIN SIZE PRODUCT CURRENT --> 

                                <!-- SIZE -->
                                <div class="form-group<?php echo ($option['required']) ? ' required' : ''; ?> custom-check parent-size " >
                                    <?php foreach($sizes_product_other as $spo=>$size_other){ ?>
                                    <div id="input-option<?php echo $option['product_option_id']; ?>" class="<?php echo ($current_product_id == $spo) ? 'color-main' : 'color-id-'.$spo ?>" style="<?php echo ($current_product_id == $spo) ? '' : 'display:none;' ?>">
                                        <?php foreach ($size_other['product_option_value'] as $option_value_other) { ?>
                                            <div class="radio">
                                                <label class="input-size" data-stock="<?php echo $option_value_other['quantity']; ?>">
                                                    <?php $tooltip = ($option_value_other['quantity'] > 0) ? '' : "data-toggle='tooltip' data-placement='top' title='Out of Stock'"; ?>
                                                    <input type="radio"  name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value_other['product_option_value_id']; ?>" <?php echo $tooltip ?>/>
                                                    <div class="item-check">                                                                        
                                                        <span style="<?php echo ($option_value_other['quantity'] > 0) ? '' : 'color: #bdbdbd;'; ?>" <?php echo $tooltip ?>>                                                                
                                                            <?php echo $option_value_other['name']; ?>
                                                        </span>
                                                    </div>
                                                </label>
                                            </div>
                                        <?php } ?>
                                    </div>
                                    <?php }?>
                                    <div class="no-size">Out Of Stock1</div>
                                </div>

                                <!-- //SIZE -->                                    
                                <?php } ?>

                                <!-- SIZE GUIDE -->
                                <?php foreach($colors as $c=>$color){?>
                                    <?php $size_guide = trim($size_guide); ?>

                                    <?php if(!empty($size_guide)){ ?>
                                    <div class="parent-size2 <?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? 'display: block' : 'display:none;' ?>"> 
                                        
                                        <?php if($color['quantity'] == 0){ ?>
                                            <div class="waitlist-success-<?php echo $c ?>"></div>
                                            <div class="no-size text-center <?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? 'display:block' : 'display:none' ?>">Out Of Stock</div>
                                        <?php }?>

                                        <div class="size-guide"> 
                                            <?php if($color['quantity'] > 0){ ?>
                                            <a href="#" onclick="return false" data-toggle="modal" data-target="#size-guide<?php echo $c;?>">SIZE GUIDE</a>
                                            <?php }?>

                                            <!-- MODAL POPUP -->
                                            <div id="size-guide<?php echo $c;?>" class="modal fade popup-size-guide" role="dialog">
                                              <div class="modal-dialog">

                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                  <div class="modal-body">
                                                        <button type="button" class="close" data-dismiss="modal" style="position:absolute;right:10px;top:10px;">&times;</button>
                                                        <?php echo $size_guide ?>
                                                  </div>
                                                </div>

                                              </div>
                                            </div>
                                        </div>
                                    </div>
                                    <?php }else{ ?>
                                        <div class="waitlist-success-<?php echo $c ?>" ></div>
                                        <div class="parent-size2 <?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? 'display: block' : 'display:none;' ?>">
                                            <?php if($color['quantity'] == 0){ ?>
                                            <div class="no-size text-center <?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? 'display:block' : 'display:none' ?>">Out Of Stock</div>
                                        <?php }?>
                                        </div>
                                    <?php }?>
                                <?php }?>

                                <?php if ($recurrings) { ?>
                                    <hr>
                                    <h3><?php echo $text_payment_recurring ?></h3>
                                    <div class="form-group required">
                                        <select name="recurring_id" class="form-control">
                                            <option value=""><?php echo $text_select; ?></option>
                                            <?php foreach ($recurrings as $recurring) { ?>
                                                <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                                            <?php } ?>
                                        </select>
                                        <div class="help-block" id="recurring-description"></div>
                                    </div>
                                <?php } ?>

                                <div class="form-group to-add-bag">
                                    <input type="hidden" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />

                                    <!-- buttonn di loop menggunakan color (jumlah product == jml color ) -->
                                    <?php foreach($colors as $c=>$color){?>                                                                       
                                    <div class="<?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? '' : 'display:none;' ?>">
                                        <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block btn-grey button-cart" <?php echo ($color['quantity'] == 0) ? 'disabled' : ''; ?>> <?php echo ($color['quantity'] == 0) ? 'SOLD OUT' : $button_cart; ?></button>
                                    </div>
                                    <div class="<?php echo ($current_product_id == $c) ? 'color-main' : 'color-id-'.$c ?>" style="<?php echo ($current_product_id == $c) ? '' : 'display:none;' ?>">
                                        <button type="button" id="button-wislist" data-loading-text="<?php echo $text_loading; ?>" onclick="<?php echo ($is_login)? 'return true': 'return false' ?>" class="btn btn-primary btn-lg btn-block btn-grey button-waitlist <?php echo ($is_login)? '': 'quick_signup' ?>  <?php echo ($color['quantity'] == 0) ? '' : 'hidden'; ?>"> WAITLIST </button>
                                    </div>
                                    <?php }?>

                                </div>

                                <?php if ($minimum > 1) { ?>
                                    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
                                <?php } ?>
                            
                                <!-- HTML UNTUK DESIGN DESKRIPSI -->
                                <div class="form-group">
                                    <?php if($group['detail']){?>
                                        <div class="row item-desc-prod">
                                            <div class="col-sm-4 item-col-detail">
                                                <h5>Details</h5>
                                            </div>
                                            <div class="col-sm-8 item-col-detail">
                                                <?php echo html_entity_decode($group['detail']); ?>
                                            </div>
                                        </div>
                                    <?php }?>

                                    <?php if($group['description']){?>
                                        <div class="row item-desc-prod">
                                            <div class="col-sm-4 item-col-detail">
                                                <h5>Description</h5>
                                            </div>
                                            <div class="col-sm-8 item-col-detail">
                                                <?php echo html_entity_decode($group['description']); ?>
                                            </div>
                                        </div>
                                    <?php }?>

                                    <div class="row item-desc-prod">
                                        <div class="col-sm-4 item-col-detail">
                                            <h5>Share This:</h5>
                                        </div>
                                        <div class="col-sm-8 item-col-detail">
                                            <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                                            <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script> 
                                        </div>
                                    </div>
                                </div>
                                <!-- HTML UNTUK DESIGN DESKRIPSI -->
                                </div>
                            </div>
                            <!-- //OPTION -->
                            
                        </div>
                    </div>
                    <!-- //DETAIL -->
                </div>

                <!-- RELATED ================================================ -->
                <?php if ($products) { ?>
                    <h3><?php echo $text_related; ?></h3>
                    <div class="row">
                        <?php $i = 0; ?>
                        <?php foreach ($products as $product) { ?>
                            <?php if ($column_left && $column_right) { ?>
                                <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
                            <?php } elseif ($column_left || $column_right) { ?>
                                <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
                            <?php } else { ?>
                                <?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
                            <?php } ?>
                            <div class="<?php echo $class; ?>">
                                <div class="product-thumb transition">
                                    <div class="image">
                                        <a href="<?php echo $product['href']; ?>">
                                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                                        </a>
                                    </div>
                                    
                                    <div class="caption">
                                        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                                        <p><?php echo $product['description']; ?></p>
                                        <?php if ($product['rating']) { ?>
                                        <div class="rating">
                                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                <?php if ($product['rating'] < $i) { ?>
                                                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                                <?php } else { ?>
                                                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                                <?php } ?>
                                            <?php } ?>
                                        </div>
                                      <?php } ?>
                                      <?php if ($product['price']) { ?>
                                        <p class="price">
                                            <?php if (!$product['special']) { ?>
                                                <?php echo $product['price']; ?>
                                            <?php } else { ?>
                                                <span class="price-new"><?php echo $product['special']; ?></span> 
                                                <span class="price-old"><?php echo $product['price']; ?></span>
                                            <?php } ?>

                                            <?php if ($product['tax']) { ?>
                                                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                            <?php } ?>
                                        </p>
                                      <?php } ?>
                                    </div>
                                    <div class="button-group">
                                        <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span> <i class="fa fa-shopping-cart"></i></button>
                                        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                                        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                                    </div>
                                </div>
                            </div>

                            <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
                                <div class="clearfix visible-md visible-sm"></div>
                            <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
                                <div class="clearfix visible-md"></div>
                            <?php } elseif ($i % 4 == 0) { ?>
                                <div class="clearfix visible-md"></div>
                            <?php } ?>
                            <?php $i++; ?>
                        <?php } ?>
                    </div>
                <?php } ?>

                <!-- TAG ================================================ -->
                <?php if ($tags) { ?>
                    <p><?php echo $text_tags; ?>
                        <?php for ($i = 0; $i < count($tags); $i++) { ?>
                            <?php if ($i < (count($tags) - 1)) { ?>
                                <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
                            <?php } else { ?>
                                <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
                            <?php } ?>
                        <?php } ?>
                    </p>
                <?php } ?>

                <?php echo $content_bottom; ?>
                </div>

                <?php echo $column_right; ?>
            </div>
        </div>

    </div>


</div>
<script type="text/javascript"><!--

$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
  $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
    dataType: 'json',
    beforeSend: function() {
      $('#recurring-description').html('');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();
      
      if (json['success']) {
        $('#recurring-description').html(json['success']);
      }
    }
  });
});
//--></script> 
<script type="text/javascript"><!--
$(function(){
    if($(window).width() < 992){
        $('.alert-mobile').addClass('active');
    }else{
        $('.alert-mobile').removeClass('active');
    }
});

$(window).on('resize', function(){
   if($(window).width() < 992){
        $('.alert-mobile').addClass('active');
    }else{
        $('.alert-mobile').removeClass('active');
    } 
});

$('.button-cart').on('click', function() {
   
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('.to-add-bag .color-main .button-cart').button('loading');
    },
    complete: function() {
      $('.to-add-bag .color-main .button-cart').button('reset');
    },
    success: function(json) {
      // $('.alert, .text-danger').remove();
      $('.alert, .text-danger').hide();
      $('.form-group').removeClass('has-error');      

        // console.log(json);

      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            var element = $('#input-option' + i.replace('_', '-'));
            
            if (element.parent().hasClass('input-group')) {
              element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            } else {
              // element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                $('<div class="no-size2 text-danger no-size-req">' + json['error']['option'][i] + '</div>').insertAfter('.no-size');

                $('.custom-check label').hover(function(){
                    var att = $(this).attr('data-hover') || '';
                    if(att){                                                        
                        $('.no-size-req').remove();
                    }else{
                        return false;
                    }
                });
            }
          }
        }
        
        if (json['error']['recurring']) {
          $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
        }

        if (json['error']['cart_limit']) {
            $('<div class="no-size2 text-danger no-size-req">' + json['error']['cart_limit'] + '</div>').insertAfter('.no-size');
        }
        
        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');
      }
      
      if (json['success']) {
        if(json['successCustom']['special'] == '&nbsp;') {
          html = '<div class="row addToCartPopUp"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><p class="price"><span>'+json['successCustom']['price']+'<\/span><\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_cart']+'<\/div><\/div><\/div><\/div>';                     
        } else {
          html = '<div class="row addToCartPopUp"><div class="col-xs-12"><img class="img-responsive" src="'+json['successCustom']['image']+'" alt=""><p class="name">'+json['successCustom']['text_item']+'<\/p><p class="priceOld"><span>'+json['successCustom']['price']+'<\/span><\/p><p class="priceNew">'+json['successCustom']['special']+'<\/p><div class="order-subtotal-success"><div class="btn-group">'+json['successCustom']['button_continue']+''+json['successCustom']['button_cart']+'<\/div><\/div><\/div><\/div>';                     
        }
       
        // $('.cart-total').html(json['total']);
        // //alert('ok');
        // //location.reload();
        // $('#cart > ul, .cart > ul').load('index.php?route=common/cart/info ul li');

        $('#cart-total, .cart-total').html(json['total']);
                    
        $('#cart > ul, .cart > ul').load('index.php?route=common/cart/info ul li');

        setColor();
        setItemCart();

        //added by Wian
        $('#cart').addClass('open');

        if($('.alert-mobile').hasClass('active')){
            $('.alert-mobile.active').fadeIn();
            $('html, body').animate({scrollTop: 0}, 500);
          }else{        
            $('.alert-mobile').fadeOut();
          }
        //added by Wian
      }
    }
  });
});

$('.button-waitlist').on('click', function() {
 //alert('ok');  
  $.ajax({
    url: 'index.php?route=product/product/waitlist_add',
    type: 'post',
    data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('.to-add-bag .color-main .button-waitlist').button('loading');
    },
    complete: function() {
      $('.to-add-bag .color-main .button-waitlist').button('reset');
    },
    success: function(json) {
      console.log(json);
      $('.alert, .text-danger').hide();
      $('.text-danger').remove();
      $('.form-group').removeClass('has-error');      
      
      if (json['success']) {
        $('<div class="no-size2 text-danger no-size-req text-center">' + json['success'] + '</div>').insertAfter('.waitlist-success-' + json['product_id']);
      }
    }
  });
});
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
  pickTime: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});

$('.time').datetimepicker({
  pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
  var node = this;
  
  $('#form-upload').remove();
  
  $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
  
  $('#form-upload input[name=\'file\']').trigger('click');
  
  timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
      clearInterval(timer);
      
      $.ajax({
        url: 'index.php?route=tool/upload',
        type: 'post',
        dataType: 'json',
        data: new FormData($('#form-upload')[0]),
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
          $(node).button('loading');
        },
        complete: function() {
          $(node).button('reset');
        },
        success: function(json) {
          $('.text-danger').remove();
          
          if (json['error']) {
            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
          }
          
          if (json['success']) {
            alert(json['success']);
            
            $(node).parent().find('input').attr('value', json['code']);
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }, 500);
});
//--></script> 
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('#button-review').button('loading');
    },
    complete: function() {
      $('#button-review').button('reset');
      $('#captcha').attr('src', 'index.php?route=tool/captcha#'+new Date().getTime());
      $('input[name=\'captcha\']').val('');
    },
    success: function(json) {
      $('.alert-success, .alert-danger').remove();
      
      if (json['error']) {
        $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
      }
      
      if (json['success']) {
        $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
        
        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').prop('checked', false);
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});

$(document).ready(function() {

    //CLICK THUMBS
    $(".sticky-img-additional .thumbnail").on('click',function(){
        var att = $(this).attr('data-click');              
        $('html, body').animate({scrollTop: $('#'+att).offset().top - parseInt($('header').outerHeight() + parseInt(20))},300);
    });
    //CLICK THUMBS

    // $('.thumbnails').magnificPopup({
    //     type:'image',
    //     delegate: 'a',
    //     gallery: {
    //         enabled:true
    //     }
    // });

    $('ul.thumbnails').lightGallery({
        download : false,
        fullScreen : false,
        zoom : false,
        autoplayControls : false,
    });
  

    // // STICKY
    // $("[data-sticky_column]").stick_in_parent({
    //     parent: "[data-sticky_parent]",
    //     offset_top : 100,    
    // });
    // // STICKY


    // var getHeight = $('.get-h-img.color-main').height();
    // if($(window).width() < 992){
    //     $('.set-h-img, .cia-sticky').css({
    //         'min-height' : 'auto',
    //         'height' : 'auto'
    //     });

    //     // $("[data-sticky_column]").trigger("sticky_kit:detach");
    // }else{        
    //     $('.set-h-img, .cia-sticky').css({
    //         'min-height' : getHeight
    //     });
    // }




    

});

$.fn.superSetResize = function(){
    $(document).ready(function(){
        $(document).setResize();

    });

    $(window).on('resize', function(){
        $(document).setResize();
    });
}

$.fn.setResize = function(){
    var windowWidth = $(window).width();
    var getHeight = $('.get-h-img.color-main').height();

    if(windowWidth < 992){

        $('.set-h-img, .cia-sticky').css({
            'min-height' : 'auto',
            'height' : 'auto'
        });

        $("[data-sticky_column]").trigger("sticky_kit:detach");


        $('ul.thumbnails').slick({
            dots:true,
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: false,
            // mobileFirst: true
        })

    }else{

        $('.set-h-img, .cia-sticky').css({
            'min-height' : getHeight
        });

        // STICKY
        $("[data-sticky_column]").stick_in_parent({
            parent: "[data-sticky_parent]",
            offset_top : $('header').outerHeight() + parseInt(20),    
        });
        // STICKY

       // $('ul.thumbnails').slick("unslick");
       // $('ul.thumbnails').trigger("unslick");

       $('ul.thumbnails').on('destroy', function(event, slick, direction){
            console.log('edge was hit')
       });

    }
}

//--></script> 
<?php echo $footer; ?>
