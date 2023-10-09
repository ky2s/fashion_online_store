<?php echo $header; ?>
<div id="center-other-page">   
    
    <?php if($banner){?>
        <div class="banner-page">
            <img src="<?php echo $banner ?>" alt="Category Woman">
        </div>
    <?php }?>

    <div class="container">        
        <div class="row">  

            <!-- left content -->          
            <?php echo $column_left; ?>

            <!-- class -->
            <?php if ($column_left && $column_right) { ?>
                <?php $class = 'col-sm-6'; ?>
            <?php } elseif ($column_left || $column_right) { ?>
                <?php $class = 'col-sm-9'; ?>
            <?php } else { ?>
                <?php $class = 'col-sm-12'; ?>
            <?php } ?>

            <!-- content -->
            <div id="content" class="<?php echo $class; ?>" data-sticky_parent>
                <?php echo $content_top; ?>
                <?php if($heading_title){ ?><h1 class="heading"><?php echo $heading_title; ?></h1><?php } ?>                            

                <?php echo $description; ?>                 
                

                <?php if($social_media){ ?>
                <div class="col-sm-12">                    
                    <div class="medsos">                    
                        <ul>
                            <?php foreach($social_media as $sm){ ?>
                            <li><a href="<?php echo $sm['link'] ?>" target="_blank"><i class="<?php echo $sm['icon'] ?>"></i></a></li>
                            <?php }?>
                        </ul>
                    </div>
                </div>
                <?php }?>

                <?php echo $content_bottom; ?>
            </div>

            <!-- right content -->  
            <?php echo $column_right; ?>
        </div>     
    </div> 

    <script>
        $.fn.superResize = function(){            
            $(document).ready(function(){
                $(document).resizeNow();

                 $('.menu-intro-padding ul li a').on('click', function(){
                    var attr = $(this).attr('data-id');
                    var headerHeight = $('header').height() + parseInt(40);
                    $('html, body').animate({scrollTop: $('#'+attr).offset().top - parseInt(headerHeight)}, 200);
                });


                // FACTORIES
                $('.slider-page').slick({
                    arrows: true,
                    dots: false,
                    autoplay: true,
                    prevArrow: '<i class="icon-left-open-big arr-left" aria-hidden="true"></i>',
                    nextArrow: '<i class="icon-right-open-big arr-right" aria-hidden="true"></i>'

                });
                // FACTORIES

                // HTO
                $('.wr-slide-hto').slick({
                    arrows: true,
                    dots: false,
                    autoplay: false,
                    infinite: false,
                    asNavFor: '.step-hto',
                    prevArrow: '<i class="icon-left-open-big arr-left" aria-hidden="true"></i>',
                    nextArrow: '<i class="icon-right-open-big arr-right" aria-hidden="true"></i>',

                });

                $('.step-hto').slick({
                    arrows: false,
                    dots: false,
                    autoplay: false,
                    infinite: false,
                    slidesToShow: 8,
                    slidesToScroll: 1,
                    variableWidth: true,
                    // centerMode: true,
                    focusOnSelect: true,
                    asNavFor: '.wr-slide-hto',
                });
                // HTO


                // FAQ
                jQuery.expr[':'].Contains = function(a, i, m) {
                    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
                };

                jQuery.expr[':'].contains = function(a, i, m) {
                    return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
                };

                $('#txt-faq-search').keyup(function(){
                    var sSearch = this.value;
                    if(sSearch){
                        sSearch = sSearch.split(" ");                       
                        $('.list-faq > .item-faq li.question').hide();
                        $.each(sSearch, function(i){                            
                            $('.list-faq .item-faq li.question:contains("' + sSearch[i] + '")').show();
                            console.log(sSearch[i]);
                        });
                      }else{
                        $('.list-faq > .item-faq li.question').show();
                    }
                });
                
                $('li.question').on('click',function(){
                    if($(this).children().next().hasClass('show')){
                        $(this).children().next().stop().slideUp();
                        $(this).children().next().removeClass('show');
                        $(this).children().removeClass('active');
                    }else{
                        $(this).children().next().stop().slideDown();
                        $(this).children().next().addClass('show');
                        $(this).children().addClass('active');
                    }
                })
                // FAQ
            });

            $(window).resize(function(){                            
                $(document).resizeNow();
            });
        }

        $.fn.resizeNow = function(){
            var windowWidth = $(window).width();
            if(windowWidth < 992){                
                $("[data-sticky_column]").trigger("sticky_kit:detach");
            }else{
                // STICKY
                $("[data-sticky_column]").stick_in_parent({
                  parent: "[data-sticky_parent]",
                  offset_top : $('header').outerHeight() - parseInt(50)
                });
                // STICKY 
            }
        }

        $(document).superResize();

    </script>
</div>
<?php echo $footer; ?> 