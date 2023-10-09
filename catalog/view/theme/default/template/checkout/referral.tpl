
    <div class="form-style-2 no-padding no-margin">     
        <div id="collapse-referral-point" class="panel-collapse collapse in">
            <div class="panel-body no-padding">
                
                <div class="row">
                    <div class="col-sm-8 cov-inpt-coupon">                      
                        <input type="text" name="referral_point" value="<?php echo $referral_point; ?>" placeholder="Referral point" id="input-coupon" class="form-control" />
                    </div>
                    <div class="col-sm-4 cov-btn-coupon">           
                        <input type="button" value="Apply" id="button-referral-point" data-loading-text="<?php echo $text_loading; ?>"  class="btn btn-primary btn-grey btn-referral-point" />
                    </div>
                </div>

                <script type="text/javascript"><!--             
                $('.btn-referral-point').on('click', function() {
                    $.ajax({
                        url: 'index.php?route=checkout/referral/referral',
                        type: 'post',
                        data: 'referral_point=' + encodeURIComponent($('input[name=\'referral_point\']').val()) + '&is_checkout='+$('input[name=\'referral_is_checkout\']').val(),
                        dataType: 'json',
                        beforeSend: function() {
                            // $('#button-coupon').button('loading');
                        },
                        complete: function() {
                            $('#button-coupon').button('reset');
                        },
                        success: function(json) {
                            console.log(json);
                            $('.alert').remove();

                            if (json['error']) {
                                $('.alrt').after('\
                                    <div class="alert alert-danger">\
                                        <i class="fa fa-exclamation-circle"></i> ' + json['error'] + '\
                                    </div>');

                                $('html, body').animate({ scrollTop: 0 }, 'slow');
                            }

                            if (json['redirect']) {
                                location = json['redirect'];
                            }
                        }
                    });
                });
                //--></script>
            </div>
        </div>
    </div>
<!-- </div> -->