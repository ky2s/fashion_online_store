<div id="wrap-banner">
    
    <!-- <div id="bannerscollection_zoominout_opportune">
        
        <ul class="bannerscollection_zoominout_list">
            <?php foreach ($banners as $banner) { ?>
            <li data-initialZoom="0.77" data-finalZoom="1" data-horizontalPosition="center" data-verticalPosition="center">
                <?php if ($banner['link']) { ?>
                    <a href="<?php echo $banner['link']; ?>">                        
                        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" width="2500" height="1570" />
                    </a>
                <?php } else { ?>
                    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" width="2500" height="1570" />
                <?php } ?>  
            </li>
            <?php } ?>           
        </ul>          
    </div> -->


    <div id="slick-banner">
        <?php foreach ($banners as $banner) { ?>
            <div class="item-slick-banner">
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"/>
            </div>
        <?php } ?>
    </div>
    <script type="text/javascript"><!-- 
        $("#slick-banner").slick({
            fade: true,
            cssEase: 'linear',
            dots: false,
            arrows: false,
            infinite: true,
            speed: 1800,
            autoplaySpeed: 6000,
            autoplay: true,
            pauseOnFocus:false,
            pauseOnHover:false
        });      
    </script>
</div>

<!-- <div id="list-banner" class="owl-caraousel wr-banner<?php echo $module; ?>">
    <?php foreach ($banners as $banner) { ?>
        <div class="item-banner">
            <?php if ($banner['link']) { ?>
                <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"/></a>                    
            <?php } else { ?>                  
                <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"/>
            <?php } ?>            
        </div>        
    <?php } ?>            
</div> -->