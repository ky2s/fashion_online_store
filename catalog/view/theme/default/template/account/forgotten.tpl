<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding no-margin">

            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
            <?php } ?>
            <div class="row">
                <?php #echo $column_left; ?>
                <?php $class = 'col-sm-12'; /*if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
                <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
                <?php } */?>
                <div id="content" class="<?php echo $class; ?>">
                    <?php echo $content_top; ?>
                                     
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal form-style-2 no-padding">
                        <div class="row">
                            <div class="col-sm-6 col-xs-12">
                                <fieldset>
                                    <legend><?php echo $heading_title; ?></legend>
                                    <p><?php echo $text_email; ?></p>
                                    <br>
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-email"><?php echo $entry_email; ?></label>
                                            <input type="email" name="email" value="" id="input-email" class="form-control" />
                                        </div>
                                    </div>
                                </fieldset>
                                <div class="buttons clearfix">
                                    <div class="">
                                        <a href="<?php echo $back; ?>" class="btn btn-primary btn-grey"><?php echo $button_back; ?></a>
                                        <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary btn-grey" />
                                    </div>                            
                                </div>
                                
                            </div>
                        </div>
                    </form>
                    <?php echo $content_bottom; ?>
                </div>
                <?php #echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>