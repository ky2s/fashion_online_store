<?php if($related_articles) { ?>
    <h3 class="legend-info"><?php echo $heading_title; ?></h3>
    <?php foreach ($related_articles as $related_article) { ?>
        <ul class="list-unstyled related-article">
            <li>
                <?php 
                $print_article_title = strlen($related_article['article_title']) > 55 ? substr($related_article['article_title'],0,55)."..." : $related_article['article_title'];
                ?>
                <div class="article-image">
                    <img src="<?php echo $related_article['image']; ?>" alt="<?php echo $related_article['article_title']; ?>" />
                    <!-- <i class="fa fa-caret-up"></i> -->
                </div>
                <a href="<?php echo $related_article['article_href']; ?>" class=""><?php echo $print_article_title ; ?></a>
                <span> <?php echo $related_article['article_category']; ?> &bull; <?php echo $related_article['date_added'];?> </span>
            </li>
        </ul>
    <?php } ?>
<?php } ?>


<script type="text/javascript">
    $('#blog-search input[name=\'article_search\']').keydown(function(e) {
        if (e.keyCode == 13) {
            $('#button-search').trigger('click');
        }
    });

    $('#button-search').bind('click', function() {
        url = 'index.php?route=simple_blog/search';
        
        var article_search = $('#blog-search input[name=\'article_search\']').val();
        
        if (article_search) {
            url += '&blog_search=' + encodeURIComponent(article_search);
        }
        
        location = url;
    });
</script> 
