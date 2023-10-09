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

            <?php if ($error_warning) { ?>
                <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
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
                    <div class="form-style-2 no-padding">                        
                        <?php echo $content_top; ?>
                        <h4 class="heading sp"><?php echo $text_address_book; ?></h4>
                        <?php if ($addresses) { ?>                            
                            <!-- <table class="table table-bordered table-hover"> -->
                                <div class="wr-list-addr row">
                                    <?php foreach ($addresses as $result) { ?>
                                        <div class="col-sm-6 ">
                                            <div class="item-addr">                                                
                                                <div>                                                
                                                    <?php echo $result['address']; ?>
                                                </div>
                                                <div class="wr-btn-right">                                                
                                                    <a href="<?php echo $result['update']; ?>" class="btn btn-info btn-update-addr"><?php echo $button_edit; ?></a>
                                                    <a href="<?php echo $result['delete']; ?>" class="btn btn-danger btn-close-addr"><i class="fa fa-times"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>
                            <!-- </table> -->
                        <?php } else { ?>
                            <p><?php echo $text_empty; ?></p>
                        <?php } ?>

                        <div class="buttons clearfix">
                            <a href="<?php echo $add; ?>" class="btn btn-grey btn-primary display-inline-block"><?php echo $button_new_address; ?></a>
                        </div>
                        <?php echo $content_bottom; ?>
                    </div>
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