<form class="form-horizontal">
    <?php if ($addresses) { ?>
    <div class="radio">
        <label>
            <input type="radio" name="payment_address" value="existing" checked="checked" />
        <?php echo $text_address_existing; ?></label>
    </div>
    <div id="payment-existing">
        <select name="address_id" class="form-control">
            <?php foreach ($addresses as $address) { ?>
            <?php if ($address['address_id'] == $address_id) { ?>
            <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
            <?php } ?>
            <?php } ?>
        </select>
    </div>
    <div class="radio">
        <label>
            <input type="radio" name="payment_address" value="new" />
        <?php echo $text_address_new; ?></label>
    </div>
    <?php } ?>
    <br />
    <div id="payment-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
        <div class="row">
            <div class="col-sm-12">
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-fullname">Fullname</label>
                        <input type="text" name="name" value="" placeholder="Fullname" id="input-payment-name" class="form-control" />
                    </div>
                </div>
            </div>
        </div>        
        
        <input type="hidden" name="company" value="" placeholder="<?php echo $entry_company; ?>" id="input-payment-company" class="form-control" />
        <div class="form-group required">
            <div class="col-sm-12">
                <label class="col-sm-12" for="input-payment-address-1"><?php echo $entry_address_1; ?></label>
                <textarea name="address_1" id="input-payment-address-1" placeholder="<?php echo $entry_address_1; ?>" cols="30" rows="4" class="form-control"></textarea>
            </div>
        </div>
        <input type="hidden" name="address_2" value="" placeholder="<?php echo $entry_address_2; ?>" id="input-payment-address-2" class="form-control" />

        <div class="row">
            <div class="col-sm-6">
                
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-country"><?php echo $entry_country; ?></label>
                        <select name="country_id" id="input-payment-country" class="form-control">
                            <option value=""><?php echo $text_select; ?></option>
                            <?php foreach ($countries as $country) { ?>
                            <?php if ($country['country_id'] == $country_id) { ?>
                            <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-zone"><?php echo $entry_zone; ?></label>
                        <select name="zone_id" id="input-payment-zone" class="form-control">
                        </select>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="row">
            <div class="col-sm-6">
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-city"><?php echo $entry_city; ?></label>
                        <select name="city" id="input-payment-city" class="form-control">
                            <option selected="selected" value=""><?php echo $text_none; ?></option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">                
                <div class="form-group required">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-postcode"><?php echo $entry_postcode; ?></label>
                        <input type="text" name="postcode" value="" placeholder="<?php echo $entry_postcode; ?>" id="input-payment-postcode" class="form-control" />
                    </div>
                </div>
            </div>
        </div>        
        
            <?php //data-sort=$custom_field['sort_order']; di setiap div form group di hilangkan sementara ?>
            <?php foreach ($custom_fields as $custom_field) { ?>
            <?php if ($custom_field['location'] == 'address') { ?>

            <?php if ($custom_field['type'] == 'select') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-sm-12">
                    <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'radio') { ?>            
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" >
                <div class="col-sm-12">
                    <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="radio-inline">
                            <label>
                                <input type="radio" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                <?php echo $custom_field_value['name']; ?></label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>            
            <?php } ?>

            <?php if ($custom_field['type'] == 'checkbox') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" >
                <div class="col-sm-12">
                    <label class="col-sm-12 "><?php echo $custom_field['name']; ?></label>
                    <div id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>">
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                            <?php echo $custom_field_value['name']; ?></label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'text') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" >
                <div class="col-sm-12">
                    <label class="col-sm-12 " for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                </div>
            </div> 
            <?php } ?>

            <?php if ($custom_field['type'] == 'textarea') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-sm-12">
                    <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <textarea name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo $custom_field['value']; ?></textarea>
                </div>
            </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'file') { ?>
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-sm-12">
                    <label class="col-sm-12"><?php echo $custom_field['name']; ?></label>
                    <button type="button" id="button-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                    <input type="hidden" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
                </div>
            </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'date') { ?>     
            <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" >
                <div class="col-sm-12">
                    <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control input-birth-date" />                        
                </div>
            </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'time') { ?>
                <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                <div class="col-sm-12">
                    <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="input-group time">
                        <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                    </div>
                </div>
            <?php } ?>

            <?php if ($custom_field['type'] == 'datetime') { ?>
                <div class="form-group<?php echo ($custom_field['required'] ? ' required' : ''); ?> custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <div class="col-sm-12">
                        <label class="col-sm-12" for="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                        <div class="input-group datetime">
                            <input type="text" name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field['value']; ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-payment-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                            <span class="input-group-btn">
                                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                            </span>
                        </div>
                    </div>
                    <?php } ?>
                    <?php } ?>
                    <?php } ?>
                </div>

                <div class="buttons clearfix">
                    <!-- <div class="pull-right"> -->                      

                        <input type="button" value="<?php echo $button_continue; ?>" id="button-payment-address" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />

                    <!-- </div> -->
                </div>
            </form>
        
    


<script type="text/javascript"><!--

//number only
$('input[name=\'postcode\']').numeric();

$('#collapse-payment-address select').selectpicker();
$('input[name=\'payment_address\']').on('change', function() {
	if (this.value == 'new') {
		$('#payment-existing').hide();
		$('#payment-new').show();
	} else {
		$('#payment-existing').show();
		$('#payment-new').hide();
	}
});
//--></script>
<script type="text/javascript"><!--
// Sort the custom fields
$('#collapse-payment-address .form-group[data-sort]').detach().each(function() {
	if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#collapse-payment-address .form-group').length) {
		$('#collapse-payment-address .form-group').eq($(this).attr('data-sort')).before(this);
	} 
	
	if ($(this).attr('data-sort') > $('#collapse-payment-address .form-group').length) {
		$('#collapse-payment-address .form-group:last').after(this);
	}
		
	if ($(this).attr('data-sort') < -$('#collapse-payment-address .form-group').length) {
		$('#collapse-payment-address .form-group:first').before(this);
	}
});
//--></script>
<script type="text/javascript"><!--
$('#collapse-payment-address button[id^=\'button-payment-custom-field\']').on('click', function() {
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
					$(node).parent().find('.text-danger').remove();;
					
					if (json['error']) {
						$(node).parent().find('input[name^=\'custom_field\']').after('<div class="text-danger">' + json['error'] + '</div>');
					}
	
					if (json['success']) {
						//alert(json['success']);
	
						$(node).parent().find('input[name^=\'custom_field\']').attr('value', json['code']);
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

$('.time').datetimepicker({
	pickDate: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});
//--></script>
<script type="text/javascript"><!--
$('#collapse-payment-address select[name=\'country_id\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#collapse-payment-address select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			$('.fa-spin').remove();

			if (json['postcode_required'] == '1') {
				$('#collapse-payment-address input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('#collapse-payment-address input[name=\'postcode\']').parent().parent().removeClass('required');
			}

			html = '<option value=""><?php echo $text_select; ?></option>';

			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';

					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
					}

					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}

			$('#collapse-payment-address select[name=\'zone_id\']').html(html);
      $('#collapse-payment-address select[name=\'zone_id\']').selectpicker("refresh");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$(document).on('change', '#collapse-payment-address select[name=\'zone_id\']', function() {
  
  $.ajax({
    url: 'index.php?route=account/register/city&zone_id=' + this.value,   
    beforeSend: function() {
      $('select[name=\'zone_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
    },
    complete: function() {
      $('.fa-spin').remove();
    },
    success: function(json) {
          $('.fa-spin').remove();
      $('select[name=\'city\']').html(json);
      $('select[name=\'city\']').selectpicker("refresh");
    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('#collapse-payment-address select[name=\'country_id\']').trigger('change');
//--></script>