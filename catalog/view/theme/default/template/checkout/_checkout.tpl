<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Checkout</h1>
            </div>

            <div class="head-step-checkout">
                <ul>
                    <li data-step="1" class="active"><a href="javascript:;">Checkout Options</a></li>
                    <li data-step="2"><a href="javascript:;">Billing Details</a></li>
                    <li data-step="3"><a href="javascript:;">Delivery Details</a></li>
                    <li data-step="4"><a href="javascript:;">Delivery Method</a></li>
                    <li data-step="5"><a href="javascript:;">Payment Method</a></li>
                    <li data-step="6"><a href="javascript:;">Confirm Order</a></li>
                </ul>
            </div>
            
            <div class="alrt">
                <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>

                <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
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
                    <div class="row">      
                        <div class="col-sm-5 col-xs-12 order-sum-mobile">
                            <div class="order-summary">
                                <h3>Order Summary</h3>
                                <div class="itm-summary col-xs-12">                                                                    
                                    <?php if($totals){ ?>
                                        <?php foreach($totals as $key => $t){ ?>

                                        <div class="col-sm-6 col-xs-6 no-padding">
                                            <p>
                                                <strong><?= $t['title']?></strong>    
                                            </p>
                                        </div>
                                        <div class="col-sm-6 col-xs-6 no-padding-right">
                                            <p class="text-right tprice <?php echo ($key == 0)? '' : 'total-price';?>">
                                                <?= $t['value'] ?>
                                            </p> 
                                        </div>
                                    <?php }}?>
                                </div>
                            </div>
                            
                        </div>

                        <div class="col-sm-7 col-xs-12 ">                                            
                            <div class="panel-group panel-group-checkout form-style-2" id="accordion">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_option; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-checkout-option">                                    
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php if (!$logged && $account != 'guest') { ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_account; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-payment-address">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php } else { ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_payment_address; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-payment-address">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if ($shipping_required) { ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_shipping_address; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-shipping-address">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_shipping_method; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-shipping-method">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if($extraTotal['wrapping']) { ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_gift_wrapping; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-gift-wrapping">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if($extraTotal['gift_card']) { ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_gift_card; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-gift-card">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <?php } ?>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_payment_method; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-payment-method">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                                <div class="panel panel-default display-none">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><?php echo $text_checkout_confirm; ?></h4>
                                    </div>
                                    <div class="panel-collapse collapse" id="collapse-checkout-confirm">
                                        <div class="panel-body"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4 col-sm-offset-1 order-sum-desktop">
                            <div class="order-summary">
                                <h3>Order Summary</h3>
                                <div class="itm-summary col-xs-12">   
                                                                                                 
                                    <?php if($totals){ ?>
                                        <?php foreach($totals as $key => $t){ ?>
                                        <div class="col-sm-6 col-xs-6 no-padding">
                                            <p> 
                                                <strong><?= $t['title']?></strong> 
                                            </p>
                                        </div>
                                        <div class="col-sm-6 col-xs-6 no-padding-right">
                                            <p class="text-right tprice <?php echo ($key == 0)? '' : 'total-price';?>">
                                                <?= $t['value'] ?>
                                            </p> 
                                        </div>
                                    <?php }}?>

                                </div>
                            </div>

                            <div class="coupon">
                                <?php 
                                    if($is_coupon){
                                        $txt_coupon1 = 'style="display:none !important"'; 
                                        $txt_coupon2 = 'style="display:block !important"'; 
                                        $is_checkout = '1';
                                    }else{ 
                                        $txt_coupon1 = 'style="display:block !important"';
                                        $txt_coupon2 = 'style="display:none !important"';
                                        $is_checkout = '';
                                    } ?>
                                <?php if($store_id <= 0){ ?>
                                <div class="question-coupon" <?php echo $txt_coupon1;?>>
                                    <p>Do you have coupon code? <a href="javascript:;" class="apply-coupon">Apply the coupon here.</a></p>
                                </div>
                                <?php }?>
                                <div class="frm-coupon" <?php echo $txt_coupon2;?>>                                    
                                    <?php echo $coupon; ?>
                                    <input type="hidden" name="is_checkout" value="<?php echo $is_checkout;?>">
                                </div>
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


<script type="text/javascript"><!--
$('.apply-coupon').on('click',function(){
    $(this).parent().hide();
    $('.frm-coupon').show();
    $('input[name=is_checkout]').val('1');
});


$(document).on('change', 'input[name=\'account\']', function() {
  if ($('#collapse-payment-address').parent().find('.panel-heading .panel-title > *').is('a')) {  
    if (this.value == 'register') {
      $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
    } else {
      $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
    }
  } else {
    if (this.value == 'register') {
      $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_account; ?>');
    } else {
      $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_address; ?>');
    } 
  }
});

<?php if (!$logged) { ?> 
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=checkout/login',
        dataType: 'html',
        success: function(html) {
           $('#collapse-checkout-option .panel-body').html(html);
          
        $('#collapse-checkout-option').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-option" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_option; ?> <i class="fa fa-caret-down"></i></a>');
      
        $('a[href=\'#collapse-checkout-option\']').trigger('click');
        
        // Added By Wian
        $('#collapse-checkout-option').parent().fadeIn();
        $('.coption').show();
        // $('.head-step-checkout li[data-step=2]').addClass('active');
        // Added By Wian

        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});     


<?php } else { ?>
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_address',
        dataType: 'html',
        success: function(html) {
            $('#collapse-payment-address .panel-body').html(html);
            
            $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');

            $('a[href=\'#collapse-payment-address\']').trigger('click');
            
            // Added By Wian
            $('#collapse-checkout-option').parent().hide();
            $('#collapse-payment-address').parent().fadeIn();
            $('.head-step-checkout li[data-step=2]').addClass('active');
            $('.coption').hide();
            $('.cpayment-address').show();
            // Added By Wian

        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
<?php } ?>


// Checkout
$(document).delegate('#button-account', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').val(),
        dataType: 'html',
        beforeSend: function() {
          $('#button-account').button('loading');
    },      
        complete: function() {
      $('#button-account').button('reset');
        },          
        success: function(html) {
            $('.alert, .text-danger').remove();
            
            $('#collapse-payment-address .panel-body').html(html);

      if ($('input[name=\'account\']:checked').val() == 'register') {

        // Added By Wian
        $('#collapse-checkout-option').parent().hide();
        $('#collapse-payment-address').parent().fadeIn();
        $('.head-step-checkout li[data-step=2]').addClass('active');
        $('.coption').hide();
        $('.cpayment-address').show();
        // Added By Wian



        $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_account; ?> <i class="fa fa-caret-down"></i></a>');
        
      } else {
        // Added By Wian
        $('#collapse-checkout-option').parent().hide();
        $('#collapse-payment-address').parent().fadeIn();
        $('.head-step-checkout li[data-step=2]').addClass('active');
        $('.coption').hide();
        $('.cpayment-address').show();
        // Added By Wian



        $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
      } 
      
      $('a[href=\'#collapse-payment-address\']').trigger('click');
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});


// Login
$(document).delegate('#button-login', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/login/save',
        type: 'post',
        data: $('#collapse-checkout-option :input'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-login').button('loading');
    },  
        complete: function() {
            $('#button-login').button('reset');
        },              
        success: function(json) {
            $('.alert, .text-danger').remove();
            $('.form-group').removeClass('has-error');
      
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#collapse-checkout-option .panel-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
           
        // Highlight any found errors
        $('input[name=\'email\']').parent().addClass('has-error');  
        $('input[name=\'password\']').parent().addClass('has-error');    
       }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

// Register
$(document).delegate('#button-register', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/register/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-register').button('loading');
        },  
        complete: function() {
            $('#button-register').button('reset');
        },          
        success: function(json) {
            console.log(json);
            $('.alert, .text-danger').remove();
            $('.form-group div').removeClass('has-error');
                  
            if (json['redirect']) {
                location = json['redirect'];                
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                
                for (i in json['error']) {
                  var element = $('#input-payment-' + i.replace('_', '-'));
                  
                  if ($(element).parent().hasClass('input-group')) {
                    $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                  } else {
                    $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                  }
                }
        
                // Highlight any found errors
                $('.text-danger').parent().addClass('has-error');         
                    } else {
                        <?php if ($shipping_required) { ?>              
                        var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').prop('value');
                        
                        if (shipping_address) {
                            $.ajax({
                                url: 'index.php?route=checkout/shipping_method',
                                dataType: 'html',
                                success: function(html) {
                      // Add the shipping address
                                    $.ajax({
                                        url: 'index.php?route=checkout/shipping_address',
                                        dataType: 'html',
                                        success: function(html) {
                                            $('#collapse-shipping-address .panel-body').html(html);
                          
                          $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
                                        },
                                        error: function(xhr, ajaxOptions, thrownError) {
                                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                        }
                                    }); 
                      
                                    $('#collapse-shipping-method .panel-body').html(html);
                                    
                                    $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');
           
                                    $('a[href=\'#collapse-shipping-method\']').trigger('click');

                                    $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                                    $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');              
                                    $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>'); 
                                
                                    // Added By Wian
                                    $('#collapse-shipping-method').parent().fadeIn();
                                    // Added By Wian

                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            }); 
                        } else {
                            $.ajax({
                                url: 'index.php?route=checkout/shipping_address',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address .panel-body').html(html);
                                    
                                    $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
              
                                    $('a[href=\'#collapse-shipping-address\']').trigger('click');
                      
                                    $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');

                                    <?php if($extraTotal['wrapping']) { ?>
                                        $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                                    <?php } ?>
                                    <?php if($extraTotal['gift_card']) { ?>
                                        $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                                    <?php } ?>

                                    $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');              
                                    $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>'); 
                                

                                    // Added By Wian
                                    $('#collapse-shipping-method').parent().fadeIn();
                                    // Added By Wian

                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });         
                        }
                        <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=checkout/payment_method',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-method .panel-body').html(html);
                                
                    $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
                    
                    $('a[href=\'#collapse-payment-method\']').trigger('click');
                    
                    $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');         
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });                 
                        <?php } ?>

                        $.ajax({
                            url: 'index.php?route=checkout/payment_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-address .panel-body').html(html);

                                // Added By Wian
                                $('#collapse-payment-address').parent().hide();
                                $('#collapse-shipping-address').parent().fadeIn();
                                $('.head-step-checkout li[data-step=3]').addClass('active');
                                $('.cpayment-address').hide();
                                $('.cshipping-address').show();
                                // Added By Wian
                                
                    $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    }    
                },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
    }); 
});

// Payment Address  
$(document).delegate('#button-payment-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_address/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-payment-address').button('loading');
    },  
        complete: function() {
      $('#button-payment-address').button('reset');
        },          
        success: function(json) {
            console.log(json);
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                        
        for (i in json['error']) {
          var element = $('#input-payment-' + i.replace('_', '-'));
          if ($(element).parent().find('.btn-group').length) {
                        $(element).parent().find('.btn-group').after('<div class="text-danger">' + json['error'][i] + '</div>');
                    } else {
                        if ($(element).parent().hasClass('input-group')) {
                            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                        } else {
                            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                        }
                    }         
        }
                
        // Highlight any found errors
        $('.text-danger').parent().parent().addClass('has-error');        
            } else {
                <?php if ($shipping_required) { ?>
                $.ajax({
                    url: 'index.php?route=checkout/shipping_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-shipping-address .panel-body').html(html);
                        
            $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-shipping-address\']').trigger('click');

            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');

                        <?php if($extraTotal['wrapping']) { ?>
                            $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                        <?php } ?>
                        <?php if($extraTotal['gift_card']) { ?>
                            $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                        <?php } ?>

            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                <?php } else { ?>
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);
                      
            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-payment-method\']').trigger('click');

            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                }); 
                <?php } ?>
                
                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-address .panel-body').html(html);

                        // Added By Wian
                        $('#collapse-payment-address').parent().hide();
                        $('#collapse-shipping-address').parent().fadeIn();
                        $('.head-step-checkout li[data-step=3]').addClass('active');
                        $('.cpayment-address').hide();
                        $('.cshipping-address').show();
                        // Added By Wian
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });             
            }     
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

// Shipping Address         
$(document).delegate('#button-shipping-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/shipping_address/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'hidden\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
      $('#button-shipping-address').button('loading');
      },  
        complete: function() {
      $('#button-shipping-address').button('reset');
        },          
        success: function(json) {
            console.log(json);
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                  
        for (i in json['error']) {
          var element = $('#input-shipping-' + i.replace('_', '-'));

                    if ($(element).parent().find('.btn-group').length) {
                        $(element).parent().find('.btn-group').after('<div class="text-danger">' + json['error'][i] + '</div>');
                    } else {          
              if ($(element).parent().hasClass('input-group')) {
                $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
              } else {
                $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
              }
                    }
        }
                
        // Highlight any found errors
        $('.text-danger').parent().parent().addClass('has-error');        
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/shipping_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-shipping-method .panel-body').html(html);
                        
            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');
    
            $('a[href=\'#collapse-shipping-method\']').trigger('click');

                        <?php if($extraTotal['wrapping']) { ?>
                            $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                        <?php } ?>
                        <?php if($extraTotal['gift_card']) { ?>
                            $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                        <?php } ?>

            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
            
                        $.ajax({
                            url: 'index.php?route=checkout/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-shipping-address .panel-body').html(html);


                                // Added By Wian
                                $('#collapse-shipping-address').parent().hide();
                                $('#collapse-shipping-method').parent().fadeIn();
                                $('.head-step-checkout li[data-step=4]').addClass('active');
                                $('.cshipping-address').hide();
                                $('.cshipping-method').show();
                                // Added By Wian
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                }); 
                
                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-address .panel-body').html(html);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

// Guest
$(document).delegate('#button-guest', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/guest/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-guest').button('loading');
      },  
        complete: function() {
      $('#button-guest').button('reset');
        },          
        success: function(json) {
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }
                                
        for (i in json['error']) {
          var element = $('#input-payment-' + i.replace('_', '-'));
          
          if ($(element).parent().hasClass('input-group')) {
            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
          } else {
            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
          }
        }
                
        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');         
            } else {
                <?php if ($shipping_required) { ?>  
                var shipping_address = $('#collapse-payment-address input[name=\'shipping_address\']:checked').prop('value');
                
                if (shipping_address) {
                    $.ajax({
                        url: 'index.php?route=checkout/shipping_method',
                        dataType: 'html',
                        success: function(html) {
              // Add the shipping address
                            $.ajax({
                                url: 'index.php?route=checkout/guest_shipping',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address .panel-body').html(html);
                  
                  $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });
                           
                $('#collapse-shipping-method .panel-body').html(html);
              
              $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i></a>');

                            <?php if($extraTotal['wrapping']) { ?>
                                $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                            <?php } ?>
                            <?php if($extraTotal['gift_card']) { ?>
                                $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                            <?php } ?>
              
              $('a[href=\'#collapse-shipping-method\']').trigger('click');
                  
              $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
              $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });                 
                } else {
                    $.ajax({
                        url: 'index.php?route=checkout/guest_shipping',
                        dataType: 'html',
                        success: function(html) {
                            $('#collapse-shipping-address .panel-body').html(html);
                             
              $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');
              
              $('a[href=\'#collapse-shipping-address\']').trigger('click');

                            <?php if($extraTotal['wrapping']) { ?>
                                $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                            <?php } ?>
                            <?php if($extraTotal['gift_card']) { ?>
                                $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                            <?php } ?>
            
              $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
              $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
              $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
                <?php } else { ?>               
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);
                        
            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-payment-method\']').trigger('click');
            
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });             
                <?php } ?>
            }    
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

// Guest Shipping
$(document).delegate('#button-guest-shipping', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/guest_shipping/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-guest-shipping').button('loading');
    },  
        complete: function() {
      $('#button-guest-shipping').button('reset');
        },          
        success: function(json) {
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-shipping-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }

        for (i in json['error']) {
          var element = $('#input-shipping-' + i.replace('_', '-'));
          
          if ($(element).parent().hasClass('input-group')) {
            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
          } else {
            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
          }
        }
        
        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');       
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/shipping_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-shipping-method .panel-body').html(html);
            
            $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_method; ?> <i class="fa fa-caret-down"></i>');
            
            $('a[href=\'#collapse-shipping-method\']').trigger('click');

                        <?php if($extraTotal['wrapping']) { ?>
                            $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_wrapping; ?>');
                        <?php } ?>
                        <?php if($extraTotal['gift_card']) { ?>
                            $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_gift_card; ?>');
                        <?php } ?>

            $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });             
            }    
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

<?php if(!$extraTotal['gift_card'] && !$extraTotal['wrapping']) { ?>
$(document).delegate('#button-shipping-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/shipping_method/save',
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-shipping-method').button('loading');
    },  
        complete: function() {
      $('#button-shipping-method').button('reset');
        },          
        success: function(json) {

            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                       
                        //console.log(json);
                        
                        $('#collapse-payment-method .panel-body').html(html);

                        var obj = json['html'];
                        // console.log(json['html']);
                        var length = obj.length;  
                        var items = [];
                        //alert(length);
                        $.each(obj, function(key, value) {
                            var code = obj[key].code;
                            var title = obj[key].title;
                            var colorRed = '';
                            
                            if(key != 0){
                                colorRed = 'total-price';
                            }else{
                                colorRed = '';
                            }

                            var html_summary = '<div class="col-sm-6 col-xs-6 no-padding">';
                                    html_summary += '<p>';
                                        html_summary += '<strong>' + obj[key].title + '</strong>'; 
                                    html_summary += '</p>';
                                html_summary += '</div>';
                                html_summary += '<div class="col-sm-6 col-xs-6 no-padding-right">';
                                    html_summary += '<p class="text-right tprice '+colorRed+'">';
                                        html_summary += '<span>' + obj[key].value + '</span>'; 
                                    html_summary += '</p>';
                                html_summary += '</div>';
   

                            items.push(html_summary);   
                            //alert(obj[key].value);                                             
                        });

                        $(".itm-summary").html(items.join(" "));
                        
                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
            
                        $('a[href=\'#collapse-payment-method\']').trigger('click');
            
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    
                        // Added By Wian                        
                        $('#collapse-shipping-method').parent().hide();
                        $('#collapse-payment-method').parent().fadeIn();
                        $('.head-step-checkout li[data-step=5]').addClass('active');
                        $('.cshipping-method').hide();
                        $('.cpayment-method').show();
                        // Added By Wian
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});
<?php } ?>

<?php if($extraTotal['wrapping'] && $extraTotal['gift_card']) { ?>
$(document).delegate('#button-shipping-method', 'click', function() {
  $.ajax({
    url: 'index.php?route=checkout/shipping_method/save',
    type: 'post',
    data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-shipping-method').button('loading');
    },  
    complete: function() {
      $('#button-shipping-method').button('reset');
    },          
    success: function(json) {
      $('.alert, .text-danger').remove();
            
      if (json['redirect']) {
        location = json['redirect'];
      } else if (json['error']) {
        if (json['error']['warning']) {
          $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }           
      } else {
        $.ajax({
          url: 'index.php?route=checkout/wrapping',
          dataType: 'html',
          success: function(html) {

            $('#collapse-gift-wrapping .panel-body').html(html);
                        
            $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<a href="#collapse-gift-wrapping" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_gift_wrapping; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-gift-wrapping\']').trigger('click');
            
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });                 
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  }); 
});

$(document).delegate('#button-gift-wrapping', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/wrapping/save',
        type: 'post',
        data: $('#collapse-gift-wrapping input[type=\'radio\']:checked, #collapse-gift-wrapping textarea, #collapse-gift-wrapping input[type=\'number\'], #collapse-gift-wrapping input[type=\'hidden\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-gift-wrapping').button('loading');
        },  
        complete: function() {
            $('#button-gift-wrapping').button('reset');
        },          
        success: function(json) {            
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-gift-wrapping .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/gift_card',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-gift-card .panel-body').html(html);
                        
                        $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<a href="#collapse-gift-card" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_gift_card; ?> <i class="fa fa-caret-down"></i></a>');
                        
                        $('a[href=\'#collapse-gift-card\']').trigger('click');
                        
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            } 
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});

$(document).delegate('#button-gift-card', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/gift_card/save',
        type: 'post',
        data: $('#collapse-gift-card input[type=\'radio\']:checked, #collapse-gift-card textarea, #collapse-gift-card input[type=\'number\'], #collapse-gift-card input[type=\'hidden\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-gift-card').button('loading');
        },  
        complete: function() {
            $('#button-gift-card').button('reset');
        },          
        success: function(json) {            
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-gift-card .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);
                        
                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
                        
                        $('a[href=\'#collapse-payment-method\']').trigger('click');
                        
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            } 
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});
<?php } ?>

<?php if($extraTotal['wrapping'] && !$extraTotal['gift_card']) { ?>
$(document).delegate('#button-shipping-method', 'click', function() {
  $.ajax({
    url: 'index.php?route=checkout/shipping_method/save',
    type: 'post',
    data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-shipping-method').button('loading');
    },  
    complete: function() {
      $('#button-shipping-method').button('reset');
    },          
    success: function(json) {
      $('.alert, .text-danger').remove();
            
      if (json['redirect']) {
        location = json['redirect'];
      } else if (json['error']) {
        if (json['error']['warning']) {
          $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }           
      } else {
        $.ajax({
          url: 'index.php?route=checkout/wrapping',
          dataType: 'html',
          success: function(html) {
            $('#collapse-gift-wrapping .panel-body').html(html);
                        
            $('#collapse-gift-wrapping').parent().find('.panel-heading .panel-title').html('<a href="#collapse-gift-wrapping" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_gift_wrapping; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-gift-wrapping\']').trigger('click');
            
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });                 
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  }); 
});

$(document).delegate('#button-gift-wrapping', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/wrapping/save',
        type: 'post',
        data: $('#collapse-gift-wrapping input[type=\'radio\']:checked, #collapse-gift-wrapping textarea, #collapse-gift-wrapping input[type=\'number\'], #collapse-gift-wrapping input[type=\'hidden\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-gift-wrapping').button('loading');
        },  
        complete: function() {
            $('#button-gift-wrapping').button('reset');
        },          
        success: function(json) {            
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-gift-wrapping .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);
                        
                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
                        
                        $('a[href=\'#collapse-payment-method\']').trigger('click');
                        
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            } 
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});
<?php } ?>

<?php if(!$extraTotal['wrapping'] && $extraTotal['gift_card']) { ?>
$(document).delegate('#button-shipping-method', 'click', function() {
  $.ajax({
    url: 'index.php?route=checkout/shipping_method/save',
    type: 'post',
    data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-shipping-method').button('loading');
    },  
    complete: function() {
      $('#button-shipping-method').button('reset');
    },          
    success: function(json) {
      $('.alert, .text-danger').remove();
            
      if (json['redirect']) {
        location = json['redirect'];
      } else if (json['error']) {
        if (json['error']['warning']) {
          $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        }           
      } else {
        $.ajax({
          url: 'index.php?route=checkout/gift_card',
          dataType: 'html',
          success: function(html) {
            $('#collapse-gift-card .panel-body').html(html);
                        
            $('#collapse-gift-card').parent().find('.panel-heading .panel-title').html('<a href="#collapse-gift-card" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_gift_card; ?> <i class="fa fa-caret-down"></i></a>');
            
            $('a[href=\'#collapse-gift-card\']').trigger('click');
            
            $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });                 
      }
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  }); 
});

$(document).delegate('#button-gift-card', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/gift_card/save',
        type: 'post',
        data: $('#collapse-gift-card input[type=\'radio\']:checked, #collapse-gift-card textarea, #collapse-gift-card input[type=\'number\'], #collapse-gift-card input[type=\'hidden\']'),
        dataType: 'json',
        beforeSend: function() {
            $('#button-gift-card').button('loading');
        },  
        complete: function() {
            $('#button-gift-card').button('reset');
        },          
        success: function(json) {            
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-gift-card .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method .panel-body').html(html);
                        
                        $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
                        
                        $('a[href=\'#collapse-payment-method\']').trigger('click');
                        
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });                 
            } 
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});
<?php } ?>

$(document).delegate('#button-payment-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_method/save', 
        type: 'post',
        data: $('#collapse-payment-method input[type=\'radio\']:checked, #collapse-payment-method input[type=\'checkbox\']:checked, #collapse-payment-method textarea'),
        dataType: 'json',
        beforeSend: function() {
          $('#button-payment-method').button('loading');
    },  
        complete: function() {
            $('#button-payment-method').button('reset');
        },          
        success: function(json) {
          //console.log(json);return false;
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-payment-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/confirm',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-checkout-confirm .panel-body').html(html);
              
                        $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<a href="#collapse-checkout-confirm" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_confirm; ?> <i class="fa fa-caret-down"></i></a>');
            
                        $('a[href=\'#collapse-checkout-confirm\']').trigger('click');


                        // Added By Wian
                        $('#collapse-payment-method').parent().hide();
                        $('#collapse-checkout-confirm').parent().fadeIn();
                        $('.head-step-checkout li[data-step=6]').addClass('active');

                        $('.cpayment-method').hide();
                        $('.cconfirm').show();
                        $('.coupon').hide();
                        // Added By Wian
          },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                }); 
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    }); 
});
//--></script> 
<?php echo $footer; ?>