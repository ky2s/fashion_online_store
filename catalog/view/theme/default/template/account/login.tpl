<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">

            <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
            <?php } ?>
            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
            <?php } ?>

            <div class="row">
                <?php $class = 'col-sm-12'; ?>
                
                <div id="content" class="<?php echo $class; ?> loginWrapper">
                    <?php echo $content_top; ?>
                    <div class="row">
                        
                            <!-- login -->
                            <div class="col-sm-6">
                                <div class="padding-r-40">
                                    <!-- <h2 class="heading"><?php //echo $text_returning_customer; ?></h2> -->
                                    <h2 class="heading">Log In</h2>
                                    <div class="wrapperAfterHeading">
                                        <!-- <p><strong><?php //echo $text_i_am_returning_customer; ?></strong></p> -->
                                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-style-2 no-padding">
                                            <div class="form-group">
                                                <!-- <label class="control-label" for="input-email"><?php echo $entry_email; ?></label> -->
                                                <input type="text" name="email_login" value="<?php echo $email_login; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <!-- <label class="control-label" for="input-password"><?php echo $entry_password; ?></label> -->
                                                <input type="password" name="password_login" value="" placeholder="<?php echo $entry_password; ?>" id="input-password-login" class="form-control" />
                                                <!-- <a href="<?php echo $forgotten; ?>" class="forgetPwd"><?php echo $text_forgotten; ?></a> -->
                                            </div>

                                            <div class="form-group">                                                
                                                <input name="submit" type="submit" value="<?php echo $button_login; ?>" class="btn btn-primary btn-grey display-block" />
                                            </div>

                                            <div class="form-group no-margin">
                                                <!-- <div class="col-sm-12"> -->
                                                    <p class="text-center no-margin">Login with:</p>
                                                <!-- </div> -->
                                            </div>

                                            <div class="form-group">                                                
                                                <!-- Popup Example -->
                                                <?php
                                                    $store_id = $configs->get('config_store_id');
                                                    $providers =  $configs->get('hybrid_auth') ;
                                                    foreach ($providers as $key => $provider) {
                                                        if($provider['store_id']!=$store_id){
                                                            unset($providers[$key]);
                                                        }
                                                    }


                                                    $store_url = $configs->get('config_url');
                                                    $hybrid_success = $data['store_url'].'index.php?route=hybrid/auth/success';
                                                ?>

                                                <?php if ($configs->get('hybrid_auth_status')) { ?>
                                                <div class="group-sosmed no-margin">
                                                    <?php foreach ($providers as $config) { ?>
                                                    <a onclick="window.open('<?php echo $store_url . 'index.php?route=hybrid/auth&source=product-review&provider=' . $config['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>', 'newwindow', 'width=700, height=450,top=200, left=600'); return false;" href="<?php echo $store_url . 'index.php?route=hybrid/auth&provider=' . $config['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>">
                                                        <h5 class="sosmed <?php echo $config['provider'];?>"><?php echo $config['provider'];?></h5>
                                                    </a>
                                                    <?php } ?>
                                                </div>
                                                <?php } ?>
                                            </div>
                                            

                                            <?php if ($redirect) { ?>
                                            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
                                            <?php } ?>
                                            
                                        </form>
                                    </div>
                                </div>
                            </div>


                            <!-- register -->
                            <div class="col-sm-6">
                                <div class="padding-l-40">
                                    <!-- <h1 class="heading"><?php echo $heading_title; ?></h1> -->
                                    <h2 class="heading">Sign Up</h2>
                                    <!-- <p><?php echo $text_account_already; ?></p> -->
                                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal form-style-2 no-padding">
                                        <fieldset id="account">
                                            
                                            <div class="row">
                                                <div class="col-sm-12">                                                    
                                                    <div class="form-group required">
                                                        <div class="col-sm-12">
                                                            <input type="text" name="name" value="<?php echo $fullname; ?>" placeholder="Full Name"  id="input-payment-fulname" class="form-control" />
                                                            <?php if ($error_firstname) { ?>
                                                            <div class="text-danger"><?php echo $error_firstname; ?></div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12">
                                                    <div class="form-group required">
                                                        <div class="col-sm-12">
                                                            <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                                            <?php if ($error_email) { ?>
                                                            <div class="text-danger"><?php echo $error_email; ?></div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="form-group required">
                                                        <?php foreach ($custom_fields as $custom_field) { ?>
                                                            <?php if ($custom_field['location'] == 'account') { ?>
                                                                <?php if ($custom_field['type'] == 'radio') { ?>
                                                                    <div class="col-sm-12">                                                                        
                                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                                            <label class="col-sm-12 no-margin"><?php echo $custom_field['name']; ?></label>
                                                                            <!-- <div class="col-sm-12"> -->
                                                                                <div>
                                                                                    <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                                                                    <label class="radio-custom-field">
                                                                                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                                                                                        <label class="no-margin">
                                                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                                                            <?php echo $custom_field_value['name']; ?>
                                                                                        </label>
                                                                                        <?php } else { ?>
                                                                                        <label class="no-margin">
                                                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                                                                            <?php echo $custom_field_value['name']; ?>
                                                                                        </label>
                                                                                        <?php } ?>
                                                                                    </label>
                                                                                    <?php } ?>
                                                                                </div>
                                                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                                                <?php } ?>
                                                                            <!-- </div> -->
                                                                        </div>
                                                                    </div>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </div>
                                                </div>                                                
                                            </div>

                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group required">
                                                        <?php foreach ($custom_fields as $custom_field) { ?>
                                                            <?php if ($custom_field['location'] == 'account') { ?>
                                                                <?php if ($custom_field['type'] == 'date') { ?>                                                                    
                                                                    <div class="col-sm-12">                                                            
                                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                                         
                                                                            <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control input-birth-date" />                                                                    
                                                                            <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                                <div class="text-danger">
                                                                                    <?php echo $error_custom_field[$custom_field['custom_field_id']]; ?>               
                                                                                </div>
                                                                            <?php } ?>
                                                                        </div>
                                                                    </div>
                                                                <?php } ?>
                                                            <?php } ?>
                                                        <?php } ?>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group">
                                                        <div class="col-sm-12">
                                                            <input type="tel" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
                                                            <?php if ($error_telephone) { ?>
                                                            <div class="text-danger"><?php echo $error_telephone; ?></div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group required" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">                                                
                                                        <div class="col-sm-12">
                                                            <?php foreach ($customer_groups as $customer_group) { ?>
                                                            <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                                                                    <?php echo $customer_group['name']; ?>
                                                                </label>
                                                            </div>
                                                            <?php } else { ?>
                                                            <div class="radio">
                                                                <label>
                                                                    <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
                                                                    <?php echo $customer_group['name']; ?>
                                                                </label>
                                                            </div>
                                                            <?php } ?>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <?php /*
                                                INI DI COMMENT
                                                <?php foreach ($custom_fields as $custom_field) { ?>
                                                    <?php if ($custom_field['location'] == 'account') { ?>
                                                        <?php if ($custom_field['type'] == 'select') { ?>
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <!-- <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label> -->
                                                            <div class="col-sm-12">
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
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
                                                            <div class="col-sm-12">
                                                                <div>
                                                                    <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                                                    <div class="radio">
                                                                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                                                                        <label>
                                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                                            <?php echo $custom_field_value['name']; ?>
                                                                        </label>
                                                                        <?php } else { ?>
                                                                        <label>
                                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
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
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <!-- <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label> -->
                                                            <div class="col-sm-12">
                                                                <div>
                                                                    <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                                                    <div class="checkbox">
                                                                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                        <label>
                                                                            <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                                            <?php echo $custom_field_value['name']; ?>
                                                                        </label>
                                                                        <?php } else { ?>
                                                                        <label>
                                                                            <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
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
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <!-- <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label> -->
                                                            <div class="col-sm-12">
                                                                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                        <?php } ?>
                                                        <?php if ($custom_field['type'] == 'textarea') { ?>
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <!-- <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label> -->
                                                            <div class="col-sm-12">
                                                                <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                        <?php } ?>
                                                        <?php if ($custom_field['type'] == 'file') { ?>
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            <!-- <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label> -->
                                                            <div class="col-sm-12">
                                                                <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                                                <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                                <?php } ?>
                                                            </div>
                                                        </div>
                                                        <?php } ?>
                                                        <?php if ($custom_field['type'] == 'date') { ?>
                                                        <div class="form-group required">
                                                            <div class="col-sm-12">                                                            
                                                                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                                 
                                                                            <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control input-birth-date" />                                                                    
                                                                        <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                                        <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                                        <?php } ?>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <?php } ?>
                                                        <?php if ($custom_field['type'] == 'time') { ?>
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                                            
                                                            <div class="col-sm-12">
                                                                <div class="input-group time">
                                                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
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
                                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">

                                                            <div class="col-sm-12">
                                                                <div class="input-group datetime">
                                                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
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
                                            */?>


                                            
                                            
                                            

                                            
                                            
                                            
                                            <?php /*
                                            <div class="form-group">
                                                <!-- <label class="col-sm-2 control-label" for="input-fax"><?php //echo $entry_fax; ?></label> -->
                                                <div class="col-sm-12">
                                                    <input type="text" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
                                                </div>
                                            </div>
                                            


                                            */ ?>



                                        </fieldset>


                                        <fieldset id="address">
                                            <legend><?php echo $text_your_address; ?></legend>
                                            
                                            <?php /*
                                            <div class="form-group">
                                                
                                                <div class="col-sm-12">
                                                    <input type="text" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company" class="form-control" />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                
                                                <div class="col-sm-12">
                                                    <input type="text" name="address_2" value="<?php echo $address_2; ?>" placeholder="<?php echo $entry_address_2; ?>" id="input-address-2" class="form-control" />
                                                </div>
                                            </div>
                                            */?>
                                            
                                            <div class="row">
                                                <div class="col-sm-12">                                                    
                                                    <div class="form-group required">                                                
                                                        <div class="col-sm-12">
                                                            <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address-1" class="form-control" />
                                                            <?php if ($error_address_1) { ?>
                                                            <div class="text-danger"><?php echo $error_address_1; ?></div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group required">                                                
                                                        <div class="col-sm-12">
                                                            <select name="country_id" class="form-control selectpicker" id="input-country" data-live-search="true">
                                                                <option value=""><?php echo $text_select; ?></option>
                                                                <?php foreach ($countries as $country) { ?>
                                                                <?php if ($country['country_id'] == $country_id) { ?>
                                                                <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
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
                                                            <select name="zone_id" id="input-zone" class="form-control" data-live-search="true">
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
                                                    <div class="form-group required">
                                                        <div class="col-sm-12">
                                                                
                                                            <select class="form-control" id="input-city" name="city" data-live-search="true"></select>
                                                            <?php if ($error_city) { ?>
                                                            <div class="text-danger"><?php echo $error_city; ?></div>
                                                            <?php } ?>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group required">                                                
                                                        <div class="col-sm-12">
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <div>
                                                    <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                                    <div class="radio">
                                                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                                                        <label>
                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                            <?php echo $custom_field_value['name']; ?>
                                                        </label>
                                                        <?php } else { ?>
                                                        <label>
                                                            <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <div>
                                                    <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                                                    <div class="checkbox">
                                                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
                                                        <label>
                                                            <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                                            <?php echo $custom_field_value['name']; ?>
                                                        </label>
                                                        <?php } else { ?>
                                                        <label>
                                                            <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <?php } ?>
                                        <?php if ($custom_field['type'] == 'textarea') { ?>
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <?php } ?>
                                        <?php if ($custom_field['type'] == 'file') { ?>
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                                <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                                                <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                                                <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <?php } ?>
                                        <?php if ($custom_field['type'] == 'date') { ?>
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <div class="input-group date">
                                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <div class="input-group time">
                                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
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
                                        <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                                            
                                            <div class="col-sm-12">
                                                <div class="input-group datetime">
                                                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
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
                                    </fieldset>
                                    <fieldset>
                                        <legend><?php echo $text_your_password; ?></legend>
                                        <div class="form-group required">
                                            
                                            <div class="col-sm-12">
                                                <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                                                <?php if ($error_password) { ?>
                                                <div class="text-danger"><?php echo $error_password; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                        <div class="form-group required">
                                            
                                            <div class="col-sm-12">
                                                <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" />
                                                <?php if ($error_confirm) { ?>
                                                <div class="text-danger"><?php echo $error_confirm; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </fieldset>

                                    <fieldset style="display:none">
                                        <legend><?php echo $text_newsletter; ?></legend>
                                        <div class="form-group">
                                            
                                            <div class="col-sm-12">
                                                <?php if ($newsletter) { ?>
                                                <label class="radio-custom-field">
                                                    <input type="radio" name="newsletter" value="1" checked="checked" />
                                                    <?php echo $text_yes; ?>
                                                </label>
                                                <label class="radio-custom-field">
                                                    <input type="radio" name="newsletter" value="0" />
                                                    <?php echo $text_no; ?>
                                                </label>
                                                <?php } else { ?>
                                                <label class="radio-custom-field">
                                                    <input type="radio" name="newsletter" value="1" checked="checked" />
                                                    <?php echo $text_yes; ?>
                                                </label>
                                                <label class="radio-custom-field">
                                                    <input type="radio" name="newsletter" value="0" />
                                                    <?php echo $text_no; ?>
                                                </label>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </fieldset>
                                    <?php if ($text_agree) { ?>
                                    <div class="form-group">
                                        <div class="col-sm-12 text-right">
                                            <label for="agree">                                                
                                                <?php echo $text_agree; ?>                                            
                                                <?php if ($agree) { ?>
                                                <input type="checkbox" name="agree" id="agree" value="1" checked="checked" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="agree" id="agree" value="1" />
                                                <?php } ?>
                                                &nbsp;
                                            </label>
                                        </div>
                                    </div>

                                    <div class="form-group">                                            
                                        <div class="col-sm-12">                                            
                                            <input name="submit" type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary btn-grey" />
                                        </div>
                                    </div>

                                    <div class="form-group no-margin">
                                        <div class="col-sm-12">
                                            <p class="text-center no-margin">or continue with:</p>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group"> 
                                        <div class="col-sm-12">                                            
                                            <!-- Popup Example -->
                                             <?php
                                                    $store_id = $configs->get('config_store_id');
                                                    $providers =  $configs->get('hybrid_auth') ;
                                                    //pre($providers);
                                                    foreach ($providers as $key => $provider) {
                                                        if($provider['store_id']!=$store_id){
                                                            unset($providers[$key]);
                                                        }
                                                    }


                                                    $store_url = $configs->get('config_url');
                                                    $hybrid_success = $data['store_url'].'index.php?route=hybrid/auth/success';
                                                ?>

                                                <?php if ($configs->get('hybrid_auth_status')) { ?>
                                                <div class="group-sosmed no-margin">
                                                    <?php foreach ($providers as $config) { ?>
                                                    <a onclick="window.open('<?php echo $store_url . 'index.php?route=hybrid/auth&source=product-review&provider=' . $config['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>', 'newwindow', 'width=700, height=450,top=200, left=600'); return false;" href="<?php echo $store_url . 'index.php?route=hybrid/auth&provider=' . $config['provider']; ?>&redirect=<?php echo base64_encode($hybrid_success); ?>">
                                                        <h5 class="sosmed <?php echo $config['provider'];?>"><?php echo $config['provider'];?></h5>
                                                    </a>
                                                    <?php } ?>
                                                </div>
                                                <?php } ?>
                                        </div>                                               
                                    </div>

                                    
                                    <?php } else { ?>
                                    <div class="buttons">
                                        
                                        <input name="submit" type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary btn-grey" />
                                        
                                    </div>
                                    <?php } ?>
                                </form>
                            </div>
                        </div>
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
// Sort the custom fields
$('#account .form-group[data-sort]').detach().each(function() {
  if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#account .form-group').length) {
    $('#account .form-group').eq($(this).attr('data-sort')).before(this);
  } 
  
  if ($(this).attr('data-sort') > $('#account .form-group').length) {
    $('#account .form-group:last').after(this);
  }
    
  if ($(this).attr('data-sort') < -$('#account .form-group').length) {
    $('#account .form-group:first').before(this);
  }
});

$('#address .form-group[data-sort]').detach().each(function() {
  if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#address .form-group').length) {
    $('#address .form-group').eq($(this).attr('data-sort')).before(this);
  } 
  
  if ($(this).attr('data-sort') > $('#address .form-group').length) {
    $('#address .form-group:last').after(this);
  }
    
  if ($(this).attr('data-sort') < -$('#address .form-group').length) {
    $('#address .form-group:first').before(this);
  }
});

$('input[name=\'customer_group_id\']').on('change', function() {
  $.ajax({
    url: 'index.php?route=account/register/customfield&customer_group_id=' + this.value,
    dataType: 'json',
    success: function(json) {
      $('.custom-field').hide();
      $('.custom-field').removeClass('required');

      for (i = 0; i < json.length; i++) {
        custom_field = json[i];

        $('#custom-field' + custom_field['custom_field_id']).show();

        if (custom_field['required']) {
          $('#custom-field' + custom_field['custom_field_id']).addClass('required');
        }
      }
      

    },
    error: function(xhr, ajaxOptions, thrownError) {
      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
    }
  });
});

$('input[name=\'customer_group_id\']:checked').trigger('change');
//--></script> 
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
            alert(json['success']);

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

$('.time').datetimepicker({
  pickDate: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});
//--></script> 
<script type="text/javascript"><!-- 
$(document).ready(function() {
  $('[name=\'country_id\']').change(function() {
    $.post(
      'index.php?route=account/register/zone&country_id='+$('[name=\'country_id\']').val()+'&zone_id='+$('[name=\'zone_id\']').val(),          
      { selType : this.id, dataType: 'html' },
      function(data)
        {          
          $('select[name=\'zone_id\']').html(data);
          $('select[name=\'zone_id\']').selectpicker("refresh");
        }
      );
    $.post(
      'index.php?route=account/register/city&zone_id=0',          
      { selType : this.id, dataType: 'html' },
      function(data)
        {              
          $('select[name=\'city\']').html(data);
          $('select[name=\'city\']').selectpicker("refresh");
        }
      );
  });
  $('[name=\'zone_id\']').change(function() {
    $.post(
      'index.php?route=account/register/city&zone_id='+$('[name=\'zone_id\']').val()+'&city_id='+$('[name=\'city\']').val(),
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
$('select[name=\'country_id\']').trigger('change');
$('select[name=\'zone_id\']').trigger('change');
//--></script>

<?php echo $footer; ?>