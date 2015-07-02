<div class="box">
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <div class="box-product">
        <ul id="platest" class="jcarousel-skin-opencart">
            <?php foreach ($products as $product) { ?>
            <li class="product-block">
                <?php if ($product['thumb']) { ?>
                <div class="image"><?php echo $product['sticker']; ?><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
                <?php } ?>
                <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                <?php if ($product['price']) { ?>
                <div class="price">
                    <?php if (!$product['special']) { ?>
                    <?php echo $product['price']; ?>
                    <?php } else { ?>
                    <span class="price-old"><?php echo $product['price']; ?></span><br /><span class="price-new"><?php echo $product['special']; ?></span>
                    <?php } ?>
                </div>
                <?php } ?>
                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i><?php echo $button_wishlist; ?></a></div>
                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><i class="fa fa-files-o"></i><?php echo $button_compare; ?></a></div>
                <div class="rating">
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                    <?php if ($product['rating'] < $i) { ?>
                    <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                    <?php } else { ?>
                    <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                    <?php } ?>
                    <?php } ?>
                </div>
                <div class="add-quick-view" data-id="<?php echo $product['product_id']; ?>"></div>
                <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
            </li>
            <?php } ?>
        </ul>
    </div>
  </div>
</div>

<script type = "text/javascript">

    $(document).ready(function () {

        $('#platest').jcarousel({
            vertical: false,
            visible: 3,
            scroll: 1,
            animation: "slow"
        });

    });


</script>