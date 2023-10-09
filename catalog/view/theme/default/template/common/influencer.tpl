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
			<li class="sec-one">
				<div class="vertical-align-center">
					<h1>ROEPI</h1>
					<a href="javascript:;" class="btn-grey-influencer">JOIN NOW</a>
				</div>
			</li>

			<li class="sec-two">
				<h2>High Quality, Low Markups</h2>
				<p>Here's how we do it.</p>
				<ul>
					<li>We work with the best factories around the world–the very same ones that produce your favorite designer labels.</li>
					<li>We source and design everything in-house and cut out unnecessary middlemen.</li>
					<li>By being online only, we eliminate brick-and-mortar expenses and pass these savings on to you.</li>
				</ul>
				<a href="javascript:;" class="btn-black-influencer">JOIN ROEPI</a>
			</li>

			<li class="sec-three">
				<!-- catalog/view/theme/default/image/public -->
				<ul class="sec-content">
					<li><img src="catalog/view/theme/default/image/public/Insta-1.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-2.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-3.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-4.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-5.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-6.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-7.jpg" alt=""></li>
					<li><img src="catalog/view/theme/default/image/public/Insta-8.jpg" alt=""></li>
				</ul>
			</li>

			<li class="sec-four">
				<div class="sec-content">				
					<img src="catalog/view/theme/default/image/public/desktop-news.png" alt="">
				</div>
			</li>

			<li class="sec-five">
				<div class="sec-content">
					<h1>We Sell Exclusively To You</h1>
					<h4>In traditional retail, a designer shirt is marked up <br> 8x by the time it reaches the customer. <br>We do things differently.</h4>
					<img src="catalog/view/theme/default/image/public/desktop-transparency.png" alt="">
					<a href="javascript:;" class="btn-grey-influencer">JOIN ROEPI</a>
				</div>
			</li>
		</ul>
	</div>

</body>
</html>