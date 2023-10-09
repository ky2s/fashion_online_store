<?php if($categories) { ?>
    <div class="intro-padding-left " id="module-left" data-sticky_column>
        <div class="menu-intro-padding">
            <ul>
                <?php foreach ($categories as $category) { ?>
                    
                    <?php if ($category['simple_blog_category_id'] == $category_id) { ?>
                        <li><a href="<?php echo $category['href'] ?>" data-id="categories" class="active"><?php echo $category['name'] ?></a></li>
                    <?php }else{?>
                        <li><?=$get_category?><a href="<?php echo $category['href'] ?>" data-id="categories" class=""><?php echo $category['name'] ?></a></li>
                    <?php }?>
                <?php }?>
            </ul>
        </div>

        <?php if($archives){ ?>       
            
            <div class="recent-post archiv">

                <h3>Archived </h3>
                <div class="archived">
                    <?php foreach($archives as $archive){ ?>
                        <ul class="year">
                            <li>
                                <a href="javascript:;"><i class="fa fa-angle-right"></i><?php echo $archive['year'] ?> (<?php echo $archive['total'] ?>)</a>
                                <ul class="month">
                                    <?php if($archive['months']){ ?>
                                        <?php foreach($archive['months'] as $month){ ?>
                                            <li><a href="<?php echo $month['url'] ?>"><?php echo $month['month_name'] ?> (<?php echo $month['total'] ?>)</a></li>
                                        <?php }?>
                                    <?php }?>
                                </ul>
                            </li>
                        </ul>
                    <?php }?>
                </div>
                
            </div>
            
        <?php }?>
        
    </div>
<?php } ?>