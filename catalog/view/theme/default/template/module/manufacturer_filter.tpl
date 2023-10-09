<?php if($manufacturers) { ?>
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
<div class="list-group">
	<?php foreach ($manufacturers as $manufacturer) { ?>
	<div class="list-group-item">
		<label class="checkbox">
			<input id="<?php echo $manufacturer['id']; ?>" class="manufacturerGroup" type="checkbox" name="manufacturer[]" value="<?php echo $manufacturer['id']; ?>" <?php echo ($manufacturersSession && in_array($manufacturer['id'] , $manufacturersSession)) ? "checked" : ""; ?> >
			<?php echo $manufacturer['name'].'&nbsp;('.$manufacturer['count'].')'; ?>
		</label>
	</div>
	<?php } ?>
</div>
</div>

	
<script>
	var target;
  	$(function() {  		
  		var queryString = window.location.search;

    	if (queryString.indexOf("route") != -1) {
	    	target='index.php?route=product/category&path='+'<?php if(isset($_GET['path'])){ echo $_GET['path']; }?>';
	    } else {
	    	target='<?php echo curPageURL();?>';
	    }
	    
		$('input[type="checkbox"].manufacturerGroup').on('change', function(event){			
	  		var values = $('input:checkbox:checked.manufacturerGroup').map(function () {
			  return this.value;
			}).get();
			var valueAttributes = $('input:checkbox:checked.attributeGroup').map(function () {
			  return this.value;
			}).get();			
	  		$.ajax({
				url: target,
				dataType:'html',
				type: 'get',
				data:{ manufacturers:values, lower: $('[name="hiddenMin"]').val(), higher: $('[name="hiddenMax"]').val()},
				success: function(html) {
					location.reload();					
				}                                
		   	});					  	
		});
	});
</script>
<?php } ?>