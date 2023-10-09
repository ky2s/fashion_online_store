<div class="row">
    <div class="col-sm-12 frm-checkout frm-login-checkout">
        <h1><?php echo $text_returning_customer; ?></h1>
        <!-- <p><?php echo $text_i_am_returning_customer; ?></p> -->
        <div class="form-group">
            <label class="control-label" for="input-email"><?php echo $entry_email; ?></label>
            <input type="text" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
        </div>
        <div class="form-group">
            <label class="control-label" for="input-password"><?php echo $entry_password; ?></label>
            <input type="password" name="password" value="" placeholder="<?php echo $entry_password; ?>" id="input-password" class="form-control" />            
        </div>
        <div class="form-group">                
            <input type="button" value="<?php echo $button_login; ?>" id="button-login" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
        </div>
        <div class="form-group text-left no-margin">
            <ul class="quest-modal">
                <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>                
            </ul>            
        </div>
    </div>
</div>
    
    <hr/>
<div class="row">
    <div class="col-sm-12">
        <h1><?php echo $text_new_customer; ?></h1>
        <!-- <p><?php echo $text_checkout; ?></p> -->
        <div class="radio-inline display-none">
            <label>
                <?php if ($account == 'register') { ?>
                <input type="radio" name="account" value="register" checked="checked" />
                <?php } else { ?>
                <input type="radio" name="account" value="register" checked="checked" />
                <?php } ?>
                <?php echo $text_register; ?>
            </label>
        </div>
        <?php if ($checkout_guest) { ?>
        <div class="radio-inline display-none">
            <label>
                <?php if ($account == 'guest') { ?>
                <input type="radio" name="account" value="guest" checked="checked" />
                <?php } else { ?>
                <input type="radio" name="account" value="guest" />
                <?php } ?>
                <?php echo $text_guest; ?>
            </label>
        </div>
        <?php } ?>
        <p><?php echo $text_register_account; ?></p>
        
        <div class="form-group">            
            <input type="button" value="<?php echo $button_continue; ?>" id="button-account" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary btn-grey" />
        </div>
    </div>

    
</div>

<script>
    $('.frm-login-checkout input').on('keydown', function(e) {
        if (e.keyCode == 13) {
            $('.frm-login-checkout #button-login').trigger('click');
        }
    });

    // $('.frm-login-checkout input').on('keydown', function(e) {
    //     if (e.keyCode == 13) {
    //         $('.frm-login-checkout #button-login').trigger('click');
    //     }
    // });
</script>