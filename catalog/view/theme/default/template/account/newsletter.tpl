<?php echo $header; ?>
<div id="center-other-page">
  <div class="container">
    <div class="intro-padding">

      <div class="row">
        <div class="list-account">
          <?php echo $column_left; ?>
        </div>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">

          <?php echo $content_top; ?>

          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal form-style-2">
            <fieldset>
              <legend><?php echo $heading_title; ?></legend>
              <div class="form-group col-sm-12">
                  <label class="col-sm-2 control-label"><?php echo $entry_newsletter; ?></label>
                <div class="col-sm-10">
                  <?php if ($newsletter) { ?>
                  <label class="radio-inline">
                    <input type="radio" name="newsletter" value="1" checked="checked" />
                    <?php echo $text_yes; ?> </label>
                  <label class="radio-inline" style="padding-left:15px !important">
                    <input type="radio" name="newsletter" value="0" />
                    <?php echo $text_no; ?></label>
                  <?php } else { ?>
                  <label class="radio-inline">
                    <input type="radio" name="newsletter" value="1" />
                    <?php echo $text_yes; ?> </label>
                  <label class="radio-inline" style="padding-left:20px !important">
                    <input type="radio" name="newsletter" value="0" checked="checked" />
                    <?php echo $text_no; ?></label>
                  <?php } ?>
                </div>
              </div>
            </fieldset>
            <div class="buttons clearfix">

              <div class="pull-right">
                <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-grey btn-primary" />
              </div>
            </div>
          </form>
          <?php echo $content_bottom; ?>
          
      </div>
      <?php echo $column_right; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>