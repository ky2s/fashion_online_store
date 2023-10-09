<?php if ($error_warning) { ?>
    <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
<?php } ?>

<?php if ($payment_methods) { ?>
    <p><?php echo $text_payment_method; ?></p>
    <div class="row pay-detail">
        <?php foreach ($payment_methods as $payment_method) { ?>
        <div class="col-sm-6 col-xs-6">
            <div class="radio">
                <label>
                    <?php if ($payment_method['code'] == $code || !$code) { ?>
                    <?php $code = $payment_method['code']; ?>
                    <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" />
                    <?php } ?>
                    <?php echo $payment_method['title']; ?>
                    <?php if ($payment_method['terms']) { $explod=explode("img", $payment_method['terms']); ?>
                    <p><?php echo $payment_method['terms']; ?></p>
                    <?php } ?>
                </label>
            </div>
        </div>
        <?php } ?>
    </div>
<?php } ?>
<br>
<p><strong><?php echo $text_comments; ?></strong></p>

<p>
    <textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
</p>

<?php if ($text_agree) { ?>

    <div class="buttons">
        <div class="col-xs-12 text-right">
            <label for="agree">                
                <p class="display-inline-block"><?php echo $text_agree; ?> &nbsp;</p>
                <?php if ($agree) { ?>
                <input type="checkbox" name="agree" value="1" checked="checked" id="agree" />
                <?php } else { ?>
                <input type="checkbox" name="agree" value="1" id="agree"/>
                <?php } ?>            
            </label>
        </div>

        <input type="button" value="BACK" id="backto-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
        <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
    </div>

<?php } else { ?>

    <div class="buttons">
            <input type="button" value="BACK" id="backto-shipping-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
        <!-- <div class="pull-right"> -->
            <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
        <!-- </div> -->

    </div>
<?php } ?>

<script>
    //added by wian
    $('#backto-shipping-method').on('click', function(){
        $('#collapse-shipping-method').addClass('in');
        $('#collapse-shipping-method').css({'height':'auto'});
        $('#collapse-shipping-method').parent().show();

        $('#collapse-payment-method').removeClass('in');
        $('#collapse-payment-method').parent().hide();
        $('.head-step-checkout li[data-step=5]').removeClass('active');
    });
    //added by wian
</script>