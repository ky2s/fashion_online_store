<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        
        <div class="intro-padding">
        
            <div class="row">
                <?php echo $column_left; ?>
                <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
                <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
                <?php } ?>
                <div id="content" class="<?php echo $class; ?>">
                    <?php echo $content_top; ?>
                    <div class="title-page-checkout">
                        <h2 class="text-left"><?php echo $heading_title; ?></h2>
                    </div>
                    <!-- <h1 class="heading"><?php echo $heading_title; ?></h1> -->

                    <div class="article-success font-sonus">
                        <?php //echo $payment_detail1 ?>
                    </div>


                    <div class="article-success font-sonus">                        
                        <?php echo $text_message_success; ?>

                        <div class="well well-sm well-success">                            
                            <div class="article-success font-sonus">
                                <?php echo $payment_logo ?>
                            </div>
                            <div class="article-success font-sonus no-margin">
                                <b><?php echo $text_accountno; ?></b><?php echo $payment_number ?>
                            </div>
                            <div class="article-success font-sonus no-margin">
                                <b><?php echo $text_accountname; ?></b><?php echo $accountname ?>
                            </div>
                        </div>

                        <?php echo $text_message; ?>
                    </div>
                    
                    <div class="buttons clearfix">
                        <div class="pull-right">
                            <a href="<?php echo $continue; ?>" class="btn btn-primary btn-grey"><?php echo $button_continue; ?></a>
                        </div>
                    </div>

                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>

    </div>
</div>
<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
document,'script','https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '249405715402606');
fbq('track', 'PageView');
fbq('track', 'Purchase', {value: '0.00', currency:'IDR'});
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=249405715402606&ev=PageView&noscript=1"
/></noscript>
<!-- DO NOT MODIFY -->
<!-- End Facebook Pixel Code -->

<?php echo $footer; ?>