<!-- HTML UNTUK CONTACT US -->
<!-- <div class="intro-padding-left col-sm-2">
    <div class="menu-intro-padding">
        <ul>
            <li>
                <p>FIND US</p>
                <h2 class="article-title font-vani">Contact</h2>
            </li>
        </ul>
    </div>
</div>

<div class="intro-padding-right col-sm-10">
    <form action="" method="post">
        
    </form>
</div> -->
<!-- HTML UNTUK CONTACT US -->

<?php echo $header; ?>
<div id="center-other-page">
    <div class="container">
        
        <div class="intro-padding no-padding">            
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
                    <div class="row">
                        
                        <div class="col-sm-3">   
                            <span class="font-sonus letter-2">FIND US</span>  
                            <h2 class=""><?php echo $heading_title; ?></h2>
                        </div>

                        <div class="col-sm-9 wr-form-contact">                        
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <fieldset>
                                    <p class="font-sonus">
                                        We are humbled by your interest in our website and product. As Essentialist, we promise you: we will get better everyday <br> in the mean time, How we can help you?
                                    </p>

                                    <div class="row wr-list-office">
                                        <div class="col-sm-4 cov-article">
                                            <h4 class="article-title font-sonus no-margin">HEAD OFFICE</h4>
                                            
                                            <p>
                                                Jalan Professor Dr Latumenten, Komplek Grogol Permai Blok A No. 5-6
                                            </p>
                                            <p>
                                                <a href="tel:+62 21 56601399">+62 21 56601399</a>
                                                <a href="mailto:customer@roepi-Indonesia.com">customer@roepi-Indonesia.com</a>
                                            </p>
                                        </div>
                                        <div class="col-sm-4 cov-article">
                                            <h4 class="article-title font-sonus no-margin">CUSTOMER SERVICE</h4>                                            
                                            <p>
                                                <span class="display-block">Line : @roepi(use@) </span>
                                                <span>WA/TEL : </span><a href="tel:+628118628879" class="display-inline-block important">+628118628879</a>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12 text-center">
                                            <p>
                                                Or fill this contact form: <?=$aff_data?>
                                            </p>
                                        </div>
                                    </div>

                                    <!-- SUCCESS MESSAGE -->
                                    <p><?php echo (isset($message)) ? $message : '' ?></p>

                                    <!-- <h3><?php //echo $text_contact; ?></h3> -->
                                    <p class="font-sonus">
                                        Please fill in the contact form data below so that we may contact you to give you the information we need.
                                    </p>
                                    <br>

                                    <div class="form-group required">
                                        <div class="col-sm-6">
                                            <input type="text" name="name" value="<?php echo $name; ?>" placeholder="Name" id="input-name" class="form-control" />
                                            <?php if ($error_name) { ?>
                                                <div class="text-danger"><?php echo $error_name; ?></div>
                                            <?php } ?>
                                        </div>
                                        <div class="col-sm-6">
                                            <input type="text" name="email" value="<?php echo $email; ?>" placeholder="Email" id="input-email" class="form-control" />
                                            <?php if ($error_email) { ?>
                                                <div class="text-danger"><?php echo $error_email; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>

                                    <div class="form-group required">
                                        <div class="col-sm-12">
                                            <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
                                            <?php if ($error_enquiry) { ?>
                                                <div class="text-danger"><?php echo $error_enquiry; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>

                                    <div class="col-sm-8 no-padding">
                                        <?php if ($error_captcha) { ?>
                                            <div class="text-danger"><?php echo $error_captcha; ?></div>
                                        <?php } ?>
                                        <div class="g-recaptcha" data-sitekey="6LfEjCITAAAAACIiyF9xBjt_M-7ShsO3P3u50eCL"></div>
                                    </div>

                                    <div class="col-sm-4 text-right no-padding">
                                        <div class="">
                                          <button class="btn btn-primary btn-grey" type="submit"><?php echo $button_submit; ?></button>
                                        </div>
                                    </div>
                                </fieldset>                            
                            </form>
                        </div>
                    </div>
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<script src='https://www.google.com/recaptcha/api.js'></script>
<?php echo $footer; ?>
