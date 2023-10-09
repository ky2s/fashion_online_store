<?php if ($error_warning) { ?>
<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<p><?php echo $text_shipping_method; ?></p>
<?php foreach ($shipping_methods as $shipping_method) { ?>
<p><strong><?php echo $shipping_method['title']; ?></strong></p>
<?php if (!$shipping_method['error']) { ?>
<?php foreach ($shipping_method['quote'] as $quote) { ?>
<div class="radio">
    <label>
        <?php if ($quote['code'] == $code || !$code) { ?>
        <?php $code = $quote['code']; ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" checked="checked" />
        <?php } else { ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" />
        <?php } ?>
    <?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
</div>
<?php } ?>
<?php } else { ?>
<div class="alert alert-danger"><?php echo $shipping_method['error']; ?></div>
<?php } ?>
<?php } ?>
<?php } ?>
<p><strong><?php echo $text_comments; ?></strong></p>
<p>
    <textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
</p>
<div class="buttons">
    <!-- <div class="pull-right"> -->
    <input type="button" value="BACK" id="backto-shipping-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
    <input type="button" value="<?php echo $button_continue; ?>" id="button-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
    <!-- </div> -->

</div>

<script>
    //added by wian
    $('#backto-shipping-address').on('click', function(){
        $('#collapse-shipping-address').addClass('in');
        $('#collapse-shipping-address').css({'height':'auto'});
        $('#collapse-shipping-address').parent().show();

        $('#collapse-shipping-method').removeClass('in');
        $('#collapse-shipping-method').parent().hide();

        $('.head-step-checkout li[data-step=4]').removeClass('active');
    });
    //added by wian
</script>