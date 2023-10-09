<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-coupon" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        
        <ul class="nav nav-tabs">
          <li class="active"><a href="#tab-setting" data-toggle="tab"><?php echo $tab_setting; ?></a></li>          
          <li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>        
        </ul>

        <div class="tab-content">
          <div class="tab-pane active" id="tab-setting">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-coupon" class="form-horizontal">
              
              <div class="form-group required">
                <label class="col-sm-2 control-label" for="config_newsletter_discount"><?php echo $entry_discount; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="config_newsletter_discount" value="<?php echo $config_newsletter_discount; ?>" placeholder="<?php echo $entry_discount; ?>" id="config_newsletter_discount" class="form-control" />
                  <?php if ($error_discount) { ?>
                  <div class="text-danger"><?php echo $error_discount; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group required">
                <label class="col-sm-2 control-label" for="config_newsletter_total"><span data-toggle="tooltip" title="<?php echo $help_total; ?>"><?php echo $entry_total; ?></span></label>
                <div class="col-sm-10">
                  <input type="text" name="config_newsletter_total" value="<?php echo $config_newsletter_total; ?>" placeholder="<?php echo $entry_total; ?>" id="config_newsletter_total" class="form-control" />
                  <?php if ($error_total) { ?>
                  <div class="text-danger"><?php echo $error_total; ?></div>
                  <?php } ?>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_logged; ?>"><?php echo $entry_logged; ?></span></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_newsletter_logged) { ?>
                    <input type="radio" name="config_newsletter_logged" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_logged" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_newsletter_logged) { ?>
                    <input type="radio" name="config_newsletter_logged" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_logged" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_shipping; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_newsletter_shipping) { ?>
                    <input type="radio" name="config_newsletter_shipping" value="1" checked="checked" />
                    <?php echo $text_yes; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_shipping" value="1" />
                    <?php echo $text_yes; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_newsletter_shipping) { ?>
                    <input type="radio" name="config_newsletter_shipping" value="0" checked="checked" />
                    <?php echo $text_no; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_shipping" value="0" />
                    <?php echo $text_no; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <label class="radio-inline">
                    <?php if ($config_newsletter_status) { ?>
                    <input type="radio" name="config_newsletter_status" value="1" checked="checked" />
                    <?php echo $text_enabled; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_status" value="1" />
                    <?php echo $text_enabled; ?>
                    <?php } ?>
                  </label>
                  <label class="radio-inline">
                    <?php if (!$config_newsletter_status) { ?>
                    <input type="radio" name="config_newsletter_status" value="0" checked="checked" />
                    <?php echo $text_disabled; ?>
                    <?php } else { ?>
                    <input type="radio" name="config_newsletter_status" value="0" />
                    <?php echo $text_disabled; ?>
                    <?php } ?>
                  </label>
                </div>
              </div>

            </form>
          </div>          
          <div class="tab-pane" id="tab-history">
            <div id="history"></div>
          </div>          
        </div>        
      </div>
    </div>
  </div>
</div>


<script type="text/javascript"><!--
  $('#history').delegate('.pagination a', 'click', function(e) {
    e.preventDefault();
    
    $('#history').load(this.href);
  }); 
		
  $('#history').load('index.php?route=marketing/coupon_newsletter/history&token=<?php echo $token; ?>');
//--></script>

<?php echo $footer; ?>