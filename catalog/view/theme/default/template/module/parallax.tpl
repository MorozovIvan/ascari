<!-- parallax 
---------------------------------------------------------------->
<div class="box parallax">
 <div class="box-heading"></div>
	<div class="box-content">
		<div id="da-slider_<?php echo $module; ?>" class="da-slider">
			<?php foreach ($products as $product) { ?>
			<div class="da-slide">
			<?php if ($product['thumb']) { ?>
				<div class="da-img"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></div>
			<?php } ?>
				<h2><?php echo $product['name']; ?></h2>
			<?php if ($show_description) { ?>
				<p><?php echo $product['description']; ?></p>
			<?php } ?>
      
			<?php if ($product['price']) { ?>
				<div class="price-container">
					<div class="price">
					<?php if (!$product['special']) { ?>
						<div class="price-all"><?php echo $product['price']; ?></div>
					<?php } else { ?>
						<span class="price-old"><?php echo $product['price']; ?></span>
						<span class="price-new"><?php echo $product['special']; ?></span>
					<?php } ?>
					</div>
				</div>
			<?php } ?>
				<a class="da-link sale btn <?php echo $slider_button; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $text_sale; ?></a>
				<a class="da-link readmore btn <?php echo $slider_button; ?>" href="<?php echo $product['href']; ?>"><?php echo $text_readmore; ?></a>
			</div>
			<?php } ?>
	
			<nav class="da-arrows">
				<span class="da-arrows-prev"></span>
				<span class="da-arrows-next"></span>
			</nav>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function() {
		$('#da-slider_<?php echo $module; ?>').cslider({
		    bgincrement: <?php echo $slider_bgincrement; ?>,
		    autoplay:    <?php echo $slider_autoplay; ?>,
		    interval:    <?php echo $slider_interval; ?>
		});		
	});
	$('.da-slider').css({<?php if ($show_bg) { ?>'background-color':'<?php echo $slider_bg; ?>',<?php } ?> 'background-image':'url(catalog/view/javascript/parallax/images/pattern/<?php echo $slider_pattern; ?>)', 'width':'<?php echo $slider_width; ?>px','height':'<?php echo $slider_height; ?>px', 'color':'<?php echo $slider_tcolor; ?>', 'font-size':'<?php echo $slider_tsize; ?>px'});
	$('.da-slide h2').css({'color':'<?php echo $slider_hcolor; ?>','font-size':'<?php echo $slider_hsize; ?>px'});
	$('.price-container').css({'background-image':'url(catalog/view/javascript/parallax/images/stickers/<?php echo $slider_sticker; ?>)'});
	$('.da-slide .price-new,.da-slide .price-all').css({'color':'<?php echo $sticker_ncolor; ?>'});
	$('.da-slide .price-old').css({'color':'<?php echo $sticker_ocolor; ?>'});
</script>
<!-- /parallax
---------------------------------------------------------------->