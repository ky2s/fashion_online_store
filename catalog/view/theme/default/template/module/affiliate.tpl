<div class="list-group">
  <?php if (!$logged) { ?>
  <a href="<?php echo $login; ?>" class="list-group-item"><?php echo $text_login; ?></a> <a href="<?php echo $register; ?>" class="list-group-item"><?php echo $text_register; ?></a> <a href="<?php echo $forgotten; ?>" class="list-group-item"><?php echo $text_forgotten; ?></a>
  <?php } ?>
  <a href="<?php echo $account; ?>" class="list-group-item"><i class="fa fa-user fa-fw"></i>&nbsp;&nbsp;<?php echo $text_account; ?></a>
  <?php if ($logged) { ?>
  <a href="<?php echo $edit; ?>" class="list-group-item"><i class="fa fa-edit fa-fw"></i>&nbsp;&nbsp;<?php echo $text_edit; ?></a> <a href="<?php echo $password; ?>" class="list-group-item"><i class="fa fa-lock fa-fw"></i>&nbsp;&nbsp;<?php echo $text_password; ?></a>
  <?php } ?>
  <a href="<?php echo $payment; ?>" class="list-group-item"><i class="fa fa-cc-mastercard fa-fw"></i>&nbsp;&nbsp;<?php echo $text_payment; ?></a> <a href="<?php echo $tracking; ?>" class="list-group-item"><i class="fa fa-truck fa-fw"></i>&nbsp;&nbsp;<?php echo $text_tracking; ?></a> <a href="<?php echo $transaction; ?>" class="list-group-item"><i class="fa fa-dollar fa-fw"></i>&nbsp;&nbsp;<?php echo $text_transaction; ?></a>
  <?php if ($logged) { ?>
  <a href="<?php echo $logout; ?>" class="list-group-item"><i class="fa fa-sign-out fa-fw"></i>&nbsp;&nbsp;<?php echo $text_logout; ?></a>
  <?php } ?>
</div>
