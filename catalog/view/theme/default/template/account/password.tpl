<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>

            <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
            <?php } ?>
          
            <?php if ($error) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?></div>
            <?php } ?>

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
                <div id="content" class="<?php echo $class; ?>">
                    <?php echo $content_top; ?>
                    <!-- <h1 class="heading sp2"><?php echo $heading_title; ?></h1> -->
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal form-style-2 no-padding">
                        <fieldset>
                            <legend><?php echo $text_password; ?></legend>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-password"><?php echo $entry_password; ?></label>
                                            <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />
                                            <?php if ($error_password) { ?>
                                                <div class="text-danger"><?php echo $error_password; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <label class="col-sm-12" for="input-confirm"><?php echo $entry_confirm; ?></label>
                                            <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="form-control" />
                                            <?php if ($error_confirm) { ?>
                                                <div class="text-danger"><?php echo $error_confirm; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            
                            <div class="buttons clearfix">
                                <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-grey btn-primary" />
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
<script>
    $('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>
<?php echo $footer; ?> 