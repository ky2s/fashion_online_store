<footer>
  <div class="container">
    <div class="row">
      <?php if ($informations) { ?>
      <div class="col-sm-3">
        <h5><?php echo $text_information; ?></h5>
        <ul class="list-unstyled">
          <?php foreach ($informations as $information) { ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <div class="col-sm-3">
        <h5><?php echo $text_service; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_extra; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="col-sm-3">
        <h5><?php echo $text_account; ?></h5>
        <ul class="list-unstyled">
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
    </div>
    <hr>
    <p class="powered">
      <?php echo $powered; ?>
      <span class="socmed">
          <?php if($facebook) { ?>
          <a class="btn" href="http://facebook.com/<?php echo $facebook; ?>" target="_blank"><i class="fa fa-facebook"></i></a>
          <?php } ?>
          <?php if($twitter) { ?>
          <a class="btn" href="http://twitter.com/<?php echo $twitter; ?>" target="_blank"><i class="fa fa-twitter"></i></a>
          <?php } ?>            
          <?php if($instagram) { ?>
          <a class="btn" href="http://instagram.com/<?php echo $instagram; ?>" target="_blank"><i class="fa fa-instagram"></i></a>
          <?php } ?>
      </span>
    </p> 
  </div>
</footer>


<div id="sticky">
  <div class="voucher open" data-state="open">
      <span class="minimize"><i class="fa fa-minus"></i></span>      
      <div class="left">
        <div class="nikmati">Nikmati</div>
        <div class="potongan">potongan</div>
        <div class="rp"><?php echo $symbolLeft;?></div>
        <div class="value"><?php echo $couponValue;?></div>
        <div class="bottom">saat Anda mendaftarkan NEWSLETTER kami</div>
      </div>
      <div class="right">
        <input type="email" name="email_newsletter" id="email_newsletter" maxlength="100" class="form-control" required placeholder="masukan email Anda disini" />
        
        <div class="btn-group btn-block" data-action="<?php echo $action_newsletter; ?>">
          <button class="btn" id="wanita" name="gender" value="2" type="submit">WANITA</button>
          <button class="btn" id="pria" name="gender" value="1" type="submit">PRIA</button>
        </div>
      </div>
      <div class="clearfix"></div>
  </div>
</div> 

</body></html>