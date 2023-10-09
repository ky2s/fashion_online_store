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
                        <h1 class="text-left"><?php echo $heading_title; ?></h1>
                    </div>
                    <!-- <h1 class="heading"><?php echo $heading_title; ?></h1> -->
                    <div class="font-sonus">                        
                        <p><?php echo $text_error; ?></p>
                    </div>
                    <!-- <div class="buttons">
                        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
                    </div> -->
                    <?php echo $content_bottom; ?>
                </div>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>