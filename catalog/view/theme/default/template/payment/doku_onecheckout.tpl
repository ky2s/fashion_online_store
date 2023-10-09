<?php
	// URL                             
	$myserverpath = explode ( "/", $_SERVER['PHP_SELF'] );
	if ( $myserverpath[1] <> 'admin' ) 
	{
			$serverpath = '/' . $myserverpath[1];    
	}
	else
	{
			$serverpath = '';
	}
	
	if((!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || $_SERVER['SERVER_PORT'] == 443)
	{
			$myserverprotocol = "https";
	}
	else
	{
			$myserverprotocol = "http";    
	}
	
	$myservername = $_SERVER['SERVER_NAME'] . $serverpath;	
?>

<script type="text/javascript">

$(document).ready(function() {

$( "#doku_submit" ).click(function() {
    $.post( "<?php echo $myserverprotocol ?>://<?php echo $myservername ?>/index.php?route=payment/doku_onecheckout/processdoku", { TRANSIDMERCHANT: "<?php echo $oco_transidmerchant; ?>" }, function( data ) {
        document.doku_form.submit();
    });
});

});

</script>

<form id="doku_form" name="doku_form" action="<?php echo $oco_action; ?>" method="post">
  <input type=hidden name="MALLID" value="<?php echo $oco_mallid  ;?>">
  <input type=hidden name="CHAINMERCHANT" value="<?php echo $oco_chain  ;?>">
  <input type=hidden name="AMOUNT" value="<?php echo $oco_amount  ;?>">
  <input type=hidden name="PURCHASEAMOUNT" value="<?php echo $oco_amount  ;?>">
  <input type=hidden name="TRANSIDMERCHANT" value="<?php echo $oco_transidmerchant ;?>">
  <input type=hidden name="WORDS" value="<?php echo $oco_words ;?>">
  <input type=hidden name="REQUESTDATETIME" value="<?php echo $oco_request_datetime ;?>">
  <input type=hidden name="CURRENCY" value="<?php echo $oco_currency ;?>">
  <input type=hidden name="PURCHASECURRENCY" value="<?php echo $oco_currency ;?>">
  <input type=hidden name="SESSIONID" value="<?php echo $oco_session_id ;?>">
  <input type=hidden name="NAME" value="<?php echo $oco_allname ;?>">
  <input type=hidden name="EMAIL" value="<?php echo $email ;?>">
  <input type=hidden name="HOMEPHONE" value="<?php echo $telephone ;?>">
	<input type=hidden name="WORKPHONE" value="<?php echo $telephone ;?>">
  <input type=hidden name="MOBILEPHONE" value="<?php echo $telephone ;?>">
  <input type=hidden name="BASKET" value="<?php echo $data_product  ;?>">
  <input type=hidden name="ADDRESS" value="<?php echo $oco_address_1 . " " . $oco_address_2 ;?>">
  <input type=hidden name="CITY" value="<?php echo $oco_city  ;?>">
  <input type=hidden name="STATE" value="<?php echo $oco_zone  ;?>">
  <input type=hidden name="ZIPCODE" value="<?php echo $oco_postcode  ;?>">

  <div class="buttons">
	<?php

	if ($payment_select==0)
	{
	?>
	    <input type=hidden name="PAYMENTCHANNEL" value="">
	<?php
	}
	else
	{
		
	    echo "<ul>";
            echo $select_payment;
            $n=1;
	    foreach ($payment_list as $key=>$data)
	    {
			if ( $n==1 )
			{
				$flag = "checked";
			}
			else
			{
				$flag = "";
			}

			if(!empty($data)) {
	?>
          <li><input type="radio" name="PAYMENTCHANNEL" value="<?php echo $data ?>" <?php echo $flag ?>> <?php echo $payment_name[$key] ?></li>
	<?php
			}
          $n++;
	    }
	    echo "</ul>";    
	}	
	?>
	
  </div>
  
	<div class="buttons">
		<div class="pull-right">
        <input type="button" id="doku_submit" value="<?php echo $button_confirm; ?>" class="btn btn-primary" />
    </div>
  </div>
</form>