<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
    <?php if($i+1<count($breadcrumbs)) { ?><?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a><?php } ?>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>

	<div>
	  <table style="width: 100%; border-collapse: collapse;">
		<tr>
			<td align="left"><a style="text-decoration:none;" href="<?php echo $prev_url; ?>"><?php echo $prev_text;  ?></a>&nbsp; &nbsp; &nbsp;<a style="text-decoration:none;" href="<?php echo $next_url; ?>"><?php echo $next_text;?></a></td>
		</tr>
	  </table>
	</div>
	<br />

  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><?php echo $sticker; ?><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
        <?php if ($review_status) { ?>
        <div class="review">
            <div>
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($rating < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
                &nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
            <div class="pluso" data-background="transparent" data-options="small,round,line,horizontal,nocounter,theme=04" data-services="vkontakte,odnoklassniki,moimir,facebook,twitter,google"></div>
        </div>
        <?php } ?>
        <?php if ($price) { ?>
        <div class="price"><?php echo $text_price; ?>
            <?php if (!$special) { ?>
            <?php echo $price; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
            <?php } ?>
            <br />
            <?php if ($tax) { ?>
            <!--<span class="price-tax"><?php //echo $text_tax; ?> <?php //echo $tax; ?></span><br />-->
            <?php } ?>
            <?php if ($points) { ?>
            <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
            <?php } ?>
            <?php if ($discounts) { ?>
            <br />
            <div class="discount">
                <?php foreach ($discounts as $discount) { ?>
                <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                <?php } ?>
            </div>
            <?php } ?>
        </div>
        <?php } ?>
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
      <!--  <span><?php //echo $text_model; ?></span> <?php //echo $model; ?><br /> -->
          <?php if ($sku) { ?>
          <span><?php echo $text_sku; ?></span> <?php echo $sku; ?>
          <?php } ?>
          <br/>
          <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div>
      <?php if ($profiles): ?>
      <div class="option">
          <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
          <br />
          <select name="profile_id">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($profiles as $profile): ?>
              <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
              <?php endforeach; ?>
          </select>
          <br />
          <br />
          <span id="profile-description"></span>
          <br />
          <br />
      </div>
      <?php endif; ?>
      <?php if ($options) { ?>
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
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
            <div class="option-wrap">
                <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
                <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                    <?php if ($option_value['price']) { ?>
                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                    <?php } ?>
                </label>
            </div>
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
          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
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
        <div><?php echo $text_qty; ?>
          <input type="number" name="quantity" min="0" size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;
          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
          <span>&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;</span>
          <span class="links"><i class="fa fa-heart-o"></i> <a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
            <i class="fa fa-files-o"></i> <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></span>
        </div>
		
		<?php if ($benefits) { ?>
		<div class="present">
			<?php foreach ($benefits as $benefit) { ?>	
				<?php if ($benefit['type'] == 0) { ?>
					<div>
						<?php if (!$benefit['link']) { ?>
						   <span class="thumb"><img src="<?php echo $benefit['thumb']; ?>" alt="<?php echo $benefit['name']; ?>" /></span>
						<?php } else { ?> 
						   <a href="<?php echo $benefit['link']; ?>" target="_blank" title="<?php echo $benefit['name']; ?>"><span class="thumb"><img src="<?php echo $benefit['thumb']; ?>" alt="<?php echo $benefit['name']; ?>" /></span></a>
						<?php } ?>
					</div>
				<?php } ?> 
			<?php } ?>
		</div>
		<?php } ?>
		
		<?php if ($benefits) { ?>
		<div class="benefits">
		<div><?php echo $text_benefits; ?></div>
		<ul class="benefit">
		<?php foreach ($benefits as $benefit) { ?>	
			<?php if ($benefit['type'] == 1) { ?>
				<li>
					<?php if (!$benefit['link']) { ?>
					   <span class="thumb"><img src="<?php echo $benefit['thumb']; ?>" alt="<?php echo $benefit['name']; ?>" /></span>
					<?php } else { ?> 
					   <a href="<?php echo $benefit['link']; ?>" target="_blank" title="<?php echo $benefit['name']; ?>"><span class="thumb"><img src="<?php echo $benefit['thumb']; ?>" alt="<?php echo $benefit['name']; ?>" /></span></a>
					<?php } ?>
					<?php if ($benefit['description']) { ?>
						<div class="benefit_description"><?php echo $benefit['description']; ?></div>
					<?php } ?>
				</li>
			<?php } ?> 
		<?php } ?>
		</ul>
		</div>
		<?php } ?>
		
		
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
    </div>			
  </div>
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
      <?php if (true) { ?>
    <a href="#tab-sizes"><?php echo $tab_size; ?></a>
    <a href="#tab-shipping" class="tab-shipping"><?php echo $tab_shipping; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
   <!-- <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
	<?php if ($products2) { ?>
    <a href="#tab-related2"><?php echo $tab_related2; ?> (<?php echo count($products2); ?>)</a>
    <?php } ?> -->
	<?php if ($articles) { ?>
    <a href="#tab-articles"><?php echo $tab_blog_related; ?> (<?php echo count($articles); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content">
  <?php echo $description; ?>
  <?php require_once(DIR_SYSTEM . 'library/user.php');
  $this->registry->set('user', new User($this->registry));
  if ($this->user->isLogged()) { $userLogged = true; } else { $userLogged = false;} if ($userLogged) { ?>
  <div class="edit">
  <a class="button" target="_blank" href="/admin/index.php?route=catalog/product/update&token=<?php echo $this->session->data['token']; ?>&product_id=<?php echo $product_id; ?>"><?php echo $button_edit_product; ?></a>
  </div>
  <?php } ?>
  </div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
    <?php if ($attribute_groups) { ?>
    <div id="tab-sizes" class="tab-content">
        <div class="product-tabs-content tabs-content std" id="product_tabs_athlete_custom_tab1_contents"><p>&nbsp;</p>
            <table border="1">
                <tbody>
                <tr>
                    <td rowspan="2">
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Русский размер</span></p>
                    </td>
                    <td rowspan="2">
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Английский размер (UK)</span></p>
                    </td>
                    <td colspan="2">
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Американский размер (US)</span></p>
                    </td>
                    <td rowspan="2">
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Европейский размер (EUR)</span></p>
                    </td>
                    <td rowspan="2">
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Длина ступни, в см</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Мужские</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">Женские</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">34,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">3,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">4</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">36</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">23</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">35,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">4</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">4,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">36 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">23,0...23,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">36</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">4,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">37 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">23,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">36,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">38</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">24</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">37</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">5,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">38 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">24,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">38</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">39 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">25</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">38,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">6,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">40</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">25,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">39</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">40 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">25,5...26,0</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">40</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">7,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">41 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">26</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">40,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">42</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">26,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">41</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">8,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">42 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">27</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">42</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">43 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">27,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">43</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">9,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">44</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">28</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">43,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">44 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">28,0...28,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">44</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">10,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">45 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">28,5...29,0</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">44,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">46</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">29</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">45</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">11,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">46 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">29,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">46</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">47 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">30</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">46,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">12,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">14</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">48</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">30,5</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">47</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">14,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">48 2/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">31</span></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">48</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">13,5</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">14</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">15</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">49 1/3</span></p>
                    </td>
                    <td>
                        <p align="center"><span style="font-family: 'book antiqua', palatino; font-size: medium;">31,5</span></p>
                    </td>
                </tr>
                </tbody>
            </table>
            <p>&nbsp;</p></div>
    </div>
    <?php } ?>
    <div id="tab-shipping" class="tab-content">
        <?php echo $shipping_description; ?>
    </div>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    
			<div id="review">
    		 <?php if ($reviews_array) { ?>
                <?php foreach ($reviews_array as $review) { ?>
                <div class="review-list">
                  <div class="author">
				  <b><?php echo $review['author']; ?></b> <?php echo $text_on; ?> <?php echo $review['date_added']; ?>
				  <?php if ($review['purchased'] == 1) { ?>
					<img src="image/man-with-cart2.png" alt="<?php echo $review['author']; ?> купил(а) этот товар в нашем магазине" title="<?php echo $review['author']; ?> купил(а) этот товар в нашем магазине" width="14px" height="11px" />
				  <?php } ?>
				  </div>
                  <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $review['rating'] . '.png'; ?>" alt="<?php echo $review['reviews']; ?>" /></div>
                  <br/>
    		<?php if ($review['good']) { ?>
			<br/>
			<div class="plus"><?php echo preg_replace("/\s\s+/", "<br>", $review['good']); ?></div>
			<?php } ?>
			<?php if ($review['bads']) { ?>
			<br/>
			<div class="minus"><?php echo preg_replace("/\s\s+/", "<br>", $review['bads']); ?></div>
			<?php } ?>
			<?php if ($review['text']) { ?>
			<br/>
			<div class="text"><?php echo preg_replace('/\s\s+/', "<br>", $review['text']); ?></div>
			<?php } ?>
            <?php if ($review['addimage']) { ?>
            <div class="addimage"><a href="<?php echo $review['addimage']; ?>" class="colorbox"><img src="<?php echo $review['addimage']; ?>" style="max-width:150px;max-height:100px;" /></a></div>
            <?php } ?>
            <?php if ($review['answer']) { ?>
    		<br/><div class="answer" style="margin-left: 25px; padding: 5px; background: #F7F4EA; font-style: italic;"><?php echo '<b>'.$text_answer.'</b> '.preg_replace('/\s\s+/', "<br>", $review['answer']); ?></div>
			<?php } ?>
			<div class="vot_updown2" id="vt_<?php echo $review['review_id']; ?>_<?php echo $review['product_id']; ?>_<?php echo $review['rating']; ?>"></div>
                </div>
                <?php } ?>
                <div class="pagination"><?php echo $pagination; ?></div>
                <?php } else { ?>
                <div class="content"><?php echo $text_no_reviews; ?></div>
                <?php } ?>
			</div>
            
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    
			<div id="review-form">
            <b style="display:block;float:left;width:150px;padding:4px 0 4px 0;"><?php echo $entry_name; ?></b>
            <input type="text" name="name" value="" style="margin-left:40px;"/>
			<br><br>
            <div class="rating">
                <label class="entry-rating"><?php echo $entry_rating; ?></label>
                <div class="radio-div" style="margin-left:45px;">
                    <input class="radio-star" type="radio" name="rating" value="1" />
                    <input class="radio-star" type="radio" name="rating" value="2" />
                    <input class="radio-star" type="radio" name="rating" value="3" />
                    <input class="radio-star" type="radio" name="rating" value="4" />
                    <input class="radio-star" type="radio" name="rating" value="5" />
                </div>
            <div class="star-div"><span class="icstars-0"></span></div>
            </div>
            <br><br>
			<b class="entry-b displayg"><?php echo $entry_good; ?></b>
			<textarea class="displayg" name="good" cols="40" rows="6"></textarea>
			<br class="displayg">
			<b class="entry-b displayb"><?php echo $entry_bads; ?></b>
			<textarea class="displayb" name="bads" cols="40" rows="6"></textarea>
			<br class="displayb">
			<b class="entry-b"><?php echo $entry_review; ?></b>
            <textarea name="text" cols="40" rows="6"></textarea>
            <br>
            <a id="spoilerclick" class="displayf">Добавить фото</a>
            <br>
            <div id="addimgsp" class="displayf">
                <b style="display:block;float:left;width:150px;padding:4px 0 4px 0;">Ссылка на фото:</b>
                <input type="text" name="addimage" value="" style="margin-left:40px;width: 306px;"/>
            </div>
            <div class="displayc">
            <b style="display:block;float:left;width:150px;padding:4px 0 4px 0;"><?php echo $entry_captcha; ?></b>
            <input type="text" name="captcha" value="" style="margin-left:40px;vertical-align:top;width:206px;" />
            <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br>
            </div>
            <br>
<?php if (!$this->config->get('config_review_good'))  { ?>
<style>.displayg{display:none!important;}</style>
<?php } ?>
<?php if (!$this->config->get('config_review_bad'))  { ?>
<style>.displayb{display:none!important;}</style>
<?php } ?>
<?php if (!$this->config->get('config_review_addimage'))  { ?>
<style>.displayf{display:none!important;}</style>
<?php } ?>
<?php if (!$this->config->get('config_review_captcha'))  { ?>
<style>.displayc{display:none!important;}</style>
<?php } ?>
<script>jQuery('.radio-star').hover(function(){var stars = jQuery(this).val();jQuery('.star-div').html('<span class="icstars-'+ stars +'"></span><i id="settext-'+ stars +'"></i>');},function(){var start = jQuery('input:radio[name=rating]:checked').val();if(typeof  start == 'undefined' ){start = 0;}jQuery('.star-div').html('<span class="icstars-'+ start +'"></span><i id="settext-'+ start +'"></i>');});jQuery('.radio-star').click(function(){jQuery('.radio-star').each(function(){jQuery(this).attr( 'checked', false );});jQuery(this).attr( 'checked', true );jQuery(this).each(function(){if(jQuery(this).attr("checked")=="checked"){var s = jQuery(this).val();jQuery('.star-div').stop().html('<span class="icstars-'+ s +'"></span><i id="settext-'+ s +'"></i>');}});});</script>
<script>
$(document).ready(function(){
  $('.review div:first a:last').click(function(){
    var offset1 = $('#review-title').prev().offset();
    offset1 = offset1 ? offset1.top : 10000;
    $('html, body').animate({ scrollTop: offset1 }, 'slow');
    $('#review-title').siblings('#review-form').stop(false, true).slideDown(500);
    $('#review-title').html('Скрыть форму для отзыва');
  });
  $('.review div:first a:first').click(function(){
    var offset = $('.review-list').prev().offset();
    $('html, body').animate({ scrollTop: offset.top }, 'slow');
  });
  $('#addimgsp').hide();
  $('#spoilerclick').toggle(
    function(){
      $(this).siblings('#addimgsp').stop(false, true).slideDown(500);
    },
   function(){
      $(this).siblings('#addimgsp').stop(false, true).slideUp(500);
   }
 );
  $('#review-form').hide();
  $('#review-title').before('<img src="image/review-new.png" height="22px" width="22px" alt="review icon" style="float: left;margin: -2px 3px 0 0;" />');
  $('#review-title').toggle(
    function(){
      $(this).siblings('#review-form').stop(false, true).slideDown(500);
      $(this).html('Скрыть форму для отзыва');
      var offset1 = $('#review-title').prev().offset();
        offset1 = offset1 ? offset1.top : 10000;
        $('html, body').animate({ scrollTop: offset1 }, 'slow');
    },
   function(){
      $(this).siblings('#review-form').stop(false, true).slideUp(500);
      $(this).html('Написать отзыв');
   }
 );
});
</script>
<script>
$(document).ready(function(){
    $('#captcha').click(function() {$(this).attr('src', 'index.php?route=product/product/captcha&rand='+ Math.round((Math.random() * 10000 )));});
    $('#captcha').after('<img src="image/refresh.png" style="margin:0 0 4px -16px;z-index:-1;position:relative;" />');
});
</script>
<style>
#settext-1:before{content: "Ужасно";margin-left: 7px;}
#settext-2:before{content: "Плохо";margin-left: 7px;}
#settext-3:before{content: "Средне";margin-left: 7px;}
#settext-4:before{content: "Хорошо";margin-left: 7px;}
#settext-5:before{content: "Отлично";margin-left: 7px;}
#review-title{cursor:pointer;}
.review-list .author{margin:0!important;}
.review-list .text{margin-bottom: 5px;}
#tab-review .minus {padding:0 0 8px 22px;background-image:url(image/minus.png);background-repeat: no-repeat;}
#tab-review .plus {padding:0 0 8px 22px;background-image:url(image/plus.png);background-repeat: no-repeat;}
#tab-review input[type='text']{height:17px;}
#tab-review input[type='text'], textarea{color: #333;box-shadow: inset 0px 2px 8px rgba(32, 74, 96, 0.2), 0px 0px 3px white;-moz-box-shadow: inset 0px 2px 8px hsla(200, 50%, 25%, 0.2), 0px 0px 3px white;-webkit-box-shadow: inset 0px 2px 8px rgba(32, 74, 96, 0.2), 0px 0px 3px white;-webkit-transition: all 200ms;-moz-transition: all 200ms;-ms-transition: all 200ms;-o-transition: all 200ms;transition: all 200ms;padding:3px !important;margin-top:2px;margin-bottom:2px;}
#tab-review input:focus, textarea:focus {box-shadow: inset 0px 2px 8px rgba(255, 255, 255, 0), 0px 0px 5px #209FDF;-moz-box-shadow: inset 0px 2px 8px hsla(0, 100%, 100%, 0), 0px 0px 5px hsl(200, 75%, 50%);-webkit-box-shadow: inset 0px 2px 8px rgba(255, 255, 255, 0), 0px 0px 5px #209FDF;background-color: #FFF;outline: none;border-color: rgba(255, 255, 255, 0);}
#tab-review .entry-b{display:block;float:left;width:150px;padding:47px 0 53px 0;}
#tab-review textarea{height:108px;min-height:108px;min-width:306px;max-width:540px;margin-left:40px;}
#tab-review textarea:focus,input:focus{outline:none;}
#tab-review #captcha{margin-top:2px;margin-left:-4px;cursor:pointer;padding-right:18px;}
#tab-review > div .radio-div {width: 77px;float: left;margin-left: 5px;}
#tab-review > div .radio-div input[type=radio] {position:relative;margin:0 0 0 -4px;padding:0;width:16px;height: 17px;opacity:0;z-index:2;cursor:pointer;-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";filter: alpha(opacity=0);}
#tab-review .star-div{height:17px;float:left;margin:1px 0 0 -84px;}
#tab-review .entry-rating{cursor:default;display:block;float:left;width:150px;padding:4px 0 4px 0;font-weight:bold;}
.star-div span{width:77px;height:17px;display:inline-block;background: url(image/stars.png) no-repeat;}
span.icstars-0{background-position:0 0}
span.icstars-1{background-position:0 -16px}
span.icstars-2{background-position:0 -32px}
span.icstars-3{background-position:0 -48px}
span.icstars-4{background-position:0 -64px}
span.icstars-5{background-position:0 -80px}
</style>
<style>.vot_updown2{float:right;font-size: 13px !important;} #yesvot{color: #298705;font-size: 13px;} #novot{color: red;font-size: 13px;}</style>
<script src="catalog/controller/voting/voting.js" type="text/javascript"></script>
			
























    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>

			</div>
			
    </div>
  </div>
  <?php } ?>
  <!-- <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><?php echo $product['sticker']; ?><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
       <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?> -->
  <!-- <?php if ($products2) { ?>
  <div id="tab-related2" class="tab-content">
    <div class="box-product">
      <?php foreach ($products2 as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><?php echo $product['sticker']; ?><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
       <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?> -->
  <?php if ($articles) { ?>
  <div id="tab-articles" class="tab-content">
    <div class="box-product box-article">
      <?php foreach ($articles as $article) { ?>
      <div>
	  <div class="article-left">
        <?php if ($article['thumb']) { ?>
        <div class="image"><a href="<?php echo $article['href']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" /></a></div>
        <?php } ?>
		<div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($article['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
		</div>
        <div class="name"><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></div>
		<div class="description-article"><?php echo $article['description']; ?> <a href="<?php echo $article['href']; ?>">...&raquo;</a></div>
        </div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script> 
<script type="text/javascript"><!--

$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
		dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
		success: function(json) {
			$('.success, .warning, attention, information, .error').remove();
            
			if (json['success']) {
                $('#profile-description').html(json['success']);
			}	
		}
	});
});
    
$(document).on('click', '#button-cart', function() {
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
                
                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
			} 
			
			if (json['success']) {
                $('#cartModal #modal-inner').html(json['success']);
                $('#cartModal').reveal({
                    animation: 'fadeAndPop',                   //fade, fadeAndPop, none
                    animationspeed: 300,                       //how fast animtions are
                    closeonbackgroundclick: true,              //if you click background will modal close?
                    dismissmodalclass: 'close-reveal-modal'    //the class of a button or element that will close an open modal
                });
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
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--

			











$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		
			data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&addimage=' + encodeURIComponent($('input[name=\'addimage\']').val()) + '&good=' + encodeURIComponent($('textarea[name=\'good\']').val()) + '&bads=' + encodeURIComponent($('textarea[name=\'bads\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
			
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				
			$('textarea[name=\'good\']').val('');
			$('textarea[name=\'bads\']').val('');
			$('input[name=\'addimage\']').val('');
			
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 
<script type="text/javascript">(function() {
  if (window.pluso)if (typeof window.pluso.start == "function") return;
  if (window.ifpluso==undefined) { window.ifpluso = 1;
    var d = document, s = d.createElement('script'), g = 'getElementsByTagName';
    s.type = 'text/javascript'; s.charset='UTF-8'; s.async = true;
    s.src = ('https:' == window.location.protocol ? 'https' : 'http')  + '://share.pluso.ru/pluso-like.js';
    var h=d[g]('body')[0];
    h.appendChild(s);
  }})();</script>

<?php echo $footer; ?>