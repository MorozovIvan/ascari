<div class="products-row row">
<!-- IO Slider -->
			<div id="io-slider" class="io-slider">
			<?php foreach ($products as $product) { ?>
				<div class="io-slide">
					<a href="<?php echo $product['href']; ?>"><h2><?php echo $product['name']; ?></h2></a>
					<p><?php echo mb_substr($product['description'], 0, 170);?> ...</p>
					<span class="io-price io-link">
					<?php if ($product['price']) { $this->language->load('product/product');?>
					<?php echo $this->language->get('text_price'); ?>
					<?php if (!$product['special']) { ?>
					<?php echo $product['price']; ?>
					<?php } else { ?>
					<del> <?php echo $product['price']; ?></del> <?php echo $product['special']; ?>
					&nbsp;
					<?php }?>
					<?php }?>
					</span>
					<?php if ($product['rating']) { ?>
					<span class="io-rating io-link">
					<script>  for (var j=0;j<5-<?php echo $product['rating']; ?>;j++) { document.write("<i class='fa fa-star-o'></i>"); }for (var i=0;i<<?php echo $product['rating']; ?>;i++) { document.write("<i class='fa fa-star'></i>"); } </script>
					</span>
					<?php }?>
					<a href="javascript:addToCart('<?php echo $product['product_id']; ?>');" title="<?php echo $button_cart; ?>" class="io-link"><i class="fa fa-shopping-cart"></i> <?php echo $button_cart; ?></a>
					<?php if ($product['thumb']) { ?>
					<div class="io-img"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></div>
					<?php }?>
				</div>			
			<?php }?>	
				<nav class="io-arrows">
					<span class="io-arrows-prev"><i class="fa fa-arrow-circle-o-left" ></i></span>
					<span class="io-arrows-next"><i class="fa fa-arrow-circle-o-right" ></i></span>
				</nav>
			</div>
        </div>
			<script type="text/javascript">
			$(function() {
			
				$('.io-slider').iolider({
					autoplay	: true,
					bgincrement	: 450
				});
			
			});
		</script>		
		<!-- /IO Slider -->

