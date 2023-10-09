<div class="head-step-checkout list-group">
    <ul>
        <?php if ($logged) { ?>
        <li><a href="<?php echo $account; ?>" class="list-group-item"><?php echo $text_account; ?></a></li>
        <li><a href="<?php echo $password; ?>" class="list-group-item"><?php echo $text_password; ?></a></li>
        <?php } ?>
        <li><a href="<?php echo $address; ?>" class="list-group-item"><?php echo $text_address; ?></a> </li>
        <li><a href="<?php echo $order; ?>" class="list-group-item"><?php echo $text_order; ?></a> </li>
        <li><a href="payment-confirmation" class="list-group-item">Payment Confirmation</a> </li>
        <!-- <li><a href="<?php echo $reward; ?>" class="list-group-item"><?php echo $text_reward; ?></a> </li> -->
        <li><a href="<?php echo $transaction; ?>" class="list-group-item"><?php echo $text_transaction; ?></a></li>
        <?php if ($logged) { ?>
        <li><a href="<?php echo $logout; ?>" class="list-group-item"><?php echo $text_logout; ?></a></li>
        <?php } ?>
    </ul>
</div>