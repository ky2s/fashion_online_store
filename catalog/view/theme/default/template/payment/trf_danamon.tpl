<?php /*
<h2><?php echo $text_instruction; ?></h2>
<div class="checkoutConfirmWrapper">
<p><?php echo $text_logo; ?></p>
<p><b><?php echo $text_detail1; ?></b></p>
<div class="well well-sm">
  <p><b><?php echo $text_accountno; ?></b><?php echo $accountno; ?></p>
  <p><b><?php echo $text_accountname; ?></b><?php echo $accountname; ?></p>
  <p><?php echo $text_detail2; ?></p>
</div>
*/ ?>

<div>
	<p>
		Please see and confirm your detail order <br>(please make sure you click confirm order button below, if you don't we can't see your order)
	</p>
	<p>&nbsp;</p>
</div>

<div class="buttons">
  <!-- <div class="pull-right"> -->
  	<input type="button" value="BACK" id="backto-payment-method" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary btn-grey" />
  <!-- </div> -->
</div>
</div>
<script type="text/javascript"><!--

//added by wian
$('#backto-payment-method').on('click', function(){
    $('#collapse-payment-method').addClass('in');
    $('#collapse-payment-method').css({'height':'auto'});
    $('#collapse-payment-method').parent().show();

    $('#collapse-checkout-confirm').removeClass('in');
    $('#collapse-checkout-confirm').parent().hide();
    $('.head-step-checkout li[data-step=6]').removeClass('active');
    $('.coupon').show();
});
//added by wian

$('#button-confirm').on('click', function() {
	$.ajax({ 
		type: 'get',
		url: 'index.php?route=payment/trf_danamon/confirm',
		cache: false,
		beforeSend: function() {
			$('#button-confirm').button('loading');
		},
		complete: function() {
			$('#button-confirm').button('reset');
		},		
		success: function() {
			location = '<?php echo $continue; ?>';
		}		
	});
});
//--></script>