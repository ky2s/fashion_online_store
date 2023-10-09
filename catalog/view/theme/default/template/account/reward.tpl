<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>
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
                    <div class="form-style-2 no-padding">
                        <?php echo $content_top; ?>
                        <h4 class="heading"><?php echo $heading_title; ?></h4>
                        <p><?php echo $text_total; ?> <b><?php echo $total; ?></b>.</p>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td class="text-left"><?php echo $column_date_added; ?></td>
                                        <td class="text-left"><?php echo $column_description; ?></td>
                                        <td class="text-right"><?php echo $column_points; ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if ($rewards) { ?>
                                    <?php foreach ($rewards  as $reward) { ?>
                                    <tr>
                                        <td class="text-left"><?php echo $reward['date_added']; ?></td>
                                        <td class="text-left"><?php if ($reward['order_id']) { ?>
                                            <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
                                            <?php } else { ?>
                                            <?php echo $reward['description']; ?>
                                        <?php } ?></td>
                                        <td class="text-right"><?php echo $reward['points']; ?></td>
                                    </tr>
                                    <?php } ?>
                                    <?php } else { ?>
                                    <tr>
                                        <td class="text-center" colspan="3"><?php echo $text_empty; ?></td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                        </div>
                        <div class="buttons clearfix">
                            <!-- <div class="pull-right"> -->
                                <a href="<?php echo $continue; ?>" class="btn btn-grey btn-primary"><?php echo $button_continue; ?></a>
                            <!-- </div> -->
                        </div>
                        <?php echo $content_bottom; ?>
                    </div>
                </div>
            <?php echo $column_right; ?></div>
        </div>
    </div>
</div>
<script>
$('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>
<?php echo $footer; ?>