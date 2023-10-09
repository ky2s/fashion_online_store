<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>
            <div class="row">
                <div class="list-account col-xs-12 row">
                    <?php echo $column_left; ?>
                </div>
                <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9 col-xs-12'; ?>
                <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
                <?php } ?>
                <div id="content" class="<?php echo $class; ?>"> <?php echo $content_top; ?>
                    <!-- <h2 class="heading sp"><?php echo $text_edit_address; ?></h2> -->
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal form-style-2 no-padding">
                        <fieldset>
                            <legend><?php echo $text_edit_address; ?></legend>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-fullname">Fullname </label>
                                            <input type="text" name="name" value="<?php echo $name; ?>" placeholder="Fullname" id="input-fullname" class="form-control" />
                                            <?php if ($error_name) { ?>
                                                <div class="text-danger"><?php echo $error_name; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            

                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-address-1"><?php echo $entry_address_1; ?></label>
                                            <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address-1" class="form-control" />
                                            <?php if ($error_address_1) { ?>
                                            <div class="text-danger"><?php echo $error_address_1; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>  
                                </div>
                                    
                                <?php /*
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-address-2"><?php echo $entry_address_2; ?></label>
                                            <input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address-2" class="form-control" />
                                        </div>
                                    </div>
                                </div>
                                */?>
                            </div>
                            
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-country"><?php echo $entry_country; ?></label>
                                            <select name="country_id" id="input-country" class="form-control" data-live-search="true">
                                                <option value=""><?php echo $text_select; ?></option>
                                                <?php foreach ($countries as $country) { ?>
                                                <?php if ($country['country_id'] == $country_id) { ?>
                                                <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                            <?php if ($error_country) { ?>
                                            <div class="text-danger"><?php echo $error_country; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-zone"><?php echo $entry_zone; ?></label>
                                            <select name="zone_id" id="input-zone" class="form-control" data-live-search="true">
                                                <option value=""><?php echo $text_select; ?></option>
                                                <?php foreach ($zones as $zone) { ?>
                                                <?php if ($zone['zone_id'] == $zone_id) { ?>
                                                <option value="<?php echo $zone['zone_id']; ?>" selected="selected">
                                                    <?php echo $zone['name']; ?>
                                                </option>
                                                <?php } else { ?>
                                                <option value="<?php echo $zone['zone_id']; ?>">
                                                    <?php echo $zone['name']; ?>
                                                </option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                            <?php if ($error_zone) { ?>
                                            <div class="text-danger"><?php echo $error_zone; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">      
                                <div class="col-sm-6">
                                    <label class="col-sm-12" for="input-city"><?php echo $entry_city; ?></label>
                                    <select name="city" id="input-city" class="form-control" data-live-search="true">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($cities as $city) { ?>
                                        <?php if ($city['city_id'] == $city_id) { ?>
                                        <option value="<?php echo $city['city_id']; ?>" selected="selected"><?php echo $city['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $city['city_id']; ?>"><?php echo $city['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                    <?php if ($error_city) { ?>
                                    <div class="text-danger"><?php echo $error_city; ?></div>
                                    <?php } ?>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-postcode"><?php echo $entry_postcode; ?></label>
                                            <input type="text" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="form-control" />
                                            <?php if ($error_postcode) { ?>
                                            <div class="text-danger"><?php echo $error_postcode; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                                    
                            <?php foreach ($custom_fields as $custom_field) { ?>
                            <?php if ($custom_field['location'] == 'address') { ?>

                            <?php if ($custom_field['type'] == 'select') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                                        <option value=""><?php echo $text_select; ?></option>
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                        <?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
                                        <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>

                            <?php if ($custom_field['type'] == 'radio') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12"><?php echo $custom_field['name']; ?></label>
                                    <div>
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                        <div class="radio">
                                            <?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $address_custom_field[$custom_field['custom_field_id']]) { ?>
                                            <label>
                                                <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                <?php echo $custom_field_value['name']; ?>
                                            </label>
                                            <?php } else { ?>
                                            <label>
                                                <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                <?php echo $custom_field_value['name']; ?>
                                            </label>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    </div>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>

                            <?php if ($custom_field['type'] == 'checkbox') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12"><?php echo $custom_field['name']; ?></label>
                                    <div>
                                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                        <div class="checkbox">
                                            <?php if (isset($address_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $address_custom_field[$custom_field['custom_field_id']])) { ?>
                                            <label>
                                                <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                <?php echo $custom_field_value['name']; ?>
                                            </label>
                                            <?php } else { ?>
                                            <label>
                                                <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                <?php echo $custom_field_value['name']; ?>
                                            </label>
                                            <?php } ?>
                                        </div>
                                        <?php } ?>
                                    </div>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>

                            <?php if ($custom_field['type'] == 'text') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>

                            <?php if ($custom_field['type'] == 'textarea') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                                    <textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>

                            <?php if ($custom_field['type'] == 'file') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12"><?php echo $custom_field['name']; ?></label>
                                    <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                    <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            
                            <?php if ($custom_field['type'] == 'date') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?>
                                        
                                    </label>
                                    <div class="input-group date">
                                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'time') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?>
                                        
                                    </label>
                                    <div class="input-group time">
                                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if ($custom_field['type'] == 'datetime') { ?>
                            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                <div class="col-sm-12">
                                    <label class="col-sm-12" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?>
                                        
                                    </label>
                                    <div class="input-group datetime">
                                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                        <span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                        </span>
                                    </div>
                                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php } ?>
                            <?php } ?>
                            <div class="form-group col-sm-12">
                                <label class="col-sm-12"><?php echo $entry_default; ?></label>
                                <div class="col-sm-12">
                                    <?php if ($default) { ?>
                                    <label class="radio-inline">
                                        <input type="radio" name="default" value="1" checked="checked" />
                                        <?php echo $text_yes; ?>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="default" value="0" />
                                        <?php echo $text_no; ?>
                                    </label>
                                    <?php } else { ?>
                                    <label class="radio-inline">
                                        <input type="radio" name="default" value="1" />
                                        <?php echo $text_yes; ?>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="default" value="0" checked="checked" />
                                        <?php echo $text_no; ?>
                                    </label>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="buttons clearfix">
                                <!-- <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div> -->
                                <!-- <div class="pull-right"> -->
                                <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-grey btn-primary" />
                                <!-- </div> -->
                            </div>
                        </fieldset>
                    </form>
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript"><!--
// Sort the custom fields
$('.form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length) {
		$('.form-group').eq($(this).attr('data-sort')).before(this);
	} 
	
	if ($(this).attr('data-sort') > $('.form-group').length) {
		$('.form-group:last').after(this);
	}
		
	if ($(this).attr('data-sort') < -$('.form-group').length) {
		$('.form-group:first').before(this);
	}
});
//--></script>
<script>
$('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>
<script type="text/javascript"><!--
$('button[id^=\'button-custom-field\']').on('click', function() {
	var node = this;

	$('#form-upload').remove();

	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

	$('#form-upload input[name=\'file\']').trigger('click');

	timer = setInterval(function() {
		if ($('#form-upload input[name=\'file\']').val() != '') {
			clearInterval(timer);
		
			$.ajax({
				url: 'index.php?route=tool/upload',
				type: 'post',
				dataType: 'json',
				data: new FormData($('#form-upload')[0]),
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$(node).parent().find('.text-danger').remove();
					
					if (json['error']) {
						$(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
					}
	
					if (json['success']) {
						//alert(json['success']);
	
						$(node).parent().find('input').attr('value', json['code']);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	}, 500);
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});

$('.time').datetimepicker({
	pickDate: false
});
//--></script>
<script type="text/javascript"><!--
//$('select[name=\'country_id\']').trigger('change');
//$('select[name=\'zone_id\']').trigger('change');
//--></script>

<script type="text/javascript"><!-- 

$(document).ready(function() {
  $('[name=\'country_id\']').change(function() {
    $.post(
      'index.php?route=account/address/zone&country_id='+$('[name=\'country_id\']').val(),          
      { selType : this.id, dataType: 'html' },
      function(data)
        {
          console.log(data);
          $('select[name=\'zone_id\']').html(data);
          $('select[name=\'zone_id\']').selectpicker("refresh");
        }
      );
  });

  $('[name=\'zone_id\']').change(function() {
    $.post(
      'index.php?route=account/address/city&zone_id='+$('[name=\'zone_id\']').val(),
      { selType : this.id, dataType: 'html' },
      function(data)
        {
          console.log(data);
          $('select[name=\'city\']').html(data);
          $('select[name=\'city\']').selectpicker("refresh");
        }
      );
  });
});
//--></script>
<?php echo $footer; ?>
