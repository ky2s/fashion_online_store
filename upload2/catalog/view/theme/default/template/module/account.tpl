<div class="list-group">
  <?php if (!$logged) { ?>
  <a href="<?php echo $login; ?>" class="list-group-item"><?php echo $text_login; ?></a> <a href="<?php echo $register; ?>" class="list-group-item"><?php echo $text_register; ?></a> <a href="<?php echo $forgotten; ?>" class="list-group-item"><?php echo $text_forgotten; ?></a>
  <?php } ?>
  <a href="<?php echo $account; ?>" class="list-group-item"><i class="fa fa-user fa-fw"></i>&nbsp;&nbsp;<?php echo $text_account; ?></a>
  <?php if ($logged) { ?>
  <a href="<?php echo $edit; ?>" class="list-group-item"><i class="fa fa-edit fa-fw"></i>&nbsp;&nbsp;<?php echo $text_edit; ?></a> <a href="<?php echo $password; ?>" class="list-group-item"><i class="fa fa-lock fa-fw"></i>&nbsp;&nbsp;<?php echo $text_password; ?></a>
  <?php } ?>
  <a href="<?php echo $address; ?>" class="list-group-item"><i class="fa fa-book fa-fw"></i>&nbsp;&nbsp;<?php echo $text_address; ?></a> <a href="<?php echo $wishlist; ?>" class="list-group-item"><i class="fa fa-heart fa-fw"></i>&nbsp;&nbsp;<?php echo $text_wishlist; ?></a> <a href="<?php echo $order; ?>" class="list-group-item"><i class="fa fa-history fa-fw"></i>&nbsp;&nbsp;<?php echo $text_order; ?></a> <a href="<?php echo $download; ?>" class="list-group-item"><i class="fa fa-download fa-fw"></i>&nbsp;&nbsp;<?php echo $text_download; ?></a> <a href="<?php echo $reward; ?>" class="list-group-item"><i class="fa fa-star fa-fw"></i>&nbsp;&nbsp;<?php echo $text_reward; ?></a> <a href="<?php echo $return; ?>" class="list-group-item"><i class="fa fa-recycle fa-fw"></i>&nbsp;&nbsp;<?php echo $text_return; ?></a> <a href="<?php echo $transaction; ?>" class="list-group-item"><i class="fa fa-dollar fa-fw"></i>&nbsp;&nbsp;<?php echo $text_transaction; ?></a> <a href="<?php echo $newsletter; ?>" class="list-group-item"><i class="fa fa-newspaper-o fa-fw"></i>&nbsp;&nbsp;<?php echo $text_newsletter; ?></a><a href="<?php echo $recurring; ?>" class="list-group-item"><i class="fa fa-refresh fa-fw"></i>&nbsp;&nbsp;<?php echo $text_recurring; ?></a>
  <?php if ($logged) { ?>
  <a href="<?php echo $logout; ?>" class="list-group-item"><i class="fa fa-sign-out fa-fw"></i>&nbsp;&nbsp;<?php echo $text_logout; ?></a>
  <?php } ?>
</div>
