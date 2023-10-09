<h2><?php echo $text_instruction; ?></h2>
<div class="checkoutConfirmWrapper">
<p><?php echo $text_logo; ?></p>
<p><b><?php echo $text_detail1; ?></b></p>
<div class="well well-sm">
  <p><b><?php echo $text_accountno; ?></b><?php echo $accountno; ?></p>
  <p><b><?php echo $text_accountname; ?></b><?php echo $accountname; ?></p>
  <p><?php echo $text_detail2; ?></p>
</div>

<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" />
  </div>
</div>
</div>
<script type="text/javascript"><!--
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