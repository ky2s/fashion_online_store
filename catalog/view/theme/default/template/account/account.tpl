<?php echo $header; ?>
<div id="center-other-page">
    
    <div class="container">
        <div class="intro-padding">

            <div class="title-page-checkout">
                <h1 class="text-left">Profile</h1>
            </div>

            <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
            <?php } ?>
          
            <?php if ($error) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?></div>
            <?php } ?>
          
            <div class="row">
                <div class="list-account">                    
                    <?php echo $column_left; ?>
                </div>
                
                <?php if ($column_left && $column_right) { ?>
                    <?php $class = 'col-sm-6'; ?>
                <?php } elseif ($column_left || $column_right) { ?>
                    <?php $class = 'col-sm-9'; ?>
                <?php } else { ?>
                    <?php $class = 'col-sm-12'; ?>
                <?php } ?>

                <div id="content" class="accountContainer <?php echo $class; ?>">
                    <?php echo $content_top; ?>
                    
                    <?php echo $content_bottom; ?>

                </div>

                <?php echo $column_right; ?>            
            </div>

        </div>
    </div>

</div>

<script>
    $('.list-account .col-sm-3').removeClass('col-sm-3').addClass('col-sm-12');
</script>
<?php echo $footer; ?>