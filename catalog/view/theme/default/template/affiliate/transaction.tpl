<?php echo $header; ?>
<div id="center-other-page">
    
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>

            <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
            <?php } ?>

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

                    <h1 class="heading"><?php echo $heading_title; ?></h1>
                    <div class="wrapperAfterHeading">
                    <p><?php echo $text_balance; ?> <strong><?php echo $balance; ?></strong>.</p>
                    <div class="table-responsive">
                      <table class="table table-striped table-bordered table-hover">
                        <thead>
                          <tr>
                            <td class="text-left"><?php echo $column_date_added; ?></td>
                            <td class="text-left"><?php echo $column_description; ?></td>
                            <td class="text-right"><?php echo $column_amount; ?></td>
                          </tr>
                        </thead>
                        <tbody>
                          <?php if ($transactions) { ?>
                          <?php foreach ($transactions  as $transaction) { ?>
                          <tr>
                            <td class="text-left"><?php echo $transaction['date_added']; ?></td>
                            <td class="text-left"><?php echo $transaction['description']; ?></td>
                            <td class="text-right"><?php echo $transaction['amount']; ?></td>
                          </tr>
                          <?php } ?>
                          <?php } else { ?>
                          <tr>
                            <td class="text-center" colspan="5"><?php echo $text_empty; ?></td>
                          </tr>
                          <?php } ?>
                        </tbody>
                      </table>
                    </div>
                    <div class="text-right"><?php echo $pagination; ?></div>
                    <div class="buttons clearfix">
                      <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-grey btn-primary"><?php echo $button_continue; ?></a></div>
                    </div>
                    
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>

<script>
    $('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>