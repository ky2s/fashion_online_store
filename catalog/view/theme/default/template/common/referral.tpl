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

<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/default/stylesheet/opensans.css" rel="stylesheet" type="text/css" />
<link href="catalog/view/theme/default/stylesheet/livesearch.css" rel="stylesheet">
<link href="catalog/view/javascript/bootstrap-select/bootstrap-select.min.css" rel="stylesheet">
<link href="catalog/view/javascript/sweetAlert/sweet-alert.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link href="http://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />

<link href="catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet">
<link href="catalog/view/theme/default/stylesheet/animateWow.css" rel="stylesheet">
<script src="catalog/view/javascript/bootbox.js" type="text/javascript"></script>
<script src="catalog/view/javascript/livesearch.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bootstrap-select/bootstrap-select.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/livesearch.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<script src="catalog/view/javascript/sweetAlert/sweet-alert.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/common.js" type="text/javascript"></script>
<?php echo $google_analytics; ?>
</head>
<body class="<?php echo $class; ?>">
	
	<div id="wr-influencer">
		<ul class="influencer-layout">
			<li class="sec-one" style="background-image: url('catalog/view/theme/default/image/public/referral.jpg');">
				<div class="vertical-align-center text-center">					
					<div class="container">						
						<div class="so-img">						
							<img src="catalog/view/theme/default/image/public/logo-roepi.png" alt="Logo">
							<div class="so-btn">								
								<a href="javascript:;" onclick="$('.join-red').val('join-red');return false;" class="quick_signup ws-nowrap btn-black-influencer">JOIN NOW</a>
								<input class="join-red" type="hidden" name="redirect"></input>
							</div>
						</div>
					</div>
				</div>
			</li>

			<li class="sec-two">
				<div class="container">					
					<h1 class="head-intro">#ThinkEssential</h1>
					<h3 class="sub-head-intro">GET YOUR POINT</h3>					
				</div>
				<div class="cov-point">
					<h2>- How it Works -</h2>

					<div class="list-point">
						<div class="item-point">
							<div class="cov-img">
								<img src="catalog/view/theme/default/image/public/ref-get-link.png" alt="Get Link">
							</div>
							<div class="cov-content">
								<h4>GET YOUR LINK</h4>
								<p>Get your unique link by sign up.</p>
							</div>
						</div>
						<div class="item-point">
							<div class="cov-img">
								<img src="catalog/view/theme/default/image/public/ref-tel-friend.png" alt="Get Link">
							</div>
							<div class="cov-content">
								<h4>TELL A FRIEND</h4>
								<p>Use your link and share to your friends via Facebook, Twitter, Instagram, and Path.</p>
							</div>
						</div>
						<div class="item-point">
							<div class="cov-img">
								<img src="catalog/view/theme/default/image/public/ref-friend-join.png" alt="Get Link">
							</div>
							<div class="cov-content">
								<h4>FRIENDS JOINED</h4>
								<p>Earn points when your friend sign up via your link and make an order.</p>
							</div>
						</div>
						<div class="item-point">
							<div class="cov-img">
								<img src="catalog/view/theme/default/image/public/ref-point.png" alt="Get Link">
							</div>
							<div class="cov-content">
								<h4>POINTS</h4>
								<p>Get your own benefit by using these points.</p>
							</div>
						</div>
					</div>		
				</div>

				<div class="container">					
					<div class="line"></div> 
				</div>
			
			</li>

			<li class="sec-three">
				<div class="wrap-use">
					<div class="container">						
						<h2 class="head-intro">What’s your point for? </h2>
						<h4 class="sub-head-intro">Use your point for shopping on roepistore.com or keep it to reach the highest point for <br> winning the grand prize.   </h4>
					</div>	

					<div class="container">
						<div class="use-list">
							<div class="item-use">
								<a href="javascript:;">									
									<div class="cov-img">
										<img src="catalog/view/theme/default/image/public/go-to-shopping.png" alt="Shopping">
										<h1>SHOPPING</h1>
									</div>
								</a>
							</div>

							<div class="item-use">
								<a href="javascript:;">									
									<div class="cov-img">
										<img src="catalog/view/theme/default/image/public/go-to-destination.png" alt="Shopping">
										<h1>GO TO BALI</h1>
									</div>
								</a>
							</div>
						</div>
					</div>

					<a href="javascript:;" onclick="$('.join-red').val('join-red');return false;" class="quick_signup ws-nowrap btn-black-influencer">JOIN ROEPI</a>
					<input class="join-red" type="hidden" name="redirect"/>		

					<div class="container">					
						<div class="line"></div> 
					</div>	

					<div class="copyright">
						<p>&copy; <?php echo date('Y');?> ROEPI - ALL RIGHT RESERVED</p>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<?php echo $quicksignup; ?>

	<script type="text/javascript">
        $(".input-birth-date" ).datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1950:-8',
            defaultDate : '-8y' 
        });
    </script>
</body>
</html>