<?php echo $header; ?>
<div id="center-other-page" class="payment-confirmation">
    <div class="container">
        <div class="intro-padding">
            <div class="title-page-checkout">
                <h2 class="text-left"><?php echo $heading_title; ?></h2>
            </div>

            <?php if (isset($success)) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
            <?php } ?>

            <div class="row">
                <?php echo $column_left; ?>
                <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
                <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
                <?php } ?>

                <div id="content" class="accountContainer <?php echo $class; ?>">
                    <?php echo $content_top; ?>                                                            
                    <form class="form-horizontal form-style-2 no-padding" method="post" action="<?php echo $action; ?>" enctype="multipart/form-data"  >
                        <div class="row">
                            <div class="col-sm-8">
                                <fieldset>                                    
                                    <legend><?php echo $text_bank; ?></legend>
                                    <div class="col-sm-12">                                        
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="user_bank"><?php echo $text_user_bank; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <input id="user_bank" name="user_bank" class="form-control" value="<?php echo $user_bank; ?>" />
                                                <?php if ($error_user_bank) { ?>
                                                <div class="text-danger"><?php echo $error_user_bank; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="user_account"><?php echo $text_user_account; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <input id="user_account" name="user_account" class="form-control" value="<?php echo $user_account; ?>" />
                                                <?php if ($error_user_account) { ?>
                                                <div class="text-danger"><?php echo $error_user_account; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>                                        
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="user_name"><?php echo $text_user_name; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <input id="user_name" name="user_name" class="form-control" value="<?php echo $user_name; ?>" />
                                                <?php if ($error_user_name) { ?>
                                                <div class="text-danger"><?php echo $error_user_name; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>                                        
                                    </div>
                                    
                                </fieldset>
                            </div>

                            <div class="col-sm-8">
                                <fieldset>                                    
                                    <legend><?php echo $text_payment; ?></legend>
                                    <div class="col-sm-12">                                        
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="payment_order"><?php echo $text_payment_order; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <select id="payment_order" name="payment_order" class="form-control" onchange="$('#payment_total').val($(this).find('option:selected').attr('total')); $('#payment_total').autoNumeric('set', $(this).find('option:selected').attr('total'));" >
                                                    <option value="">-- <?php echo $text_select_order; ?> --</option>
                                                    <?php foreach($orders as $item){ ?>
                                                    <option <?php if($payment_order==$item['order_id']) echo 'selected="selected"' ?> total="<?php echo $item['total']; ?>" date="<?php echo $item['payment_date'];?>" value="<?php echo $item['order_id']; ?>"><?php echo $item['label']; ?></option>
                                                    <?php } ?>
                                                </select>
                                                <?php if ($error_payment_order) { ?>
                                                <div class="text-danger"><?php echo $error_payment_order; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="payment_bank"><?php echo $text_payment_bank; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <select id="payment_bank" name="payment_bank" class="form-control" >
                                                    <option value="">-- <?php echo $text_select_bank; ?> --</option>
                                                    <?php foreach($payment_banks as $item){ ?>
                                                    <option <?php if($payment_bank==$item['code']) echo 'selected="selected"' ?> value="<?php echo $item['code']; ?>"><?php echo str_replace('Transfer via','',$item['title'])." - {$item['accountname']} - {$item['accountno']}" ?></option>
                                                    <?php } ?>
                                                </select>
                                                <?php if ($error_payment_bank) { ?>
                                                <div class="text-danger"><?php echo $error_payment_bank; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>                                        
                                    </div>
                                    <div class="col-sm-12">                                        
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="payment_total"><?php echo $text_payment_total; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <input id="payment_total" name="payment_total" class="form-control" value="<?php echo $payment_total; ?>" />
                                                <?php if (isset($error_payment_total)) { ?>
                                                <div class="text-danger"><?php echo $error_payment_total; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12">
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="payment_date"><?php echo $text_payment_date; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <!-- <div class="input-group date"> -->
                                                    <input type="text" name="payment_date" id="payment_date" class="form-control input-birth-date-pay-conf" value="<?php echo $payment_date; ?>" readonly autocomplete="off"/>
                                                    <!-- <span class="input-group-btn">
                                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                                    </span> -->
                                                <!-- </div> -->
                                                <?php if ($error_payment_date) { ?>
                                                <div class="text-danger"><?php echo $error_payment_date; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>                                        
                                    </div>
                                    
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="payment_memo"><?php echo $text_payment_memo; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <textarea maxlength="36" id="payment_memo" name="payment_memo" class="form-control" ><?php echo $payment_memo ?></textarea>
                                                <?php if ($error_payment_memo) { ?>
                                                <div class="text-danger"><?php echo $error_payment_memo; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div> 
                                    </div>
                                    <div class="col-sm-12">                                        
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="file_upload">File Upload</label>
                                            <div class="col-sm-7 no-padding">
                                                <input type="file" id="file_upload" name="file_upload" class="form-control"/>
                                                <?php if ($error_file_upload) { ?>
                                                <div class="text-danger"><?php echo $error_file_upload; ?></div>
                                                <?php } ?>
                                                <div>Recommended format file : jpeg/jpg, png or pdf.</div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- <div class="col-sm-12">
                                        <div class="required form-group">
                                            <label class="col-sm-5 control-label" for="payment_captcha"><?php echo $text_payment_captcha; ?></label>
                                            <div class="col-sm-7 no-padding">
                                                <input id="payment_captcha" name="captcha" class="form-control" />
                                                <br />
                                                <img class="pull-right" src="index.php?route=tool/captcha" alt="" />
                                                <?php if ($error_captcha) { ?>
                                                <div class="text-danger"><?php echo $error_captcha; ?></div>
                                                <?php } ?>
                                            </div>
                                        </div>                                 
                                    </div>     -->    
                                </fieldset>
                            </div>
                        </div>
                        <div class="row">  
                            <div class="col-sm-8">
                                <div class="col-sm-12"> 
                                    <div class="buttons clearfix">
                                        <!-- <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div> -->
                                        <div class="text-center">
                                            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary btn-grey" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript"><!--

$('input[name=user_account]').numeric();
$('select[name=payment_order]').on('change', function(){
    if($(this).val() == ''){
        $(".input-birth-date-pay-conf" ).attr('disabled', true);
    }else{
        var val = $(this).find('option:selected').attr('date');
        $(".input-birth-date-pay-conf" ).removeAttr('disabled');        
        $(".input-birth-date-pay-conf").datepicker("destroy");
        $(".input-birth-date-pay-conf" ).datepicker({
            onSelect: function () {
               $(this).val(this.value);
            },
            changeMonth: true,
            changeYear: true,
            minDate : -val,
            maxDate: 0
        });    

        $(".input-birth-date-pay-conf").datepicker( "refresh" );
    }

});

$(document).ready(function(){
    $("#payment_order").trigger("change");
});

$('.date').datetimepicker({
  pickTime: false
});

$('.time').datetimepicker({
  pickDate: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});
//--></script> 