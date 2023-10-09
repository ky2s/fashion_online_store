<div class="wrapHelper">
<?php echo $text_welcome; ?>
</div>

<div class="optionWrap">
<?php foreach ($wrapping_options as $keyOption => $option) { ?>       
  <?php if($id){ ?>
    <label class="labelOption <?php echo ($option['id'] == $id) ? 'active':''; ?>">
      <input type="radio" data-price="<?php echo $option['price']; ?>" name="radioOption" value="<?php echo $option['id']; ?>" <?php echo ($option['id'] == $id) ? 'checked="checked"':''; ?>>
      <img data-large="<?php echo $option['largeImage']; ?>" src="<?php echo $option['image']; ?>" alt="<?php echo $option['name']; ?>" />
      <div class="desc">
        <span class="title"><?php echo $option['name']; ?></span>
        <span class="price"><?php echo $option['price_label']; ?></span>
      </div>
    </label>
  <?php } else { ?>
    <label class="labelOption <?php echo ($keyOption == 0) ? 'active':''; ?>">
      <input type="radio" data-price="<?php echo $option['price']; ?>" name="radioOption" value="<?php echo $option['id']; ?>" <?php echo ($keyOption == 0) ? 'checked="checked"':''; ?>>
      <img data-large="<?php echo $option['largeImage']; ?>" src="<?php echo $option['image']; ?>" alt="<?php echo $option['name']; ?>" />
      <div class="desc">
        <span class="title"><?php echo $option['name']; ?></span>
        <span class="price"><?php echo $option['price_label']; ?></span>
      </div>
    </label>
  <?php } ?>  
<?php } ?>
</div>

<div class="preview text-center gift"></div>

<p><strong><?php echo $entry_comment; ?></strong></p>
<p>
  <textarea name="comment" rows="8" class="form-control"><?php echo $comment; ?></textarea>
</p>
<div class="buttons">
  <div class="pull-right">
    <input type="button" value="<?php echo $button_continue; ?>" id="button-gift-card" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary" />
  </div>
</div>
<script>
  $(document).ready(function() {

    var evt = 'ontouchend' in document ? 'touchend' : 'click';
  	
  	var largeImg = '';
  	var judul = '';
  	var harga = '';
  	if( $('#collapse-gift-card .labelOption').hasClass('active') )
  	{
  		var largeImg = $('#collapse-gift-card .labelOption.active').find('img').data('large'); 
  		var judul = $('#collapse-gift-card .labelOption.active').find('span.title').html();
  		var harga = $('#collapse-gift-card .labelOption.active').find('span.price').html();
  		$('#collapse-gift-card .preview').html('<h4>'+ judul +'</h4><img src="'+largeImg+'"><div>'+ harga +'</div>');
  	}
    /*
    $(document).off(evt, '.labelOption input[type="radio"]').on(evt, '.labelOption input[type="radio"]', function(e){

      if($(this).parent().hasClass('active')) {
        $(this).prop('checked', false);
        $(this).parent().removeClass('active');
      } else {
        $(this).parents('.optionWrap').find('.labelOption').removeClass('active');
        $(this).parent().addClass('active');
        var largeImg = $(this).parent().find('img').data('large'); 
        var judul = $(this).parent().find('span.title').html();
		var harga = $(this).parent().find('span.price').html();
        $('#collapse-gift-card .preview').html('<h4>'+ judul +'</h4><img src="'+largeImg+'"><div>'+ harga +'</div>');
      }
    }); */

    var i = 0;

    $(document).off(evt, '.labelOption').on(evt, '.labelOption', function(e){
      i++;
      if(i>1) {
        i = 0;
        return;
      }
      if($(this).hasClass('active')) {
        $(this).find('input[type="radio"]').prop('checked', false);
        $(this).removeClass('active');
      } else {
        $(this).parents('.optionWrap').find('.labelOption').removeClass('active');
        $(this).addClass('active');        
        var largeImg = $(this).find('img').data('large'); 
        var judul = $(this).find('span.title').html();
        var harga = $(this).find('span.price').html();
        $('#collapse-gift-card .preview').html('<h4>'+ judul +'</h4><img src="'+largeImg+'"><div>'+ harga +'</div>');
      }
      
    });
  });
</script>