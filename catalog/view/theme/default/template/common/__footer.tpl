<footer>
    <div class="container">
        <div class="row">            
            <div class="intro-padding no-margin">
                <?php if ($help_informations) { ?>
                <div class="col-sm-2 col-xs-4 col-md-2">
                    <div class="menu-foot">
                        <h5>HELP</h5>
                        <ul>
                            <?php foreach ($help_informations as $information) { ?>
                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                            <?php } ?>
                            
                            <?php if ($isLogged) { ?>
                                <li><a href="payment-confirmation" class="ws-nowrap">Payment Confirmation</a></li>
                                <li><a href="<?php echo $refund_url ?>" class="ws-nowrap">Refund</a></li>
                            <?php }else{?>
                                <li><a href="#" onclick="$('#payment-confirmation-red').val('payment-confirmation');return false;" class="quick_signup ws-nowrap">Payment Confirmation</a>
                                    <input id="payment-confirmation-red" type="hidden" name="redirect"></input>
                                </li>
                                <li><a href="#"  onclick="$('#refund-red').val('refund-red');return false;"  class="quick_signup ws-nowrap">Refund</a>
                                    <input id="refund-red" type="hidden" name="redirect"></input>
                                </li>
                            <?php } ?>                            
                            <!-- <li><a href="<?php echo $blog_url ?>" class="ws-nowrap">Blog</a></li> -->
                        </ul>
                    </div>
                </div>
                <?php } ?>
                <?php if ($company_informations) { ?>
                <div class="col-sm-2 col-xs-4 col-md-2">
                    <div class="menu-foot">
                        <h5>COMPANY</h5>
                        <ul>
                            <?php foreach ($company_informations as $information) { ?>
                            <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                            <?php } ?>
                        </ul>
                    </div>
                </div>
                <?php } ?>
                <div class="col-sm-2 col-xs-4 col-md-2">
                    <div class="menu-foot">
                        <h5>CONNECT</h5>
                        <ul>
                            <!-- <li><a href="javascript:;">Blog</a></li> -->
                            <?php
                            if($social_media){
                            foreach($social_media as $i=>$sm){
                            if($sm){?>
                            <li><a href="<?php echo $sm ?>" target="_balank" style="text-transform: capitalize;"><?php echo $i ?></a></li>
                            <?php }}}?>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12 col-md-6">
                    <div class="row">                        
                        <?php if(!$isLogged){ ?>
                        <div class="col-sm-12 col-xs-12 col-md-8">
                            <div class="subscribe-caption">
                                <h3>Sign up for early access to our next collection.</h3>
                                <a class="btn-grey quick_signup" >Join Now</a>
                            </div>
                        </div>
                        <?php }else{?>
                        <div class="col-sm-12 col-xs-12 col-md-8">
                            <div class="subscribe-caption in">
                                <h3>Refer a friend. Earn $25 credit when they purchase.</h3>
                                <input type="text" readonly="" value="https://www.everlane.com/r/lenimariati">
                            </div>
                        </div>
                        <?php }?>
                        <div class="col-sm-12 no-padding wr-copyright col-xs-12 col-md-4">
                            <div class="copyright">
                                &copy; <?php echo date('Y');?> Roepi - All Rights Reserved
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<div id="back-top">
    <a href="javascript:;">
        <img src="catalog/view/theme/default/image/back-top.png" alt="">
        <div class="hov-back-top">Back to top</div>
    </a>
</div>

<script type="text/javascript">
    $(".input-birth-date" ).datepicker({
        onSelect: function () {
           $('.input-birth-date').val(this.value);
        },
        changeMonth: true,
        changeYear: true,
        yearRange: '1950:-8',
        defaultDate : '-8y'  
    });
</script>

<script>   
    $(document).ready(function(){
        $("input[name=telephone]").numeric();
        $("input[name=postcode]").numeric();
        // $("input[name=amount]").numeric();
        $("input[name=account_number]").numeric();

        //FORMAT NUMBER
        $('#amount, input[name=payment_total]').autoNumeric("init",{
            aSep: '.',
            aDec: ',', 
            aSign: 'Rp. '
        });
        //END FORMAT NUMBER 
    });

    $(function(){
        $('#back-top a').on('click', function(){
            $('html, body').animate({scrollTop: 0}, 1000);
        });

        $(window).scroll(function(){
            if($(window).scrollTop() > 1000){
                $('#back-top').fadeIn();
            }else{
                $('#back-top').fadeOut();                
            }
        });
    });
</script>

<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','https://connect.facebook.net/en_US/fbevents.js');

fbq('init', '249405715402606');
fbq('track', "PageView");</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=249405715402606&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->

<!-- Chatra {literal} -->
<script>
window.ChatraSetup = {
    chatWidth: 320,
    colors: {
        buttonText: '#fff', // chat button text color
        buttonBg: '#000',    // chat button background color
    }
};
</script>
<script>
    ChatraID = '2hQYbihZfZHPpPiJm';
    (function(d, w, c) {
        var n = d.getElementsByTagName('script')[0],
            s = d.createElement('script');
        w[c] = w[c] || function() {
            (w[c].q = w[c].q || []).push(arguments);
        };
        s.async = true;
        s.src = (d.location.protocol === 'https:' ? 'https:': 'http:')
            + '//call.chatra.io/chatra.js';
        n.parentNode.insertBefore(s, n);
    })(document, window, 'Chatra');
</script>
<!-- /Chatra {/literal} -->

</body>
</html>