<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">

            <div class="row alrt">                
                <?php if ($attention) { ?>
                <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
                    <!-- <button type="button" class="close" data-dismiss="alert">&times;</button> -->
                </div>
                <?php } ?>
                
                <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                    <!-- <button type="button" class="close" data-dismiss="alert">&times;</button> -->
                </div>
                <?php } ?>
                
                <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <!-- <button type="button" class="close" data-dismiss="alert">&times;</button> -->
                </div>
                <?php } ?>

                <?php if($error_cart_limit) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_cart_limit; ?>
                    <!-- <button type="button" class="close" data-dismiss="alert">&times;</button> -->
                </div>
                <?php } ?>
                </div>


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
                      
                    <a href="<?php echo $continue; ?>" class="link-to-shopping"><i class="fa fa-angle-left" aria-hidden="true"></i><i class="fa fa-angle-left" aria-hidden="true"></i> <?php echo $button_shopping; ?></a>

                    <div class="row wrap-shopping-cart">                        
                        
                        <div class="col-sm-6 col-xs-12 visible-sm-6">
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                                <div class="">                                    
                                    
                                    <div class="wrap-list-cart">
                                        <?php foreach ($products as $product) { ?>
                                        <div class="item-list-cart">
                                            <div class="cv-image">
                                                <?php if ($product['thumb']) { ?>
                                                    <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                                                <?php } ?>
                                            </div>
                                            <div class="cv-desc">
                                                <?php 
                                                    if (!$product['stock']) {
                                                        $warning = 'error-color font-bold';   
                                                    }else{
                                                        $warning = '';                                                    
                                                    }
                                                ?>
                                                <p><a href="<?php echo $product['href']; ?>" class="<?php echo $warning;?>"><h4><?php echo $product['name']; ?> (<?php echo $product['model']; ?>)</h4></a></p>
                                                <?php if (!$product['stock']) { ?>
                                                    <!-- <p class="text-danger">***</p> -->
                                                <?php } ?>

                                                <?php if ($product['option']) { ?>
                                                    <?php foreach ($product['option'] as $option) { ?>                                                        
                                                        <p><?php echo $option['name']; ?>: <?php echo $option['value']; ?></p>
                                                    <?php } ?>
                                                <?php } ?>

                                                <?php if ($product['reward']) { ?>                                                    
                                                    <p><?php echo $product['reward']; ?></p>
                                                <?php } ?>
                                                
                                                <?php if ($product['recurring']) { ?>                                                    
                                                    <p class="label label-info"><?php echo $text_recurring_item; ?></p>
                                                    <p><?php echo $product['recurring']; ?></p>
                                                <?php } ?>

                                                <div class="qty-cart">                                                    
                                                    <div class="col-sm-6 no-padding">
                                                        <label>QTY:&nbsp;</label>                                                            
                                                        <input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" maxlength="2" />
                                                        <button type="submit" title="<?php echo $button_update; ?>" class="btn btn-primary btn-refresh-cart"><i class="fa fa-refresh"></i></button>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="text-right">                                                                
                                                            <?php echo $product['total']; ?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <button type="button" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-close-cart" onclick="cart.remove('<?php echo $product['key']; ?>');"><i class="fa fa-times"></i></button>
                                            </div>
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </form>
                        </div>
                        
                        <div class="col-sm-4 col-sm-offset-2 col-xs-12 order-sum-incart">
                            <div class="order-summary">
                                <h3>Order Summary</h3>
                                <div class="itm-summary col-xs-12">                                    
                                    <?php foreach ($totals as $key => $total) { ?>
                                        <div class="col-sm-5 col-xs-6 no-padding">
                                            <p>
                                                <?php if($total['code'] == 'shipping'){ ?>
                                                <?php $part = preg_split('/[\s,]+/', $total['title'], 3);//get two word in the first ?>
                                                    <strong><?=$part[0]?> <?=$part[1]?></strong>    
                                                <?php }elseif($total['code'] == 'coupon'){?>
                                                    <?php $part_coupon = str_replace('Coupon', '', $total['title']);?>
                                                    <strong><?=$part_coupon?></strong>   
                                                <?php }else{?>
                                                     <strong><?= $total['title']?></strong>   
                                                <?php }?>  
                                            </p>
                                        </div>
                                        <div class="col-sm-7 col-xs-6 no-padding-right">
                                            <p class="text-right tprice <?php echo ($key == 0)? '' : 'total-price';?>">
                                                <?php echo $total['text']; ?>   
                                            </p>
                                        </div>
                                        <div class="clearfix"></div>
                                    <?php } ?>
                                </div>
                            </div>                
                            <div class="coupon">
                                <?php 
                                    if($is_coupon){
                                        $txt_coupon1 = 'style="display:none !important"'; 
                                        $txt_coupon2 = 'style="display:block !important"'; 
                                    }else{ 
                                        $txt_coupon1 = 'style="display:block !important"';
                                        $txt_coupon2 = 'style="display:none !important"';
                                    } ?>
                                <div class="question-coupon" <?php echo $txt_coupon1;?>>
                                    <p>Do you have coupon code? <a href="javascript:;" class="apply-coupon">Apply the coupon here.</a></p>
                                </div>

                                <div class="frm-coupon" <?php echo $txt_coupon2;?>>                                    
                                    <?php echo $coupon; ?>
                                </div>
                                <input type="hidden" name="is_checkout" value="0">
                            </div>
                            <div class="clearfix"></div>

                            <?php if($referral){ ?>
                            <div class="coupon">
                                <?php 
                                    if($is_coupon){
                                        $txt_coupon1 = 'style="display:none !important"'; 
                                        $txt_coupon2 = 'style="display:block !important"'; 
                                    }else{ 
                                        $txt_coupon1 = 'style="display:block !important"';
                                        $txt_coupon2 = 'style="display:none !important"';
                                    } ?>
                                <div class="question-coupon" <?php echo $txt_coupon2;?>>
                                    <p>You have <b><?php echo $referral_point ?></b>. <a href="javascript:;" class="apply-referral">Apply the referral point here.</a></p>
                                </div>

                                <div class="frm-referral" <?php echo $txt_coupon1;?>>                                    
                                    <?php echo $referral; ?>
                                     <input type="hidden" name="referral_is_checkout" value="0">
                                </div>
                            </div>
                            <div class="clearfix"></div>            
                            <?php }?>

                            <div class="buttons">
                                <a href="<?php echo $checkout; ?>" class="btn btn-grey display-block btn-primary"><?php echo $button_checkout; ?></a>
                            </div>
                        </div>

                        
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>

<!-- COMMENT -->
<?php /*
<!-- <?php //if ($coupon || $voucher || $reward || $shipping) { ?>
<h2><?php //echo $text_next; ?></h2>
<p><?php //echo $text_next_choice; ?></p>
<div class="panel-group" id="accordion"><?php //echo $coupon; ?><?php //echo $voucher; ?><?php //echo $reward; ?><?php //echo $shipping; ?></div>
<?php //} ?>
<br />-->*/ ?>
<!-- COMMENT -->

<script>
    $('.apply-coupon').on('click',function(){
        $(this).parent().hide();
        $('.frm-coupon').show();
    });

    $('.apply-referral').on('click',function(){
        $(this).parent().hide();
        $('.frm-referral').show();
    });
</script>
<?php echo $footer; ?>