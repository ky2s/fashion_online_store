<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-doku-onecheckout" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>

  <div class="container-fluid">
	
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-doku-onecheckout" class="form-horizontal">
		
		<!-- Make order status default -->		
		<input type="hidden" name="doku_onecheckout_order_status_id" value=1>
				
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $server_params; ?></h3>
      </div>
      <div class="panel-body">
				
				<div class="form-group required">
            <label class="col-sm-2 control-label" for="doku_onecheckout_status"><?php echo $entry_status; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_status" id="doku_onecheckout_status" class="form-control">
									<?php if ($doku_onecheckout_status) { ?>
									<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>								
            </div>
				</div>

				<div class="form-group required">				
            <label class="col-sm-2 control-label" for="doku_onecheckout_server_set"><?php echo "Choose Server Destination"; ?></label>									
            <div class="col-sm-10">			
								<select name="doku_onecheckout_server_set" id="doku_onecheckout_server_set" class="form-control">
									<?php if ($doku_onecheckout_server_set) { ?>
									<option value="1" selected="selected">Production</option>
									<option value="0">Development</option>
									<?php } else { ?>
									<option value="1">Production</option>
									<option value="0" selected="selected">Development</option>
									<?php } ?>
								</select>														
            </div>						
				</div>

				<div class="form-group">
            <label class="col-sm-2 control-label">Production Server</label>			
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_mallid_prod; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_mallid_prod" id="doku_onecheckout_mallid_prod" value="<?php echo ( $doku_onecheckout_mallid_prod=='' ? "99999999" : $doku_onecheckout_mallid_prod ); ?>" placeholder="Input your Production Mall ID here" class="form-control" />
            </div>						
						<?php if ($error_mallid_prod) { ?>
						<span class="error"><?php echo $error_mallid_prod; ?></span>
						<?php } ?>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_sharedkey_prod; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_sharedkey_prod" id="doku_onecheckout_sharedkey_prod" value="<?php echo ( $doku_onecheckout_sharedkey_prod=='' ? "99999999" : $doku_onecheckout_sharedkey_prod ); ?>" placeholder="Input your Production Shared Key here" class="form-control" />
            </div>						
						<?php if ($error_sharedkey_prod) { ?>
						<span class="error"><?php echo $error_sharedkey_prod; ?></span>
						<?php } ?>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_chain_prod; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_chain_prod" id="doku_onecheckout_chain_prod" value="<?php echo ( $doku_onecheckout_chain_prod=='' ? "NA" : $doku_onecheckout_chain_prod ); ?>" placeholder="Input your Production Chain Number here" class="form-control" />
            </div>						
						<?php if ($error_chain_prod) { ?>
						<span class="error"><?php echo $error_chain_prod; ?></span>
						<?php } ?>						
				</div>
								
				<div class="form-group">
            <label class="col-sm-2 control-label">Development Server</label>			
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_mallid_dev; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_mallid_dev" id="doku_onecheckout_mallid_dev" value="<?php echo ( $doku_onecheckout_mallid_dev=='' ? "99999999" : $doku_onecheckout_mallid_dev ); ?>" placeholder="Input your Development Mall ID here" class="form-control" />
            </div>						
						<?php if ($error_mallid_dev) { ?>
						<span class="error"><?php echo $error_mallid_dev; ?></span>
						<?php } ?>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_sharedkey_dev; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_sharedkey_dev" id="doku_onecheckout_sharedkey_dev" value="<?php echo ( $doku_onecheckout_sharedkey_dev=='' ? "99999999" : $doku_onecheckout_sharedkey_dev ); ?>" placeholder="Input your Development Shared Key here" class="form-control" />
            </div>						
						<?php if ($error_sharedkey_dev) { ?>
						<span class="error"><?php echo $error_sharedkey_dev; ?></span>
						<?php } ?>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_chain_dev; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_chain_dev" id="doku_onecheckout_chain_dev" value="<?php echo ( $doku_onecheckout_chain_dev=='' ? "NA" : $doku_onecheckout_chain_dev ); ?>" placeholder="Input your Development Chain Number here" class="form-control" />
            </div>						
						<?php if ($error_chain_dev) { ?>
						<span class="error"><?php echo $error_chain_dev; ?></span>
						<?php } ?>						
				</div>

			</div>
		</div>	

		
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $opencart_params; ?></h3>
      </div>
      <div class="panel-body">
			
				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_review_edu; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_review_edu" id="doku_onecheckout_review_edu" class="form-control">
									<?php if ($doku_onecheckout_review_edu) { ?>
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
									<?php } else { ?>
									<option value="1">Yes</option>
									<option value="0" selected="selected">No</option>
									<?php } ?>
								</select>																				
								<span class="breadcrumb">Are you using DOKU EDU Services? No if you unsure.</span>
            </div>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_identify; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_identify" id="doku_onecheckout_identify" class="form-control">
									<?php if ($doku_onecheckout_identify) { ?>
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
									<?php } else { ?>
									<option value="1">Yes</option>
									<option value="0" selected="selected">No</option>
									<?php } ?>
								</select>																				
								<span class="breadcrumb">Are you using Identify process? No if you unsure.</span>
            </div>						
				</div>
				
				<div class="form-group">
						<label class="col-sm-2 control-label" for="doku_onecheckout_geo_zone_id"><?php echo $entry_geo_zone; ?></label>
						<div class="col-sm-10">
								<select name="doku_onecheckout_geo_zone_id" id="doku_onecheckout_geo_zone_id" class="form-control">
									<option value="0"><?php echo $text_all_zones; ?></option>
									<?php foreach ($geo_zones as $geo_zone) { ?>
									<?php if ($geo_zone['geo_zone_id'] == $doku_onecheckout_geo_zone_id) { ?>
									<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
						</div>
				</div>
				
				<div class="form-group">
						<label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
								<input type="text" name="doku_onecheckout_sort_order" value="<?php echo $doku_onecheckout_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
						</div>
				</div>
				
			</div>
		</div>	


    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $paymentchannel_params; ?></h3>
      </div>
      <div class="panel-body">

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $entry_doku_name; ?></label>			
            <div class="col-sm-10">
								<input type="text" name="doku_onecheckout_doku_name" id="doku_onecheckout_doku_name" value="<?php echo ( $doku_onecheckout_doku_name=='' ? "DOKU Payment Gateway" : $doku_onecheckout_doku_name ); ?>" placeholder="Input your Production Shared key here" class="form-control" />
            </div>						
						<?php if ($error_doku_name) { ?>
						<span class="error"><?php echo $error_doku_name; ?></span>
						<?php } ?>
				</div>

				<div class="form-group">
						<label class="col-sm-2 control-label" for="doku_onecheckout_geo_zone_id"><?php echo $paymentchannel_selection; ?></label>
						<div class="col-sm-10">
								<select name="doku_onecheckout_payment_select" id="doku_onecheckout_payment_select" class="form-control">
									<?php if ($doku_onecheckout_payment_select) { ?>
									<option value="1" selected="selected">Selected</option>
									<option value="0">All</option>
									<?php } else { ?>
									<option value="1">Selected</option>
									<option value="0" selected="selected">All</option>
									<?php } ?>
								</select>																				
						</div>
				</div>				

				<div class="form-group">
            <label class="control-label" style="margin-left: 30px;">If using 'Selected' payment channel, please choose payment channel to display</label>			
				</div>
				
				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_cc; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[1]" id="doku_onecheckout_payment_list[1]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[1]) { ?>
									<option value="01" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="01">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[1]" value="VISA / Master Credit Card">								
            </div>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_clickpay; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[2]" id="doku_onecheckout_payment_list[2]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[2]) { ?>
									<option value="02" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="02">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[2]" value="Mandiri Clickpay">								
            </div>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_dokuwalet; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[4]" id="doku_onecheckout_payment_list[4]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[4]) { ?>
									<option value="04" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="04">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[4]" value="Dokuwallet">								
            </div>						
				</div>

				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_epaybri; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[6]" id="doku_onecheckout_payment_list[6]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[6]) { ?>
									<option value="05" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="05">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[6]" value="ePay BRI">								
            </div>						
				</div>
				
				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_permatavalite; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[5]" id="doku_onecheckout_payment_list[5]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[5]) { ?>
									<option value="06" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="06">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[5]" value="ATM Transfer">								
            </div>						
				</div>
				
				<div class="form-group required">
            <label class="col-sm-2 control-label" for=""><?php echo $paymentchannel_dokualfa; ?></label>			
            <div class="col-sm-10">
								<select name="doku_onecheckout_payment_list[14]" id="doku_onecheckout_payment_list[14]" class="form-control">
									<?php if ($doku_onecheckout_payment_list[14]) { ?>
									<option value="14" selected="selected">Enable</option>
									<option value="">Disable</option>
									<?php } else { ?>
									<option value="14">Enable</option>
									<option value="" selected="selected">Disable</option>
									<?php } ?>
								</select>																												
								<input type="hidden" name="doku_onecheckout_payment_name[14]" value="DOKU Alfa">								
            </div>						
				</div>
				
			</div>
		</div>	

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $url_title; ?></h3>
      </div>
      <div class="panel-body">

				<div class="form-group required">			
						<label class="col-sm-2 control-label" for="input-sort-order">Identify</label>
						<div class="col-sm-10">
								<input type="text" value="<?php echo $url_identify; ?>" class="form-control" readonly="readonly"/>
						</div>			
				</div>

				<div class="form-group required">			
						<label class="col-sm-2 control-label" for="input-sort-order">Notify</label>
						<div class="col-sm-10">
								<input type="text" value="<?php echo $url_notify; ?>" class="form-control" readonly="readonly"/>
						</div>			
				</div>

				<div class="form-group required">			
						<label class="col-sm-2 control-label" for="input-sort-order">Redirect</label>
						<div class="col-sm-10">
								<input type="text" value="<?php echo $url_redirect; ?>" class="form-control" readonly="readonly"/>
						</div>			
				</div>

				<div class="form-group required">			
						<label class="col-sm-2 control-label" for="input-sort-order">Review</label>
						<div class="col-sm-10">
								<input type="text" value="<?php echo $url_review; ?>" class="form-control" readonly="readonly"/>
						</div>			
				</div>
				
			</div>
		</div>	
					
	</div>	
	
	</form>
	
</div>

<?php echo $footer; ?>