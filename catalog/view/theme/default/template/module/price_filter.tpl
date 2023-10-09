<?php if(isset($lowestPrice)) { ?>
<?php
if (!function_exists('curPageURL')) {
function curPageURL() {
$pageURL = 'http';
if (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') {$pageURL .= "s";}
$pageURL .= "://";
if ($_SERVER["SERVER_PORT"] != "80") {
$pageURL .= $_SERVER["SERVER_NAME"].":".$_SERVER["SERVER_PORT"].$_SERVER["REQUEST_URI"];
} else {
$pageURL .= $_SERVER["SERVER_NAME"].$_SERVER["REQUEST_URI"];
}
return $pageURL;
}
}
?>

<div class="panel panel-default">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="list-group priceFilter">
  <div class="list-group-item">
    <div class="sliderContainer">
      <div class="slider"></div>
    </div>
    <div class="row">
      <div class="col-sm-6"><input id="startPrice" name="start" class="range" type="text" readonly></div>
      <div class="col-sm-6"><input id="endPrice" name="end" class="range" type="text" readonly></div>
    </div>
    <button type="button" id="btnsubmitHarga" class="btn btn-block btn-primary">Submit</button>
    <input type="hidden" name="hiddenMax" value="<?php echo $datahighercategory; ?>" />
    <input type="hidden" name="hiddenMin" value="<?php echo $datalowercategory; ?>" />
  </div>
</div>
</div>



<script>
  var queryString = window.location.search;
  var target;
  if  (queryString.indexOf("route") != -1) {
    target='index.php?route=product/category&path='+'<?php if(isset($_GET['path'])){ echo $_GET['path']; }?>';
  } else {
    target='<?php echo curPageURL();?>';
  } 
  $('.slider').noUiSlider({
      start: [<?php echo $datalower; ?>, <?php echo $datahigher; ?>],
      step: 1000,
      connect: true,
      range: {
          'min': 0,
          'max': <?php echo $datahighercategory; ?>
      },
      format: wNumb({
          decimals: 3,
          thousand: '.',
          prefix: '<?php echo $currencySymbol;?> ',
      })
  });
  $('.slider').Link('lower').to($('#startPrice'));

  $('.slider').Link('upper').to($('#endPrice'));

  $('#btnsubmitHarga').click(function(){
    var valueSlider = $(".slider").val();
    var lowerPrice = valueSlider[0].substr(3).replace(/\./g, "");    
    var higherPrice = valueSlider[1].substr(3).replace(/\./g, "");        
    var values = $('input:checkbox:checked.manufacturerGroup').map(function () {
      return this.value;
    }).get();
    $.ajax({
      url: target,
      dataType:'html',
      type: 'get',          
      data:{ manufacturers:values, lower:parseInt(lowerPrice), higher:parseInt(higherPrice)},
      success: function(html) {         
         location.reload();
      }                                
    });
  });
</script>
<?php } ?>