<h3 class="heading"><?php echo $heading_title; ?></h3>
<div class="row">
  <?php foreach ($codes as $key => $code) { ?>
  	<div class="col-md-2 col-sm-3">
  		<a href="<?php echo $code['link']; ?>">
			<img src="<?php echo $code['src']; ?>" alt="<?php echo $heading_title; ?>">
  		</a>
  		<p><?php echo $code['title']; ?></p>
  	</div>
  <?php } ?>    
</div>
