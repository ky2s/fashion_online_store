<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>
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
                        <h4 class="heading sp"><?php echo $heading_title; ?></h4>
                        <?php if ($orders) { ?>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td class="text-right"><?php echo $column_order_id; ?></td>
                                        <td class="text-right"><?php echo $column_store_name; ?></td>
                                        <td class="text-left"><?php echo $column_status; ?></td>
                                        <td class="text-left"><?php echo $column_date_added; ?></td>
                                        <td class="text-right"><?php echo $column_product; ?></td>
                                        <td class="text-left"><?php echo $column_customer; ?></td>
                                        <td class="text-right"><?php echo $column_total; ?></td>
                                        <td></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($orders as $order) { ?>
                                    <tr>
                                        <td class="text-right">#<?php echo $order['order_id']; ?></td>
                                        <td class="text-left"><?php echo $order['store_name']; ?></td>
                                        <td class="text-left"><?php echo $order['status']; ?></td>
                                        <td class="text-left"><?php echo $order['date_added']; ?></td>
                                        <td class="text-right"><?php echo $order['products']; ?></td>
                                        <td class="text-left"><?php echo $order['name']; ?></td>
                                        <td class="text-right"><?php echo $order['total']; ?></td>
                                        <td class="text-right">
                                            <a href="<?php echo $order['href']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-rmv">
                                                <i class="fa fa-eye"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-right"><?php echo $pagination; ?></div>
                        <?php } else { ?>
                        <p><?php echo $text_empty; ?></p>
                        <?php } ?>
                        <div class="buttons clearfix">
                            <!-- <div class="pull-right"> -->
                            <a href="<?php echo $continue; ?>" class="btn btn-grey btn-primary"><?php echo $button_continue; ?></a>
                            <!-- </div> -->
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