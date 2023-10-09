<div class="table-responsive">
  <table class="table table-bordered table-hover">
    <thead>
    <tr>
      <td class="text-left"><?php echo $column_email; ?></td>
      <td class="text-left"><?php echo $column_gender; ?></td>
      <td class="text-left"><?php echo $column_coupon_code; ?></td>
      <td class="text-left"><?php echo $column_coupon_value; ?></td>
      <td class="text-left"><?php echo $column_coupon_date_added; ?></td>
      <td class="text-left"><?php echo $column_coupon_date_end; ?></td>
      <td class="text-left"><?php echo $column_date_added; ?></td>      
      <td class="text-left"><?php echo $column_order_id; ?></td>
      <td class="text-left"><?php echo $column_customer; ?></td>
      <td class="text-right"><?php echo $column_amount; ?></td>
      <td class="text-right">Status</td>
    </tr>
  </thead>
  <tbody>
    <?php if ($histories) { ?>
    <?php foreach ($histories as $history) { ?>
    <tr>
      <td class="text-left"><?php echo $history['email']; ?></td>
      <td class="text-left"><?php if($history['gender'] == 1) {echo "Male";} elseif ($history['gender'] == 2) { echo "Female"; } else {echo "-"; } ?></td>
      <td class="text-left"><?php echo hideWithStar($history['code']); ?></td>
      <td class="text-left"><?php echo $history['value']; ?></td>
      <td class="text-left"><?php echo $history['date_coupon_added']; ?></td>
      <td class="text-left"><?php echo $history['date_coupon_end']; ?></td>
      <td class="text-left"><?php echo $history['date_added']; ?></td>
      <td class="text-left"><?php echo $history['order_id']; ?></td>
      <td class="text-left"><?php echo $history['customer']; ?></td>
      <td class="text-right"><?php echo $history['amount']; ?></td>
      <td class="text-right"><?php echo ($history['status']) ? 'Aktif':'Non Aktif'; ?></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td class="text-center" colspan="11"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
  </table>
</div>

<div class="row">
  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
</div>
