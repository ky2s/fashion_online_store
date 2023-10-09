<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
    <!--<![endif]-->
    <head>
        <!-- Go Online Solusi Web Development | www.gositus.com | www.facebook.com/gositus | http://twitter.com/gositus -->
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />
        <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
        <meta name="keywords" content= "<?php echo $keywords; ?>" />
        <?php } ?>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="X-UA-Compatible" content="IE=9" />
        <?php if ($icon) { ?>
        <link href="<?php echo $icon; ?>" rel="shortcut icon" />
        <link rel="apple-touch-icon" href="<?php echo HTTP_SERVER.'image/'; ?>favicon-32x32.png">
        <link rel="apple-touch-icon" sizes="76x76" href="<?php echo HTTP_SERVER.'image/'; ?>favicon-76x76.png">
        <link rel="apple-touch-icon" sizes="120x120" href="<?php echo HTTP_SERVER.'image/'; ?>favicon-120x120.png">
        <link rel="apple-touch-icon" sizes="152x152" href="<?php echo HTTP_SERVER.'image/'; ?>favicon-152x152.png">
        <?php } ?>
        <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
        <link href="catalog/view/theme/default/stylesheet/fonts.css" rel="stylesheet">
        <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
        <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
        <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/wow.min.js" type="text/javascript"></script>
        <!-- <script src="catalog/view/javascript/kenburn/kenburn.js" type="text/javascript"></script> -->
        <script src="catalog/view/javascript/slidezoomin/bannerscollection_zoominout.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/slidezoomin/touch-punch.min.js" type="text/javascript"></script>

        <link href="catalog/view/javascript/slidezoomin/bannerscollection_zoominout.css" rel="stylesheet" type="text/css" />
        <link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="catalog/view/javascript/fontello/fontello.css" rel="stylesheet" type="text/css" />
        <link href="catalog/view/theme/default/stylesheet/opensans.css" rel="stylesheet" type="text/css" />
        <link href="catalog/view/theme/default/stylesheet/livesearch.css" rel="stylesheet">
        <link href="catalog/view/javascript/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">
        <link href="catalog/view/javascript/sweetAlert/sweet-alert.css" rel="stylesheet">

        <link href="catalog/view/javascript/slick/slick.css" rel="stylesheet">
        <link href="catalog/view/javascript/slick/slick-theme.css" rel="stylesheet">

        <!-- <link href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" type="text/css" rel="stylesheet" media="screen" />
        <link href="catalog/view/javascript/jquery/owl-carousel/owl.theme.css" type="text/css" rel="stylesheet" media="screen" /> -->
        <!-- <link href="catalog/view/javascript/jquery/owl-carousel/animate.css" type="text/css" rel="stylesheet" media="screen" /> -->
        <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
        <link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
        <link href="catalog/view/theme/default/stylesheet/animateWow.css" rel="stylesheet">
        <script src="catalog/view/javascript/bootbox.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/livesearch.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/livesearch.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/jquery.numeric.min.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/autoNumeric.js" type="text/javascript"></script>
        
        <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
        <?php } ?>

        <script src="catalog/view/javascript/slick/slick.js" type="text/javascript"></script>

        <script src="catalog/view/javascript/sweetAlert/sweet-alert.min.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/common.js" type="text/javascript"></script>

        <!-- <script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.js" type="text/javascript"></script> -->
        <?php echo $google_analytics; ?>

        <script type="text/javascript">

            $.fn.superSetResize = function(){
                $(document).ready(function(){
                    $("img").hide().not(function() {
                        return this.complete && $(this).fadeIn();
                    }).bind("load", function(){ $(this).fadeIn(); });

                    $(document).setResize();

                    $('.wrap-menu-mobile li').on('click', function(){
                        if($(this).hasClass('li-parent')){
                            if($(this).children().next().next().hasClass('act-dropdown')){
                                $(this).children().next().next().stop().slideUp();
                                $(this).children().next().removeClass('open');
                                $(this).children().next().next().removeClass('act-dropdown');
                            }else{
                                $('.wrap-menu-mobile li.li-parent').children().next().next().removeClass('act-dropdown');
                                $('.wrap-menu-mobile li.li-parent').children().next().next().stop().slideUp();
                                $('.wrap-menu-mobile li.li-parent').children().next().removeClass('open');
                                $(this).children().next().next().stop().slideDown();
                                $(this).children().next().addClass('open');
                                $(this).children().next().next().addClass('act-dropdown');
                            }
                        }else{
                            return true;
                        }
                    });

                    var heightMenuMobile = $('header').outerHeight();
                    $('.mobile-header .show-list-menu, .mobile-header .dropdown-menu').css({'height': $(window).height() - parseInt(heightMenuMobile)});
                    $('.mobile-header .show-list-menu, .mobile-header .dropdown-menu').css({'margin-top' : $('.mobile-header.home').outerHeight()});

                    $('#menu-burger').on('click', function(){            
                        if($(this).hasClass('open')){
                            $(this).removeClass('open');
                            $('.mobile-header .show-list-menu').stop().fadeOut();
                            $('body').css({'overflow':'scroll'});
                        }else{
                            $(this).addClass('open');
                            $('.mobile-header .show-list-menu').stop().fadeIn();
                            $('body').css({'overflow':'hidden'});
                        }
                    });

                    wow = new WOW(
                        {
                         mobile: true
                        } 
                      )
                    wow.init();

                });

                $(window).load(function(){
                    var slickBanner = $('#slick-banner').outerHeight();  
                    $('#wrap-banner').css({'height' : slickBanner});
                    $('#center-content').css({'margin-top' : slickBanner + parseInt($('.mobile-header.home').outerHeight())});
                })

                $(window).resize(function(){
                    $(document).setResize();
                    var slickBanner = $('#slick-banner').outerHeight();  
                    $('#wrap-banner, #slick-banner').css({'height' : $('#slick-banner .item-slick-banner img').outerHeight()});
                    $('#center-content').css({'margin-top' : slickBanner + parseInt($('.mobile-header.home').outerHeight())});
                    // console.log('ini langsung');
                });
            }

            $.fn.setResize = function(){
                var windowWidth = $(window).width();
                
                var windowHeight = $(window).height();
                var canvasHeight = $('#wrap-banner').height();
                var headerHeight = $('header').outerHeight();
                var offsetHeader = $('header').offset().top || '';   
                var slickBanner = $('#slick-banner').outerHeight();
                                    

                if(windowWidth < 992){
                
                    $('header').css({'margin-top': 0});                    
                    $('#wrap-banner').css({'margin-top': $('.mobile-header.home').outerHeight()});
                    $('#modal-quicksignup .modal-content').css({'height': $(window).height()});

                    // $('#wrap-banner').css({'height' : slickBanner});
                    // $('#center-content').css({'margin-top' : slickBanner + parseInt($('.mobile-header.home').outerHeight())});
                    // console.log('ini dari if');
                }else{
                
                    $('#wrap-banner, .item-slick-banner').css({'height':windowHeight - headerHeight});                    
                    $('header').css({'margin-top': - headerHeight});
                    $('#wrap-banner').css({'margin-top': '0'});   
                    $('#modal-quicksignup .modal-content').css({'height': 'auto'});
                    $('#center-content').css({'margin-top' : windowHeight - parseInt(headerHeight)});
                
                }

                // if(windowWidth > 1144){
                //     $('#center-content').css({'margin-top' : windowHeight - parseInt(headerHeight)});
                // }
               


                $(window).scroll(function(){                
                    if($(window).width() < 992){            
                        return false;
                    }else{            
                        if($(window).scrollTop() >= (offsetHeader - headerHeight) ){
                            $('header').css({
                                'position':'fixed',
                                'top': '0',
                                'margin-top':'0',
                                'border-bottom': 'thin solid #ddd',
                                'padding': '10px 0'
                            },200);

                            $('header').animate({},500);
                        }else{
                            $('header').css({
                                'position':'absolute',
                                'top': '100%',
                                'margin-top': - headerHeight,
                                'border-bottom': 'none',
                                'padding' : '10px 0'
                            });
                        }
                    }         
                });
            }

            $(document).superSetResize();
        </script>
    </head>
    <body class="<?php echo $class; ?>">
        
        <header class="home">
            <div class="container"><h3 class="freeship">Free Shipping Seluruh Indonesia</h3>
            <!-- <a type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">X</a> -->
            </div>

            <div class="container">
                <div class="row header-desktop">
                    <div class="col-sm-3">
                        <?php if ($logo) { ?>
                        <a href="<?php echo $home; ?>" id="logo"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                        <?php } else { ?>
                        <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                        <?php } ?>
                    </div>
                    <div class="col-sm-6">
                        <?php if ($categories) { ?>
                        <div id="wrap-menu">
                            <ul class="parent">
                                <?php foreach ($categories as $category) { ?>
                                <?php if ($category['children']) { ?>
                                <li>
                                    <i class="icon-drop"></i>
                                    <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                    <div class="dropdown">

                                        <!-- LEVEL 2 -->
                                        <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                                        <?php foreach ($children as $child) { ?>
                                        <div class="col-sm-4">
                                            <h4><a href="<?= $child['href']?>"><?= $child['name']?></a></h4>
                                            <ul class="child">
                                                <!-- LEVEL 2 -->
                                                <?php foreach (array_chunk($child['children'], ceil(count($child['children']) / $child['column'])) as $child_last) { ?>
                                                <?php foreach ($child_last as $c) { ?>
                                                    <li><a href="<?= $c['href']?>"><?= $c['name']?></a></li>
                                                <?php }?>
                                                <?php }?>  
                                            </ul>
                                        </div>
                                        <?php }?>
                                        <?php }?>
                                    </div>
                                </li>
                                <?php }else{?>
                                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                                <?php }?>
                                <?php }?>
                                <!-- Page -->
                                <li><a href="<?php echo $factories ?>">Factories</a></li>
                                <li><a href="<?php echo $about ?>">About Us</a></li>
                            </ul>
                        </div>
                        <?php }else{?>
                        <div id="wrap-menu">
                            <ul class="parent">
                                <li><a href="<?php echo $factories ?>">Factories</a></li>
                                <li><a href="<?php echo $about ?>">About Us</a></li>
                            </ul>
                        </div>
                        <?php }?>
                        
                    </div>
                    <div class="col-sm-3">
                        <div id="menu-right">
                            <ul class="right">
                                <?php if ($logged) { ?>
                                <li>
                                    <a href="<?php echo $account; ?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $text_account_is_login; ?></a>
                                    <ul class="dropdown-menu dropdown-menu-right dropdown-acc">
                                        <li><a href="<?php echo $account ?>">My Account</a></li>
                                        <li><a href="<?php echo $password ?>">Password</a></li>
                                        <li><a href="<?php echo $address ?>">Address Books</a></li>
                                        <li><a href="<?php echo $order ?>">Order History</a></li>     
                                        <li><a href="<?php echo $payment_confirmation ?>">Payment Confirmation</a></li>     
                                        <li><a href="<?php echo $transaction ?>">Referral</a></li>                              
                                        <li><a href="<?php echo $logout ?>">Logout</a></li>
                                    </ul>
                                </li>
                                <?php }else{?>
                                <li class="quick-login"><a href="login" onclick="return false" class="quick_signup">Sign Up</a></li>
                                <li class="quick-login"><a href="login" onclick="return false" class="quick_signup">Log In</a></li>
                                <?php }?>
                                <li class="cov-cart"><?php echo $cart; ?></li>
                                <input type="hidden" value="<?=$rc?>" id="rc">
                            </ul>
                            
                        </div>
                    </div>
                </div>
            </div>           
        </header>

        <?php echo $quicksignup; ?>
        
        <!-- MODAL POPUP -->
        <?php if($banners){?>  
        <div id="popup-banner" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="slick-popup-banner">

                    <?php foreach($banners as $banner){?>
                        <?php if($banner['link']){ ?>
                            <div class="item-slick-pop-banner">                                
                                <a href="<?php echo $banner['link'] ?>" target="_blank">
                                    <img src="<?php echo $banner['image'] ?>" >
                                    
                                    <div class="caption">
                                        <h4><?php //echo $banner['title'] ?></h4>
                                    </div>
                                </a>
                            </div>
                        <?php }else{?>
                            <div class="item-slick-pop-banner">                                
                                <img src="<?php echo $banner['image'] ?>" >
                                
                                <div class="caption">
                                    <h4><?php //echo $banner['title'] ?></h4>
                                </div>
                            </div>
                        <?php }?>
                    <?php }?>
                </div> 
                <button type="button" class="close banner-btn-close" data-dismiss="modal">&times;</button>

            </div>
        </div>
        <?php }?>

        <style>
            .banner-btn-close{
                background: #d1d3d4 !important;
                position: absolute;
                top: 0;
                right: 0;
                opacity: 1;
                color: #FFF !important;
                padding: 9px 12px 8px !important;
                margin: 0;
                font-family: 'Sonus-Light';
                -webkit-transition-duration: 0.3s;
                -moz-transition-duration: 0.3s;
                -ms-transition-duration: 0.3s;
                -o-transition-duration: 0.3s;
                transition-duration: 0.3s;
            }
            
            .banner-btn-close:hover{
                background: #000 !important;
                opacity: .8 !important;
            }
        </style>

        <script type="text/javascript">
            
        </script>
        <!-- //MODAL POPUP -->

        <!-- MOBILE HEADER -->
        <div class="mobile-header home">
            <!-- <img data-lazy="catalog/view/theme/default/image/public/ring.gif"> -->
            <div class="container"><h3 class="freeship">Free Shipping Seluruh Indonesia</h3></div>
            <div class="container">                
                <div class="row">
                    <div class="col-md-2 col-xs-2">
                        <div id="menu-burger">
                          <span></span>
                          <span></span>
                          <span></span>
                          <span></span>
                          <span></span>
                          <span></span>
                        </div>
                    </div>
                    <div class="col-md-8 col-xs-6 col-xs-offset-1">
                        <?php if ($logo) { ?>
                            <a href="<?php echo $home; ?>" id="logo"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
                        <?php } else { ?>
                            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
                        <?php } ?>
                    </div>
                    <div class="col-md-2 col-xs-3">
                        <div class="cart-mobile float-right">                                
                            <?php echo $cart; ?>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>

                <div class="show-list-menu">
                    <?php if ($categories) { ?>
                        <div id="wrap-menu" class="wrap-menu-mobile clearfix">                            
                            <div class="col-xs-12">                                
                                <ul class="parent">
                                    <?php foreach ($categories as $category) { ?>
                                    <?php if ($category['children']) { ?>
                                    <li class="li-parent">                                            
                                        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                                        <i class="icon-arrow"></i>
                                        <div class="dropdown">

                                            <!-- LEVEL 2 -->
                                            <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / $category['column'])) as $children) { ?>
                                            <?php foreach ($children as $child) { ?>
                                            <div class="col-sm-12 col-xs-12 col-md-4">
                                                <!-- <div class="row">                                                 -->
                                                    <h4><?= $child['name']?></h4>
                                                    <ul class="child">
                                                        <!-- LEVEL 2 -->
                                                        <?php foreach (array_chunk($child['children'], ceil(count($child['children']) / $child['column'])) as $child_last) { ?>
                                                        <?php foreach ($child_last as $c) { ?>
                                                            <li><a href="<?php echo $c['href'] ?>"><?= $c['name']?></a></li>
                                                        <?php }?>
                                                        <?php }?>  
                                                    </ul>
                                                <!-- </div> -->
                                            </div>
                                            <?php }?>
                                            <?php }?>
                                        </div>
                                    </li>
                                    <?php }else{?>
                                    <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
                                    <?php }?>
                                    <?php }?>
                                    <!-- Page -->
                                    <li><a href="<?php echo $factories ?>">Factories</a></li>
                                    <li><a href="<?php echo $about ?>">About Us</a></li>
                                </ul>
                            </div>
                        </div>
                        <?php if ($logged) { ?>
                            <div class="menu-mobile-acc">
                                <h5><?php echo $text_account_is_login; ?></h5>
                                <ul>
                                    <li><a href="<?php echo $account; ?>">My Account</a></li>                                    
                                    <li><a href="edit-password">Password</a></li>
                                    <li><a href="address-book">Address Books</a></li>
                                    <li><a href="order">Order History</a></li>   
                                    <li><a href="payment-confirmation">Payment Confirmation</a></li>                                 
                                    <li><a href="logout">Logout</a></li>
                                </ul>
                            </div>
                        <?php }else{ ?>
                            <div class="menu-mobile-acc clearfix">
                                <div class="col-xs-12">
                                    <a href="login" onclick="return false" class="quick_signup btn btn-grey btn-primary display-block">SIGN IN</a>
                                </div>
                            </div>
                        <?php } ?>
                    <?php }?>
                </div>
            </div>
        </div>    
        <!-- MOBILE HEADER -->
        <script type="text/javascript">
            $(".input-birth-date" ).datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: '1950:-8',
                defaultDate : '-8y' 
            });
        </script>

        <script type="text/javascript">
            $(document).ready(function(){                
                
                $('.slick-popup-banner').slick({
                    autoplay:false,
                    dots: false,
                    infinite: true,
                    speed: 1800,
                    autoplaySpeed: 5000,
                    fade: true,
                    cssEase: 'linear',
                    arrows:true,
                    prevArrow: '<i class="icon-left-open-big arr arr-left" aria-hidden="true"></i>',
                    nextArrow: '<i class="icon-right-open-big arr arr-right" aria-hidden="true"></i>',           
                });
                

                setTimeout(function() {
                    $('#popup-banner').modal('show');
                }, 2000);
                
                $('.slick-popup-banner').slick('slickPlay');
                
            });

            $(window).load(function(){
                       
            });
        </script>