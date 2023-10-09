<?php echo $header; ?>
<div id="center-other-page" class="payment-confirmation">
	<div class="container">
		<div class="intro-padding">
			<div class="title-page-checkout">
				<h2 class="text-left"><?php echo $refund; ?></h2>
			</div>

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

                	<form class="form-horizontal form-style-2 no-padding no-margin" method="post" action="<?php echo $action ?>" enctype="multipart/form-data"  >
                		<div class="row">
                			<div class="col-sm-12">
                				<p>
                					We are sad that you have to return your ROEPI :(
                                    <br>
                                    Hopefully we can serve you better next time :)
                                </p>
                			</div>
                			<div class="col-sm-12">
            					<p>
                                    <span class="display-block">                                        
                                        Fill this form to get shipping fee refund
                                    </span>
                                    <span>                                        
            						  Max refund: 30,000
                                    </span>
                                                                        
            					</p>
            				<br>
            				</div>
                			<div class="col-sm-9 col-xs-12">                				                				
                				<div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Order ID</label>
                                        <div class="col-sm-8 no-padding">
                                            <select name="order_id" id="order_id" class="form-control">
                                                <option value="">-- Order ID --</option>
                                                <?php foreach($orders as $item){ ?>
                                                <option value="<?php echo $item['order_id'] ?>" <?php echo ($item['order_id'] == $order_id)? 'selected' : '' ?> amount="<?php echo $item['total'] ?>" email="<?php echo $item['email'] ?>"><?php echo $item['label'] ?></option>
                                                <?php }?>
                                            </select>   

                                            <?php if ($error_order_id) { ?>
                                            <div class="text-danger"><?php echo $error_order_id; ?></div>
                                            <?php } ?>
                                            
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Email</label>
                                        <div class="col-sm-8 no-padding">
                                            <input id="email" name="email" class="form-control" value="<?php echo $email ?>" placeholder="youremail@website.com"/>
                                            
                                            <?php if ($error_email) { ?>
                                            <div class="text-danger"><?php echo $error_email; ?></div>
                                            <?php } ?>
                                            
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Amount</label>
                                        <div class="col-sm-8 no-padding">
                                            <input id="amount" name="amount" class="form-control" value="<?php echo $amount ?>" placeholder="Maximum claim amount Rp. 100.000,-"/>
                                            
                                            <?php if ($error_amount) { ?>
                                            <div class="text-danger"><?php echo $error_amount; ?></div>
                                            <?php } ?>
                                            
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Resi</label>
                                        <div class="col-sm-8 no-padding">
                                            <input type="file" id="" name="attachment_file" class="form-control" value="" />
                                           
                                            <?php if ($error_attachment_file) { ?>
                                            <div class="text-danger"><?php echo $error_attachment_file; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Refund reason</label>
                                        <div class="col-sm-8 no-padding">
                                            <textarea id="" name="reason" rows="3" class="form-control"/></textarea>
                                            
                                            <?php if ($error_reason) { ?>
                                            <div class="text-danger"><?php echo $error_reason; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Name</label>
                                        <div class="col-sm-8 no-padding">
                                            <input id="" name="account_name" class="form-control" value="<?php echo $account_name ?>" placeholder="Full name"/>
                                            
                                            <?php if ($error_account_name) { ?>
                                            <div class="text-danger"><?php echo $error_account_name; ?></div>
                                            <?php } ?>

                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Bank Name</label>
                                        <div class="col-sm-8 no-padding">
                                            <input id="" name="account_bank" class="form-control" value="<?php echo $account_bank ?>" placeholder="Bank name"/>

                                            <?php if ($error_account_bank) { ?>
                                            <div class="text-danger"><?php echo $error_account_bank; ?></div>
                                            <?php } ?>
                                            
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-12">                                        
                                    <div class="required form-group">
                                        <label class="col-sm-4 control-label" for="">Account Number</label>
                                        <div class="col-sm-8 no-padding">
                                            <input id="" name="account_number" class="form-control" value="<?php echo $account_number ?>" placeholder="Account number"/>
                                            
                                            <?php if ($error_account_number) { ?>
                                            <div class="text-danger"><?php echo $error_account_number; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                </div>
                			</div>                			

							<div class="col-sm-3">
								<div class="img-refund">									
									<img src="catalog/view/theme/default/image/refund-img.png" alt="Refund" class="img-responsive">
								</div>
							</div>
                		</div>

                		<div class="row">                			
                			<div class="col-sm-12">
            					<p>
                                    We won’t released any of your personal information to other parties. For further information read: <a href="http://www.roepistore.com/privacy-policy/" target="_blank">http://www.roepistore.com/privacy-policy/</a>
            					</p>
            				</div>
                		</div>

                		<div class="row">  
                            <div class="col-sm-12">
                                <div class="col-sm-12"> 
                                    <div class="buttons clearfix">                                        
                                        <div class="text-center">
                                            <input type="submit" value="SEND" class="btn btn-primary btn-grey" />
                                        </div>
                                        <br><br>
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

<script type="text/javascript">
    $(document).ready(function() {
        $('#order_id').change(function(){
            $('#amount').val($(this).find('option:selected').attr('amount'));
            $('#email').val($(this).find('option:selected').attr('email'));

            //FORMAT NUMBER
            $('#amount').autoNumeric("set", $(this).find('option:selected').attr('amount'));
            //END FORMAT NUMBER 
        });
    });
    //onchange="$('#amount').val($(this).find('option:selected').attr('amount'))"
</script>
<?php echo $footer; ?>