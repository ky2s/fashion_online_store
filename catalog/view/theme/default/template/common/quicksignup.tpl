<div id="modal-quicksignup" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>				
			</div>
			
			<div class="modal-body">
				<div class="row">

					<!-- Cek email -->
					<div class="col-sm-12" id="form-check-login">
						<div class="head">							
							<h3 class="modal-title"><?php echo $text_wellcome ?>!</h3>
							<p>Please enter your email address.</p>
						</div>
						
						<div class="form-group hidden ">
							<?php foreach ($customer_groups as $customer_group) { ?>
					              <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
					              <div class="radio">
					                <label>
					                  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
					                  <?php echo $customer_group['name']; ?></label>
					              </div>
					              <?php } else { ?>
					              <div class="radio">
					                <label>
					                  <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
					                  <?php echo $customer_group['name']; ?></label>
					              </div>
					              <?php } ?>
			              	<?php } ?>
						</div>

						<div class="form-group required">
							<label class="" for="login-input-email"><?php echo $entry_email; ?></label>
							<input type="text" name="email" class="form-control" id="input-check-email" />
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-primary btn-modal check-login"  data-loading-text="<?php echo $text_loading; ?>"><?php echo $button_continue ?></button>
							<div class="group-sosmed">								
								<p class="text-center font-sonus">Or continue with</p>
								<?php if($provider){
									foreach($provider as $p){
										if($p['provider'] != 'Twitter'){?>
										<a href="javascript:;" onclick="window.open('<?php echo $store_url . 'index.php?route=hybrid/auth&source=product-review&provider=' . $p['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>', 'newwindow', 'width=700, height=450,top=200, left=600'); ">
											<h4 class="sosmed <?php echo $p['provider'];?>"><i class="fa fa-<?php echo strtolower($p['provider']);?>-official" aria-hidden="true"></i><?php echo $p['provider'];?></h4>
										</a>
										<?php }?>
									<?php }?>
								<?php }?>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-6">								
								<a href="javascript:;" class="forgot-password hidden"><?php echo $text_forgotten; ?></a>
							</div>
							<div class="col-sm-6 text-right">
								<a href="javascript:;" class="to-login hidden">Log in with an existing account</a>
							</div>
						</div>
					</div>

					<!-- Register -->				
					<div class="col-sm-12 hidden " id="quick-register">
						<div class="head">							
							<h3 class="modal-title">Looks like you’re new.</h3>
							<p>Please create an account.</p>
						</div>
						<div class="form-group required">
							<label class="" for="input-name"><?php echo $entry_name; ?></label>
							<input type="text" name="name" value="" id="input-name" class="form-control" />
						</div>
						<div class="form-group required">
							<label class="" for="input-email"><?php echo $entry_email; ?></label>
							<input type="text" name="email" value="" id="register-input-email" class="form-control" />
						</div>
						<div class="form-group required">
							<label class="" for="input-password"><?php echo $entry_password; ?></label>
							<input type="password" name="password" value="" id="input-password" class="form-control" />
						</div>

						<?php foreach ($custom_fields as $custom_field) { ?>
					          <?php if ($custom_field['location'] == 'account') { ?>

					          <?php if ($custom_field['type'] == 'select') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
					                <option value=""><?php echo $text_select; ?></option>
					                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
						                <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
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
									<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field required" data-sort="<?php echo $custom_field['sort_order']; ?>">
										<?php foreach ($custom_field['custom_field_value'] as $key => $custom_field_value) { ?>											
							                <label class="radio-inline" for="input-gender<?php echo $key;?>">
										      	<input type="radio"  id="input-gender<?php echo $key;?>" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" >
										      	<?php echo $custom_field_value['name']; ?>
										    </label>					                  		
									    <?php } ?>

									    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
						              		<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
							            <?php } ?>
									</div>
					          <?php } ?>

					          <?php if ($custom_field['type'] == 'checkbox') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <div>
					                <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
					                <div class="checkbox">
					                  <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
					                  <label>
					                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
					                    <?php echo $custom_field_value['name']; ?></label>
					                  <?php } else { ?>
					                  <label>
					                    <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
					                    <?php echo $custom_field_value['name']; ?></label>
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
					          	<div class="form-group custom-field<?php echo $custom_field['custom_field_id']; ?> required " data-sort="<?php echo $custom_field['sort_order']; ?>">
									<label class="control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					              	<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
					              	
					              	<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              		<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              	<?php } ?>
								</div>
					          <?php } ?>

					          <?php if ($custom_field['type'] == 'textarea') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
					              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              <?php } ?>
					            </div>
					          </div>
					          <?php } ?>
					          <?php if ($custom_field['type'] == 'file') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
					              <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
					              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              <?php } ?>
					            </div>
					          </div>
					          <?php } ?>
					          <?php if ($custom_field['type'] == 'date') { ?>
					          	<div class="form-group custom-field<?php echo $custom_field['custom_field_id']; ?> required " data-sort="<?php echo $custom_field['sort_order']; ?>">
									<label class="" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					              	<input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control input-birth-date birth-date" />
					              	
					              	<?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              		<div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              	<?php } ?>
								</div>
					          <?php } ?>
					          <?php if ($custom_field['type'] == 'time') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <div class="input-group time">
					                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
					                <span class="input-group-btn">
					                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					                </span></div>
					              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              <?php } ?>
					            </div>
					          </div>
					          <?php } ?>
					          <?php if ($custom_field['type'] == 'datetime') { ?>
					          <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
					            <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
					            <div class="col-sm-10">
					              <div class="input-group datetime">
					                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
					                <span class="input-group-btn">
					                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					                </span></div>
					              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
					              <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
					              <?php } ?>
					            </div>
					          </div>
					          <?php } ?>
					          <?php } ?>
					          <?php } ?>
						
						<div class="form-group required hidden">
							<input type="radio" name="newsletter" value="1" checked="checked" />
						</div>

						<?php if ($text_agree) { ?>
						<div class="buttons">
							<div class="">
								<button type="button" class="btn btn-primary btn-modal black createaccount"  data-loading-text="<?php echo $text_loading; ?>" ><?php echo $button_continue; ?></button>
								<a href="javascript:;" class="btn back-btn btn-modal black">Back</a>
							</div>
						</div>
						<?php }else{ ?>
						<div class="buttons">
							<div class="">								
								<button type="button" class="btn btn-primary btn-modal black createaccount" data-loading-text="<?php echo $text_loading; ?>" ><?php echo $button_continue; ?></button>
								<a href="javascript:;" class="btn back-btn btn-modal black">Back</a>
							</div>
						</div>
						<?php } ?>
						<div class="form-group">
							<ul class="quest-modal">
								<li><a href="javascript:;" class="to-login">Log in with an existing account</a></li>
							</ul>							
						</div>
					</div>

					<!-- Login -->				
					<div class="col-sm-12 hidden" id="quick-login">
						<div class="head">							
							<h3 class="modal-title"><?php echo $text_wellcome ?>!</h3>
							<p><?php echo $text_returning_customer ?></p>
						</div>
						
						<div class="form-group required">
							<label class="" for="input-email"><?php echo $entry_email; ?></label>
							<input type="text" name="email" value=""  id="login-input-email" class="form-control" />
						</div>
						<div class="form-group required">
							<label class="" for="input-password"><?php echo $entry_password; ?></label>
							<input type="password" name="password" value="" id="input-password" class="form-control" />
						</div>
						<div class="form-group">							
							<button type="button" class="btn btn-primary loginaccount btn-modal black"  data-loading-text="<?php echo $text_loading; ?>"><?php echo $button_continue ?></button>
							<a href="javascript:;" class="btn back-btn btn-modal black">Back</a>
							<div class="group-sosmed">								
								<p class="text-center font-sonus">Or continue with</p>
								<?php if($provider){ 
									foreach($provider as $p){
										if($p['provider'] != 'Twitter'){?>
											<a href="<?php echo HTTPS_SERVER . 'index.php?route=hybrid/auth&provider=' . $p['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>" onclick="window.open('<?php echo HTTPS_SERVER . 'index.php?route=hybrid/auth&source=product-review&provider=' . $p['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>', 'newwindow', 'width=700, height=450,top=200, left=600'); return false;">
												<h4 class="sosmed <?php echo $p['provider'];?>"><?php echo $p['provider'];?></h4>
											</a>
										<?php }?>
									<?php }?>
								<?php }?>
							</div>
						</div>
						<div class="form-group">
							<ul class="quest-modal">
								<li><a href="javascript:;" class="to-register">New To Roepistore?</a></li>
								<li><a href="javascript:;" class="forgot-password">Reset Password</a></li>
							</ul>							
						</div>
					</div>

					<!-- Forgot password -->
					<div class="col-sm-12 hidden" id="form-forgot">
						<div class="head">							
							<h3 class="modal-title">Forgot your password?</h3>
							<p><?= $text_forgotten_email ?></p>
						</div>
						
						<div class="form-group required">
							<label class="" for="login-input-email"><?php echo $entry_email; ?></label>
							<input type="text" name="email" class="form-control" id="input-forgot-email" />
						</div>

						<div class="form-group">
							<button type="button" class="btn btn-primary reset-password btn-modal black btn">Reset Password</button>
							<a href="javascript:;" class="btn back-btn btn-modal black btn">Back</a>
						</div>

						<div class="form-group">
							<ul class="quest-modal">
								<li><a href="javascript:;" class="to-login">Log in with an existing account</a></li>								
							</ul>
							
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>



    
<style>
	.quick_signup{
		cursor:pointer;
	}
	#modal-quicksignup .form-control{
		height:auto;
	}
</style>

<script type="text/javascript">

$('.to-register').click(function(){
	$('#form-forgot').addClass('hidden');
	$('#form-check-login').addClass('hidden');
	$('#quick-login').addClass('hidden');
  	$('#quick-register').removeClass('hidden');
  	$('.modal-footer').addClass('hidden');

  	$('#quick-register #input-name').focus();

  	// $('.modal-header button').addClass('black');
});

$('.to-login').click(function(){
	$('#form-forgot').addClass('hidden');
	$('#form-check-login').addClass('hidden');
	$('#quick-login').removeClass('hidden');
  	$('#quick-register').addClass('hidden');
  	$('.modal-footer').addClass('hidden');

  	
  	$('#quick-login #input-password').focus();
  	
  	// $('.modal-header button').addClass('black');
});

$('.forgot-password').click(function(){
	$('#form-forgot').removeClass('hidden');
	$('#form-check-login').addClass('hidden');
	$('#quick-login').addClass('hidden');
  	$('#quick-register').addClass('hidden');
  	$('.modal-footer').removeClass('hidden');
  	$('#form-forgot #input-forgot-email').val($('#form-check-login #input-check-email').val());

  	$('#form-forgot #input-forgot-email').focus();

  	// $('.modal-header button').addClass('black');
});

$('.back-btn').click(function(){
	$('#form-check-login').removeClass('hidden');
	$('#form-forgot').addClass('hidden');
	$('#quick-login').addClass('hidden');
  	$('#quick-register').addClass('hidden');
  	$('.modal-footer').removeClass('hidden');
  	$('#modal-quicksignup .alert').remove();
  	// $('.modal-header button').removeClass('black');
});

$(document).delegate('.quick_signup', 'click', function(e) {
	$('#form-check-login').removeClass('hidden');
	$('#form-forgot').addClass('hidden');
	$('#quick-login').addClass('hidden');
  	$('#quick-register').addClass('hidden');
  	$('.modal-footer').removeClass('hidden');
	
	$('#modal-quicksignup').fadeIn("normal").modal();

	//added by Wian
	$('#center-other-page, #center-content, header, footer, #wrap-banner, #wr-content').addClass('blur');
	$('#form-check-login #input-check-email').focus();
	// $('.modal-backdrop').addClass('modal-login-regis');
	// $('body.modal-open').addClass('modal-body-login-regis');
});

$('#quick-register input').on('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#quick-register .createaccount').trigger('click');
	}
});


$('#form-check-login input').on('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#form-check-login .check-login').trigger('click');
	}
});

$('#quick-login input').on('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#quick-login .loginaccount').trigger('click');
	}
});


/*When click modal in outside*/
$('#modal-quicksignup').on('hidden.bs.modal', function () {
  	$('#form-check-login').removeClass('hidden');
  	$('#quick-login').addClass('hidden');
  	$('#quick-register').addClass('hidden');
  	$('#center-other-page, #center-content, header, footer, #wrap-banner, #wr-content').removeClass('blur');
  	$('#modal-quicksignup .alert-danger').remove();
});

//forgot passsword
$('.reset-password').click(function() {
	$.ajax({
		url: 'index.php?route=common/quicksignup/forgot_password',
		type: 'post',
		data: $('#form-forgot input[type=\'text\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#form-forgot .reset-password').button('loading');
			$('#modal-quicksignup .alert-danger').remove();
		},
		success: function(json) {
			$('#modal-quicksignup .form-group').removeClass('has-error');
			
			if (json['error_email']) {
				$('#form-forgot #input-forgot-email').parent().addClass('has-error');
				$('#form-forgot #input-forgot-email').focus();
			}

			if (json['error_email']) {
				$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error_email'] + '</div>');
			}
			
			if (json['success']) {
				$('#modal-quicksignup .alert-danger').remove();
				$('#modal-quicksignup .modal-header').after('<div class="alert alert-success" style="margin:5px;"><i class="fa fa-check-circle"></i> ' + json['text_message'] + '</div>');
			}

			if (json['error']) {
				$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}
		},
		complete: function() {
			$('#form-forgot .reset-password').button('reset');
		},
	});
});

//REGISTER
$('#quick-register .createaccount').click(function() {
	$.ajax({
		url: 'index.php?route=common/quicksignup/register',
		type: 'post',
		data: $('#quick-register input[type=\'text\'], #quick-register input[type=\'password\'], #quick-register input[type=\'checkbox\']:checked, #quick-register input[type=\'radio\']:checked'),
		dataType: 'json',
		beforeSend: function() {
			$('#quick-register .createaccount').button('loading');
			$('#modal-quicksignup .alert-danger').remove();
		},
		complete: function() {
			$('#quick-register .createaccount').button('reset');
		},
		success: function(json) {
			
			$('#modal-quicksignup .form-group').removeClass('has-error');
			
			if(json['islogged'] || json['now_login']){
				 window.location.href="<?php echo $store_url; ?>";
			}

			if (json['error_name']) {
				$('#quick-register #input-name').parent().addClass('has-error');
				$('#quick-register #input-name').focus();
			}
			if (json['error_email']) {
				$('#quick-register #input-email').parent().addClass('has-error');
				$('#quick-register #input-email').focus();
			}
			if (json['error_password']) {
				$('#quick-register #input-password').parent().addClass('has-error');
				$('#quick-register #input-password').focus();
			}
			
			if (json['error']) {
				$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}else
			//CUSTOM FIELD ERROR
			if (json['custom_field_error']) {
				obj = json['custom_field_error'];
				


				if( (obj[1] != null && obj[2] != null) ){
					$('.birth-date').parent().addClass('has-error');
					$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i>Date of birth can\'t be blank</div>');
				} else
				if(obj[1] == null && obj[2] != null){
					// $('.alert-all').remove();
					$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger alert-gender" style="margin:5px;"><i class="fa fa-exclamation-circle"></i>Please select gender</div>');
				}else
				if(obj[1] != null && obj[2] ==  null){
					$('.birth-date').parent().addClass('has-error');
					$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i>Date of birth can\'t be blank</div>');
				}				
			}
			
			if (json['now_login']) {
				window.location.href="<?php echo $store_url; ?>";
			}

			if (json['success']) {
				loacation();
				$('#modal-quicksignup').modal('hide');
			}
		}
	});
});

//ChECK EMAIL
$('#form-check-login .check-login').click(function() {
	$.ajax({
		url: 'index.php?route=common/quicksignup/check_login',
		type: 'post',
		data: $('#form-check-login input[type=\'text\']'),
		dataType: 'json',
		beforeSend: function() {
			$('#form-check-login .loginaccount').button('loading');
			$('#modal-quicksignup .alert-danger').remove();
		},
		complete: function() {
			$('#form-check-login .loginaccount').button('reset');	
		},
		success: function(json) {
			
			$('#modal-quicksignup .form-group').removeClass('has-error');


			
			if(json.data){

				if(json['islogged'])
				{
					 if(json['store_url']){
					 	window.location.href=json['store_url'];
					 }else{
					 	window.location.href="index.php?route=account/edit";
					 }
				}else if(json['success'])
				{			
					var email = json.data.email;			
					//show form login
					$('#quick-login').removeClass('hidden');
					$('#form-check-login').addClass('hidden');
					$('#login-input-email').val(email);
					$('.modal-footer').addClass('hidden');
					$('#quick-login #input-password').focus();

					// $('.modal-header button').addClass('black');
				}

				if (json['error']) 
				{
					var email = json.data;
					//show form register
					$('#quick-register').removeClass('hidden');
					$('#form-check-login').addClass('hidden');
					$('#register-input-email').val(email);
					$('.modal-footer').removeClass('hidden');
					$('#quick-register #input-name').focus();
				}
			}
			else{
				if (json['error']) 
				{
					var email = json.data;
					$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
					$('#quick-login #input-password').parent().addClass('has-error');
				}
				$('#input-check-email').parent().addClass('has-error');
				$('#input-check-email').focus();	
			}
		}
	});
});

//LOGIN
$('#quick-login .loginaccount').click(function() {
	$.ajax({
		url: 'index.php?route=common/quicksignup/login',
		type: 'post',
		data: $('#quick-login input[type=\'text\'], #quick-login input[type=\'password\'],#payment-confirmation-red'),
		dataType: 'json',
		beforeSend: function() {
			$('#quick-login .loginaccount').button('loading');
			$('#modal-quicksignup .alert-danger').remove();
		},
		complete: function() {
			$('#quick-login .loginaccount').button('reset');
		},
		success: function(json) {
			//console.log(json);return false;
			$('#modal-quicksignup .form-group').removeClass('has-error');

			if(json['islogged']){
				if(json['redirect']!=""){
					window.location.href=json['redirect'];
				}else{
					 if(json['store_url']){
					 	window.location.href=json['store_url'];
					 }else{
					 	window.location.href="index.php?route=account/edit";
					 }
				}
			}else if(json['success']){
				loacation();
				$('#modal-quicksignup').modal('hide');
			}	
			
			if (json['error']) {
				$('#modal-quicksignup .modal-header').after('<div class="alert alert-danger" style="margin:5px;"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
				$('#quick-login #input-email').parent().addClass('has-error');
				$('#quick-login #input-password').parent().addClass('has-error');
				$('#quick-login #input-email').focus();
			}

		
		}
	});
});

function loacation() {
	location.reload();
}
</script>