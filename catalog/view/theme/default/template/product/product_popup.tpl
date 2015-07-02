<div class="box_popup">
	<a id="close_popup"></a>
	<div class="pop_up_content">
		<h1><?=$name;?></h1>
		<div class="left_popup">
			<div class="ul_img_mini">
				<ul>
					<?php foreach ($images as $image) {?>
						<li>
							<a href="<?=$image['popup_zoom']?>" class="cloud-zoom-gallery" rel="useZoom: 'zoom1', smallImage: '<?=$image['popup']?>' ">
								<img class="zoom-tiny-image" src="<?=$image['thumb']?>" />
							</a>
						</li>
					<?php } ?>
				</ul>
			</div>
			<?php if ($price) { ?>
				<div class="price">
					<span class="text-price"><?php echo $text_price; ?></span>
					<?php if (!$special) { ?>
						<?php echo $price; ?>
					<?php } else { ?>
						<span class="price-new"><?php echo $special; ?></span> <span class="price-old"><?php echo $price; ?></span>
					<?php } ?>
					<?php if ($discounts) { ?>
						<div class="discount">
							<?php foreach ($discounts as $discount) { ?>
								<?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
							<?php } ?>
						</div>
					<?php } ?>
				</div>
			<?php } ?>
			<?php if ($options) { ?>
				<div class="options" style="margin-top:10px;">
					<h2><?=$text_option;?></h2>
					<?php foreach ($options as $option) { ?>
					<?php if ($option['type'] == 'select') { ?>
						<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
							<?php if ($option['required']) { ?>
								<span class="required">*</span>
							<?php } ?>
							<b><?php echo $option['name']; ?>:</b><br />
							<select name="option[<?php echo $option['product_option_id']; ?>]">
								<option value=""><?php echo $text_select; ?></option>
								<?php foreach ($option['option_value'] as $option_value) { ?>
									<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
									<?php if ($option_value['price']) { ?>
										(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
									<?php } ?>
									</option>
								<?php } ?>
							</select>
						</div>
						<br />
					<?php } ?>
					<?php if ($option['type'] == 'radio') { ?>
						<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
							<?php if ($option['required']) { ?>
							<span class="required">*</span>
							<?php } ?>
							<b><?php echo $option['name']; ?>:</b><br />
							<?php foreach ($option['option_value'] as $option_value) { ?>
								<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
								<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
								<?php if ($option_value['price']) { ?>
									(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
								<?php } ?>
								</label>
								<br />
							<?php } ?>
						</div>
						<br />
					<?php } ?>
					<?php if ($option['type'] == 'checkbox') { ?>
						<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
							<?php if ($option['required']) { ?>
								<span class="required">*</span>
							<?php } ?>
							<b><?php echo $option['name']; ?>:</b><br />
							<?php foreach ($option['option_value'] as $option_value) { ?>
								<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
								<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
								<?php if ($option_value['price']) { ?>
								(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
								<?php } ?>
								</label>
								<br />
							<?php } ?>
						</div>
						<br />
					<?php } ?>
					<?php if ($option['type'] == 'image') { ?>
						<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
						<?php if ($option['required']) { ?>
						<span class="required">*</span>
						<?php } ?>
						<b><?php echo $option['name']; ?>:</b><br />
						<table class="option-image">
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<tr>
						<td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
						<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
						<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</label></td>
						</tr>
						<?php } ?>
						</table>
						</div>
						<br />
					<?php } ?>
					<?php if ($option['type'] == 'text') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
					</div>
					<br />
					<?php } ?>
					<?php if ($option['type'] == 'textarea') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
					</div>
					<br />
					<?php } ?>
					<?php if ($option['type'] == 'file') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<a id="button-option-<?php echo $option['product_option_id']; ?>" class="button"><span><?php echo $button_upload; ?></span></a>
					<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
					</div>
					<br />
					<?php } ?>
					<?php if ($option['type'] == 'date') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
					</div>
					<br />
					<?php } ?>
					<?php if ($option['type'] == 'datetime') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
					</div>
					<br />
					<?php } ?>
					<?php if ($option['type'] == 'time') { ?>
					<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
					</div>
					<br />
					<?php } ?>
					<?php } ?>
				</div>
			<?php } ?>
			<div class="cart">
				<div class="prod-row">
					<div class="cart-top">
						<div class="cart-top-padd">
							<label><?php echo $text_qty; ?></label>
							<input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
							<input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
							<?php if ($minimum > 1) { ?>
								<div class="minimum"><?php echo $text_minimum; ?></div>
							<?php } ?>
						</div>
						<a id="button-cart" class="button"><span><?=$button_cart;?></span></a>
					</div>
				</div>
			</div>
			<?php if (!empty($description)) { ?>
			<div class="description">
				<div class="title_desc"><?=$tab_description;?>:</div>
				<?=$description;?>
			</div>
			<?php } ?>
		</div>
		<div class="right_popup">
			<div class="big_img">
				<a href="<?=$images[0]['popup_zoom']?>" class = "cloud-zoom" id="zoom1" rel="position: 'inside' , showTitle: false, adjustX:-4, adjustY:-4">
					<img src="<?=$images[0]['popup']?>" />
				</a>
			</div>
			<div class="link_more">
				<a class="button" href="<?=$link;?>"><span><?=$button_continue;?></span></a>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				$('.success').fadeIn('slow');
				$('#cart-total').html(json['total']);
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
	},
	onComplete: function(file, json) {
		$('.error').remove();
		if (json.success) {
			alert(json.success);
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json.file);
		}
		if (json.error) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json.error + '</span>');
		}
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>