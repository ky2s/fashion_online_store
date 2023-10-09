<div id="wrap-banner">
    
    <div id="bannerscollection_zoominout_opportune">
        
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
    </div>


    <script type="text/javascript"><!--        
        $('#bannerscollection_zoominout_opportune').bannerscollection_zoominout({
                skin: 'opportune',
                responsive:true,
                // responsiveRelativeToBrowser: true,
                width: 1920,
                height: 1200,
                width100Proc:true,
                height100Proc:false,
                fadeSlides:1,
                showNavArrows:false,
                showBottomNav:false,
                autoHideBottomNav:false,
                thumbsWrapperMarginTop: -55,
                pauseOnMouseOver:false,
                enableTouchScreen: false,
                // autoPlay: 0,
                // verticalPosition: 'center'
            });        


            // $('.wr-banner<?php echo $module; ?>').owlCarousel({
            //     items: 6,
            //     // autoPlay: 3000,
            //     singleItem: true,
            //     navigation: false,
            //     navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
            //     pagination: false
            // }); 
    --></script>
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