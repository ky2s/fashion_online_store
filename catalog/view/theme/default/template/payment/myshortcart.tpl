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

<form id="msc_form" action="<?php echo $msc_action; ?>" method="post">
  <input type=hidden name="BASKET" value="<?php echo $data_product; ?>">
  <input type=hidden name="STOREID" value="<?php echo $msc_storeid; ?>">
  <input type=hidden name="TRANSIDMERCHANT" value="<?php echo $msc_transidmerchant; ?>">
  <input type=hidden name="AMOUNT" value="<?php echo $msc_amount; ?>">
  <input type=hidden name="URL" value="<?php echo $myserverprotocol . "://" . $myservername; ?>">
  <input type=hidden name="WORDS" value="<?php echo $msc_words; ?>">
  <input type=hidden name="CNAME" value="<?php echo $msc_allname; ?>">
  <input type=hidden name="CEMAIL" value="<?php echo $email; ?>">
  <input type=hidden name="CWPHONE" value="<?php echo $telephone; ?>">
  <input type=hidden name="CHPHONE" value="<?php echo $telephone; ?>">
  <input type=hidden name="CMPHONE" value="<?php echo $telephone; ?>">
  <input type=hidden name="CCAPHONE" value="<?php echo $telephone; ?>">
  <input type=hidden name="CADDRESS" value="<?php echo $msc_address_1 . " " . $msc_address_2; ?>">
  <input type=hidden name="CZIPCODE" value="<?php echo $msc_postcode; ?>">
  <input type=hidden name="CCITY" value="<?php echo $msc_city; ?>">
  <input type=hidden name="CSTATE" value="<?php echo $msc_zone; ?>">
  <input type=hidden name="CCOUNTRY" value="360">
  <input type=hidden name="CZIPCODE" value="<?php echo $msc_postcode ; ?>">
  <input type=hidden name="SADDRESS" value="<?php echo $msc_address_1 . " " . $msc_address_2; ?>">
  <input type=hidden name="SZIPCODE" value="<?php echo $msc_postcode; ?>">
  <input type=hidden name="SCITY" value="<?php echo $msc_city; ?>">
  <input type=hidden name="SSTATE" value="<?php echo $msc_zone; ?>">
  <input type=hidden name="SCOUNTRY" value="360">
  <input type=hidden name="BIRTHDATE" value="">

<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary" />
  </div>
</div>
</div>

<script type="text/javascript">

$( "#button-confirm" ).click(function() {

    $.post( "<?php echo $myserverprotocol ?>://<?php echo $myservername ?>/index.php?route=payment/myshortcart/myprocess", { TRANSIDMERCHANT: "<?php echo $transidmerchant; ?>" }, function( data ) {
        $("#msc_form").submit();
    });
});

</script>