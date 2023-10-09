<div id="cart" class="cart btn-group btn-block">
    <button type="button" data-toggle="dropdown" data-loading-text="<img src='catalog/view/theme/default/image/public/ring.gif' width='20'>" class="btn btn-inverse btn-block btn-lg dropdown-toggle">
        <div class="cov-img display-inline-block">            
            <img src="catalog/view/theme/default/image/public/icon-bag.png" alt="Cart">
        </div>
        <span id="cart-total" class="cart-total"><?php echo $text_items; ?></span>
    </button>

    <ul class="dropdown-menu pull-right cart-ul">        
        <?php if ($products || $vouchers) { ?>
            <li class="header-cart">                
                <h4>Your Cart</h4>
            </li>
            <li class="list-data-cart">
              <table class="table table-striped">

                <?php 
                $total_price = array();
                foreach ($products as $i=>$product) { ?>
                <?php $total_price[] += $product['total'];?>
                <tr class="first">
                    <td class="text-left" width="30%">
                        <?php if ($product['thumb']) { ?>
                            <a href="<?php echo $product['href']; ?>">
                                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" />
                            </a>
                        <?php } ?>
                    </td>
                    <td class="text-left detail-data-cart">
                        <a href="<?php echo $product['href']; ?>"><h5><?php echo $product['name']; ?></h5></a>
                        <?php if ($product['option']) { ?>
                            <?php foreach ($product['option'] as $option) { ?>                          
                            <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                            <?php } ?>
                        <?php } ?>
                        <?php if ($product['recurring']) { ?>                            
                            <small><?php echo $text_recurring; ?>: <?php echo $product['recurring']; ?></small>
                        <?php } ?>
                        
                        <div class="pop-cart">
                            <div class="col-sm-6 no-padding">
                                Qty: <?php echo $product['quantity']; ?>
                            </div>
                            <div class="col-sm-6">
                                <div class="text-right">                                    
                                    <?php echo $product['total']; ?>                                    
                                </div>
                            </div>
                        </div>
                        <button type="button" onclick="cart.remove('<?php echo $product['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs btn-delete-cart">
                            <i class="fa fa-times"></i>
                        </button>
                    </td>
                </tr>
                <?php } ?>

                <?php foreach ($vouchers as $voucher) { ?>
                <tr>
                  <td class="text-center"></td>
                  <td class="text-left"><?php echo $voucher['description']; ?></td>
                  <td class="text-right">x&nbsp;1</td>
                  <td class="text-right"><?php echo $voucher['amount']; ?></td>
                  <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
                </tr>
                <?php } ?>                
              </table>
            </li>
            <li>
                <div class="tprice total-price text-right tprice-pop clearfix">
                    <div class="col-sm-12">                        
                        <?php echo $totals[0]['text'] ?>
                    </div>
                </div>
            </li>
            <li>
              <div>
                <p class="text-right">
                    <a href="<?php echo $cart; ?>" class="btn-to-cart">
                        <strong><?php echo $text_cart; ?></strong>
                    </a>
                </p>
              </div>
            </li>
            <?php } else { ?>
            <li>
                <p class="text-center"><?php echo $text_empty; ?></p>
            </li>
        <?php } ?>
    </ul>
</div>
