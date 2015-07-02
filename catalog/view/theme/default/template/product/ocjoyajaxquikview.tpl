<div id="ajaxquikview">
  <div id="quikview_modal_close" onclick="$('#quikview_modal_fon').remove();"><img src="image/ocjoyajaxquikview/exit_close.png" /></div>
  <div id="ajaxlnks"></div>
  <div id="ajaxquikview_heading"><?php echo $heading_title; ?></div>
  <div id="ajaxquikview_notification"></div>
    <div class="quikview-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div id="image">
        <a href="<?php echo $popup; ?>" class="zoom" id="zomm_1" onclick="return false;">
          <img id="zomm_2" src="<?php echo $popup; ?>" style="display:none;" />
          <img id="image_s"  src="<?php echo $thumb; ?>" />
        </a>
      </div>
      <?php } ?>
      <?php if ($images) { ?>
        <div class="image-additional">
          <?php foreach ($images as $image) { ?>
            <a onclick="zoom_image(<?php echo $image['product_image_id']; ?>);" rel="<?php echo $image['thumb2']; ?>" data-popup="<?php echo $image['popup']; ?>" id="zomm_3_<?php echo $image['product_image_id']; ?>"><img src="<?php echo $image['thumb']; ?>" /></a>
          <?php } ?>
        </div>
        <script type="text/javascript">
          function zoom_image(img_id){
            var zomm_2 = $('#zomm_3_'+img_id).attr('data-popup');
            var zomm_3 = $('#zomm_3_'+img_id).attr('rel');
            $("#zomm_1").attr("href", zomm_2);
            $(".zoomImg").attr("src", zomm_2);
            $("#image_s").attr("src", zomm_3);        
          }
        </script>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
      <div class="longline"></div>
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>" target="_blanck"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
        <?php if ($weight_show != "0.00000000") { ?>
        <span><?php echo $text_weight; ?></span> <?php echo $weight; ?><br />
        <?php } ?>
        <span><?php echo $text_stock; ?></span> <?php echo $stock; ?><br />
        <?php if ($rating) { ?>
        <img src="catalog/view/theme/default/image/ocjoyajaxquikview/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" style="margin-bottom:-3px;" />&nbsp;&nbsp;<?php echo $reviews; ?>
        <?php } ?>
      </div>
      <div class="longline"></div>
      <?php if ($price) { ?>
      <div class="price"><?php echo $text_price; ?>
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-new"><?php echo $special; ?></span> <span class="price-old"><?php echo $price; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
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
      <div class="longline"></div>
      <div class="options">
        <div id="headoptions"><?php echo $text_option; ?></div>
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
      <div class="longline"></div>
      <div class="cart">
        <table>
            <tr>
              <td><?php echo $text_qty; ?></td>
              <td> 
                <input type="text" name="quantity" id="quant" onchange="return validate(this);" size="3" maxlength="3" onkeyup="return validate(this);" value="<?php echo $minimum; ?>" />
                <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
              </td>
              <td style="padding-left:5px;">
                <a onclick="pluscon(<?php echo $product_id; ?>);" id="pluss" style="margin-top:6px;display:inline-block;"><img src="image/ocjoyajaxquikview/quantity_up.gif"></a>
                <br />
                <a onclick="minuscon(<?php echo $product_id; ?>);" id="minuss" style="margin-top:-2px;display:inline-block;"><img src="image/ocjoyajaxquikview/quantity_down.gif"></a>
              </td>
              <td style="padding-left:5px;"><a onclick="addToCart2('<?php echo $product_id; ?>');" class="quikview-button"><?php echo $button_cart; ?></a></td>
            </tr>
          </table>
          <?php if ($minimum > 1) { ?><div class="minimum"><?php echo $text_minimum; ?></div><?php } ?>
      </div>
      <div class="longline"></div>
      <?php if(isset($wishlist) || isset($compare) || isset($more)) { ?>
        <div class="components-link">
          <?php if(isset($wishlist)) { ?><a onclick="addToWishList2('<?php echo $product_id; ?>');" class="quikview-button2"><?php echo $button_wishlist; ?></a><?php } ?>
          <?php if(isset($compare)) { ?><a onclick="addToCompare2('<?php echo $product_id; ?>');" class="quikview-button2"><?php echo $button_compare; ?></a><?php } ?>
          <?php if(isset($more)) { ?><a href="<?php echo $href; ?>" class="quikview-button2" style="float:right;" target="_blanck"><?php echo $button_goproduct; ?></a><?php } ?>
        </div>
        <div class="longline"></div>
      <?php } ?>
      <?php if(isset($socials)) { ?>
        <div class="review">
          <script type="text/javascript" src="//yandex.st/share/share.js" charset="utf-8"></script>
          <div class="yashare-auto-init" style="margin-left:-6px;display:block;" data-yashareL10n="ru" data-yashareType="icon" data-yashareQuickServices="vkontakte,facebook,twitter,odnoklassniki,moimir,lj,gplus"></div> 
        </div>
        <div class="longline"></div>
      <?php } ?>
      <?php if ($tags) { ?>
        <div class="tags">
          <b><?php echo $text_tags; ?></b>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
          <?php if ($i < (count($tags) - 1)) { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
          <?php } else { ?>
          <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
          <?php } ?>
          <?php } ?>
        </div>
      <?php } ?>
    </div>
  </div>
<?php if (isset($show_description)) { ?>
  <?php if ($description) { ?>
    <div class="head-tabs">
      <div style="margin-left:10px;display:inline-block;"><?php echo $tab_description; ?></div>
      <div class="trigger-block" id="trigger-block-1" onclick="$('#show-hide-block-1').toggle();$('#trigger-block-1 span').toggle();$.colorbox.resize();"><span><?php echo $text_showit; ?></span><span style="display:none;"><?php echo $text_hideit; ?></span></div>
    </div>
    <div class="show-hide-block" id="show-hide-block-1">
      <div style="margin:0 10px;height:200px;overflow:auto;"><?php echo $description; ?></div>
    </div>
  <?php } ?>
<?php } ?>
<?php if (isset($show_attributes)) { ?>
  <?php if ($attribute_groups) { ?>
    <div class="head-tabs">
      <div style="margin-left:10px;display:inline-block;"><?php echo $tab_attribute; ?></div>
      <div class="trigger-block" id="trigger-block-2" onclick="$('#show-hide-block-2').toggle();$('#trigger-block-2 span').toggle();$.colorbox.resize();"><span><?php echo $text_showit; ?></span><span style="display:none;"><?php echo $text_hideit; ?></span></div>
    </div>
    <div class="show-hide-block" id="show-hide-block-2">
      <div style="margin:0 10px;height:200px;overflow:auto;">
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
    </div>
  <?php } ?>
<?php } ?>
<?php if (isset($show_reviews)) { ?>
  <?php if ($review_status) { ?>
    <div class="head-tabs">
      <div style="margin-left:10px;display:inline-block;"><?php echo $tab_review; ?></div>
      <div class="trigger-block" id="trigger-block-3" onclick="$('#show-hide-block-3').toggle();$('#trigger-block-3 span').toggle();$.colorbox.resize();"><span><?php echo $text_showit; ?></span><span style="display:none;"><?php echo $text_hideit; ?></span></div>
    </div>
    <div class="show-hide-block" id="show-hide-block-3">
      <div style="margin:0 10px;height:300px;overflow:auto;">
        <div id="review">
          <?php if ($reviews2) { ?>
          <?php foreach ($reviews2 as $review) { ?>
          <div class="ajax-review-list">
            <div class="author"><b><?php echo $review['author']; ?></b> <?php echo $text_on; ?> <?php echo $review['date_added']; ?></div>
            <div class="rating"><img src="catalog/view/theme/default/image/ocjoyajaxquikview/stars-<?php echo $review['rating'] . '.png'; ?>" alt="<?php echo $review['reviews']; ?>" /></div>
            <div class="text"><?php echo $review['text']; ?></div>
          </div>
          <?php } ?>
          <div class="pagination"><?php echo $pagination; ?></div>
          <?php } else { ?>
          <div class="content"><?php echo $text_no_reviews; ?></div>
          <?php } ?>
        </div>
        <h2 id="review-title"><?php echo $text_write; ?></h2>
        <b><?php echo $entry_name; ?></b><br />
        <input type="text" name="name" value="" />
        <br />
        <b><?php echo $entry_review; ?></b>
        <textarea name="text" cols="40" rows="8" style="width: 98%;resize:none;"></textarea>
        <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
        <br />
        <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
        <input type="radio" name="rating" value="1" />
        &nbsp;
        <input type="radio" name="rating" value="2" />
        &nbsp;
        <input type="radio" name="rating" value="3" />
        &nbsp;
        <input type="radio" name="rating" value="4" />
        &nbsp;
        <input type="radio" name="rating" value="5" />
        &nbsp;<span><?php echo $entry_good; ?></span><br />
        <br />
        <b><?php echo $entry_captcha; ?></b><br />
        <input type="text" name="captcha" value="" />
        <br />
        <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
        <br />
        <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
         <a onclick="justwrite();" class="quikview-button2"><?php echo $button_continue; ?></a>
        <br /><br />
      </div>
    </div>
  <?php } ?>
<?php } ?>
<?php if (isset($show_related)) { ?>
  <?php if ($products) { ?>
    <div class="head-tabs">
      <div style="margin-left:10px;display:inline-block;"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</div>
      <div class="trigger-block" id="trigger-block-4" onclick="$('#show-hide-block-4').toggle();$('#trigger-block-4 span').toggle();$.colorbox.resize();"><span><?php echo $text_showit; ?></span><span style="display:none;"><?php echo $text_hideit; ?></span></div>
    </div>
    <div class="show-hide-block" id="show-hide-block-4">
      <div style="margin:0 10px;">
        <div class="box-product-new">
            <?php foreach ($products as $product) { ?>
            <div>
              <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
              <?php if ($product['thumb']) { ?>
              <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
              <?php } ?>
              <?php if ($product['description']) { ?>
              <div class="description"><?php echo $product['description']; ?></div>
              <?php } ?>
              <div class="block">
                <?php if ($product['price']) { ?>
                <div class="price">
                  <?php if (!$product['special']) { ?>
                  <?php echo $product['price']; ?>
                  <?php } else { ?>
                  <span class="price-new"><?php echo $product['special']; ?></span>
                  <?php } ?>
                </div>
                <?php } ?>
                <div class="cart"><a onclick="addToCart3('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
              </div>
              <div class="block2">
                <a onclick="addToWishList2('<?php echo $product['product_id']; ?>');" class="link"><?php echo $button_wishlist; ?></a>
                <a onclick="addToCompare2('<?php echo $product['product_id']; ?>');" class="link"><?php echo $button_compare; ?></a>
              </div>
              <?php if ($product['rating']) { ?>
              <div class="rating"><img src="catalog/view/theme/default/image/ocjoyajaxquikview/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
              <?php } ?>
            </div>
            <?php } ?>
          </div>
      </div>
    </div>
  <?php } ?>
<?php } ?>
</div>
<script type="text/javascript">
function addToCart2(product_id, quantity) {
  quantity = parseInt($("#quant").val());
  $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: $('.quikview-info input[type=\'text\'], .quikview-info input[type=\'hidden\'], .quikview-info input[type=\'radio\']:checked, .quikview-info input[type=\'checkbox\']:checked, .quikview-info select, .quikview-info textarea'),
      dataType: 'json',
      success: function(json) {
          <?php if ($options) { ?>
            $('.error').remove();
            if (json['error']) {
              if (json['error']['option']) {
                for (i in json['error']['option']) {
                  $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                }
              }
            } 
          <?php } ?>
          if (json['success']) {
              $('#ajaxquikview_notification').html('<div class="success">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
              $('.success, .warning, .attention, .information, .error').delay(2000).fadeOut(1000);
              $('#cart-total').html(json['total']);
              $(this).colorbox.resize();
          }   
      }
  });
}
function addToCart3(product_id, quantity) {
  quantity = 1;
  $.ajax({
      url: 'index.php?route=checkout/cart/add',
      type: 'post',
      data: 'product_id=' + product_id + '&quantity=' + quantity,
      dataType: 'json',
      success: function(json) {
          if (json['success']) {
              $('#ajaxquikview_notification').html('<div class="success">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
              $('.success, .warning, .attention, .information, .error').delay(2000).fadeOut(1000);
              $('#cart-total').html(json['total']);
              $(this).colorbox.resize();
          }   
      }
  });
}
function validate(input) {
  input.value = input.value.replace(/[^\d,]/g, '');
}
function pluscon() {
  qua = parseInt($("#quant").val())+1;
  $("#quant").val(qua);
}
function minuscon() {
  if (parseInt($("#quant").val())>1) {
    qua = parseInt($("#quant").val())-1;
    $("#quant").val(qua);
  }
}
</script>
<script type="text/javascript">
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');
  $('#review').load(this.href);
  $('#review').fadeIn('slow');
  return false;
});     
function justwrite() {
  $.ajax({
    url: 'index.php?route=product/ocjoyajaxquikview/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&product_id=' + encodeURIComponent($('input[name=\'product_id\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
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
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
}
</script>