
<?php

    $letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    $prefix  = substr(str_shuffle($letters), 0, 4);

    function get_payment_list($channel_list, $channel)
    {
        if ( isset($channel_list) )
        {
            if ( in_array($channel, $channel_list) )
            {
                $result = "checked";
            }
            else
            {
                $result = "";
            }
        }
        else
        {
            $result = "";
        }
        
        return $result;
    }

    function get_payment_name($channel_list, $channel, $default)
    {
        if ( isset($channel_list) )
        {
            if ( is_array($channel_list) && array_key_exists($channel, $channel_list) )
            {
                $result = $channel_list[$channel];
            }
            else
            {
                $result = $default;
            }
        }
        else
        {
            $result = $default;
        }
        
        return $result;
    }
    
?>

<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-trf_bca" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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

    <form action="<?php echo $action; ?>" method="post" id="form-myshortcart" class="form-horizontal">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?><?php echo $server_params; ?></h3>
      </div>
      <div class="panel-body">
        
          
          <div class="form-group required">
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Input your Store ID given by Myshortcart"><?php echo $entry_storeid; ?></span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_storeid" placeholder="Input your Store ID here" value="<?php echo ( $myshortcart_storeid=='' ? "99999999" : $myshortcart_storeid ) ?>"  class="form-control" />

                <?php if ($error_storeid) { ?>
                    <div class="text-danger"><?php echo $error_storeid; ?></div>
                <?php } ?>
            </div>
          </div>  

          <div class="form-group required">
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Input your Sharedkey given by Myshortcart">
                <?php echo $entry_sharedkey; ?>
                </span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_sharedkey" placeholder="Input your Sharedkey here" value="<?php echo ( $myshortcart_sharedkey=='' ? "99999999" : $myshortcart_sharedkey ) ?>" class="form-control" />

                <?php if ($error_sharedkey) { ?>
                    <div class="text-danger"><?php echo $error_sharedkey; ?></div>
                <?php } ?>
            </div>
          </div>  

          <div class="form-group required">
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Input your 4 Prefix Character for set unique invoice number. Do not use _ (underscore)">
                <?php echo $entry_prefix; ?>
                </span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_prefix" placeholder="Input your Prefix here" value="<?php echo ( $myshortcart_prefix=='' ? $prefix : $myshortcart_prefix ) ?>" class="form-control" />

                <?php if ($error_prefix) { ?>
                    <div class="text-danger"><?php echo $error_prefix; ?></div>
                <?php } ?>
            </div>
          </div>  

          
      </div>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?><?php echo $opencart_params; ?></h3>
      </div>
      <div class="panel-body">
        <input type="hidden" name="myshortcart_order_status_id" value="<?php echo $myshortcart_order_status_id; ?>">

        <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status">
                <span title="" data-toggle="tooltip" data-original-title="Choose your default Geo Zone">
                <?php echo $entry_geo_zone; ?>
                </span>
            </label>
            <div class="col-sm-10">
              <select name="myshortcart_geo_zone_id" id="input-order-status" class="form-control">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $myshortcart_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label" for="input-order-status">
                <span title="" data-toggle="tooltip" data-original-title="Disable or Enable Myshortcart Plugin">
                <?php echo $entry_status; ?>
                </span>
            </label>
            <div class="col-sm-10">
              <select name="myshortcart_status" id="input-order-status" class="form-control">
                <?php if ($myshortcart_status) { ?>
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
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Minimal amount to be processed. Default 10000.00, 999999999999 means no limit.">
                <?php echo $entry_minimal_amount; ?>
                </span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_minimal_amount" placeholder="Minimal amount to process" value="<?php echo ( $myshortcart_minimal_amount=='' ? "10000.00" : $myshortcart_minimal_amount ) ?>" class="form-control" />

                <?php if ($error_minimal_amount) { ?>
                    <div class="text-danger"><?php echo $error_minimal_amount; ?></div>
                <?php } ?>
            </div>
          </div>  

          <div class="form-group">
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Sort Order on Payment Method">
                <?php echo $entry_sort_order; ?>
                </span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_sort_order" placeholder="Input your expired time for transaction here" value="<?php echo ( $myshortcart_sort_order=='' ? "1" : $myshortcart_sort_order ) ?>" class="form-control" />
            </div>
          </div>  


      </div>
    </div>





    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?><?php echo $paymentchannel_params; ?></h3>
      </div>
      <div class="panel-body">
          <div class="form-group required">
            <label class="col-sm-2 control-label">
                <span title="" data-toggle="tooltip" data-original-title="Input Myshortcart name to be displayed on Payment Method selection">
                <?php echo $entry_payment_name; ?>
                </span>
            </label>
            <div class="col-sm-10">
                <input size="30" type="text" name="myshortcart_payment_name" placeholder="Input Myshortcart name to display" value="<?php echo ( $myshortcart_payment_name=='' ? "Myshortcart Payment Gateway" : $myshortcart_payment_name ) ?>" class="form-control" />

                <?php if ($error_payment_name) { ?>
                    <div class="text-danger"><?php echo $error_payment_name; ?></div>
                <?php } ?>
            </div>
          </div>  

      </div>
    </div>


    </form>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-file-o"></i> <?php echo $text_edit; ?><?php echo $url_title; ?></h3>
      </div>
      <div class="panel-body">
          <div class="form-group clearfix">
            <label class="col-sm-2 control-label">
            Identify
            </label>
            <div class="col-sm-10">
                <input type="text" value="<?php echo $url_verify ?>" size="100" readonly="true" class="form-control" />
            </div>
          </div>  

          <div class="form-group clearfix">
            <label class="col-sm-2 control-label">
            Notify
            </label>
            <div class="col-sm-10">
                <input type="text" value="<?php echo $url_notify ?>" size="100" readonly="true" class="form-control" />
            </div>
          </div>

          <div class="form-group clearfix">
            <label class="col-sm-2 control-label">
            Redirect
            </label>
            <div class="col-sm-10">
                <input type="text" value="<?php echo $url_redirect ?>" size="100" readonly="true" class="form-control" />
            </div>
          </div>

          <div class="form-group clearfix">
            <label class="col-sm-2 control-label">
            Cancel
            </label>
            <div class="col-sm-10">
                <input type="text" value="<?php echo $url_cancel ?>" size="100" readonly="true" class="form-control" />
            </div>
          </div>

      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>