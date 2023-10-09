<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>
            
            <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
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
                    <fieldset>
                        <legend><?php echo $heading_title; ?></legend>
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td class="text-left" colspan="2"><?php echo $text_order_detail; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-left" style="width: 50%;"><?php if ($invoice_no) { ?>
                                        <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
                                        <?php } ?>
                                        <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
                                        <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?>
                                    </td>
                                    <td class="text-left"><?php if ($payment_method) { ?>
                                        <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
                                        <?php } ?>
                                        <?php if ($shipping_method) { ?>
                                        <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
                                        <?php } ?>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td class="text-left" style="width: 50%;"><?php echo $text_payment_address; ?></td>
                                    <?php if ($shipping_address) { ?>
                                    <td class="text-left"><?php echo $text_shipping_address; ?></td>
                                    <?php } ?>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-left"><?php echo $payment_address; ?></td>
                                    <?php if ($shipping_address) { ?>
                                    <td class="text-left"><?php echo $shipping_address; ?></td>
                                    <?php } ?>
                                </tr>
                            </tbody>
                        </table>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td class="text-left" width="200"><?php echo $column_name; ?></td>
                                        <td class="text-left" width="100"><?php echo $column_model; ?></td>
                                        <td class="text-right" width="50"><?php echo $column_quantity; ?></td>
                                        <td class="text-right" width="120"><?php echo $column_price; ?></td>
                                        <td class="text-right" width="120"><?php echo $column_total; ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($products as $product) { ?>
                                    <tr>
                                        <td class="text-left"><?php echo $product['name']; ?>
                                            <?php foreach ($product['option'] as $option) { ?>
                                            <br />
                                            &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                        <?php } ?></td>
                                        <td class="text-left"><?php echo $product['model']; ?></td>
                                        <td class="text-right"><?php echo $product['quantity']; ?></td>
                                        <td class="text-right"><?php echo str_replace(" ","&nbsp;",$product['price']); ?></td>
                                        <td class="text-right"><?php echo str_replace(" ","&nbsp;",$product['total']); ?></td>
                                    </tr>
                                    <?php } ?>
                                    <?php foreach ($vouchers as $voucher) { ?>
                                    <tr>
                                        <td class="text-left"><?php echo $voucher['description']; ?></td>
                                        <td class="text-left"></td>
                                        <td class="text-right">1</td>
                                        <td class="text-right"><?php echo str_replace(" ","&nbsp;",$voucher['amount']); ?></td>
                                        <td class="text-right"><?php echo str_replace(" ","&nbsp;",$voucher['amount']); ?></td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                                <tfoot>
                                <?php foreach ($totals as $total) { ?>
                                <tr>
                                    <!-- <td ></td> -->
                                    <td class="text-right" colspan="4"><b><?php echo $total['title']; ?></b></td>
                                    <td class="text-right"><?php echo $total['text']; ?></td>
                                </tr>
                                <?php } ?>
                                </tfoot>
                            </table>
                        </div>
                        <?php if ($comment) { ?>
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td class="text-left"><?php echo $text_comment; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="text-left"><?php echo $comment; ?></td>
                                </tr>
                            </tbody>
                        </table>
                        <?php } ?>
                        <?php if ($histories) { ?>
                        <!-- <h3><?php echo $text_history; ?></h3> -->
                        <legend><?php echo $text_history; ?></legend>
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td class="text-left"><?php echo $column_date_added; ?></td>
                                    <td class="text-left"><?php echo $column_status; ?></td>
                                    <td class="text-left"><?php echo $column_comment; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($histories as $history) { ?>
                                <tr>
                                    <td class="text-left"><?php echo $history['date_added']; ?></td>
                                    <td class="text-left"><?php echo $history['status']; ?></td>
                                    <td class="text-left"><?php echo $history['comment']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                        <?php } ?>
                        <div class="buttons clearfix">
                            <div class="pull-right">
                                <a href="<?php echo $continue; ?>" class="btn btn-primary btn-grey"><?php echo $button_continue; ?></a>
                            </div>
                        </div>
                        <?php echo $content_bottom; ?>
                    </fieldset>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<script>
    $('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>
<style>
    tfoot tr td{
        border-left: none !important;
        border-right: none !important;
    }
</style>
<?php echo $footer; ?>