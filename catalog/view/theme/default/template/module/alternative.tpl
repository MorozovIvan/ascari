<?php if (!empty($products)) { ?>
<div class="box">
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content">
		<ul id="alternative" class="jcarousel-skin-opencart">
			<?php foreach ($products as $product) { ?>
			<li>
				<?php //Изображение ?>
				<?php if ($product['thumb']) { ?>
				<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
				<?php } ?>
				
				<?php //Название ?>
				<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
				
				<?php //Цена ?>
				<?php if ($product['price']) { ?>
				<div class="price">
					<?php if (!$product['special']) { ?>
					<?php echo $product['price']; ?>
					<?php } else { ?>
					<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
					<?php } ?>
				</div>
				<?php } ?>
                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart-o"></i><?php echo $button_wishlist; ?></a></div>
                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><i class="fa fa-files-o"></i><?php echo $button_compare; ?></a></div>
				<?php //Рейтинг ?>
				<?php if ($product['rating']) { ?>
				<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
				<?php } ?>
                <div class="add-quick-view" data-id="<?php echo $product['product_id']; ?>"></div>

                <?php //Кнопка Купить ?>
				<div class="cart"><a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><span><?php echo $button_cart; ?></span></a></div>
			</li>
			<?php } ?>
		</ul>
	</div>
</div>
<?php //Создание карусели для альтернативных товаров ?>
<script type="text/javascript"><!--
$(document).ready(function(){
$('#alternative').jcarousel({
	vertical: false,
	visible: <?php echo $limit; ?>,
	scroll: 1,
	auto: 3,
	animation: "slow",
	wrap: "both"
});
});
--></script>
<?php } ?>