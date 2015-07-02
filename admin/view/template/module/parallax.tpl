<?php echo $header; ?>
<div id="content">
<!-- breadcrumb -->
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<!-- warning -->
	<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
<!-- settings box -->
	<div class="box">
<!-- heading -->
		<div class="heading">
			<h1><?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
		</div>
<!-- content -->
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" id="form" enctype="multipart/form-data" class="form-horizontal">
<!-- tabs -->
				<div class="vtabs">
					<?php $module_row = 1; ?>
					<?php foreach ($modules as $module) { ?>
						<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
					<?php $module_row++; ?>
					<?php } ?>
				    <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
				</div>
<!-- module settings -->
		<?php $module_row = 1; ?>
		<?php foreach ($modules as $module) { ?>
		<div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
			<fieldset>
				<legend><?php echo $products_settings; ?></legend>
<!-- change products -->
					<div class="control-group">
						<label class="control-label"><?php echo $change_product; ?></label>
						<div class="controls">
							<input class="span2" type="text" name="product-search[<?php echo $module_row; ?>]" value="" />
						</div>
					</div>
<!-- selected products -->
					<div class="control-group">
						<label class="control-label"><?php echo $selected_products; ?></label>
						<div class="controls">
							<div class="scrollbox">
								<?php $class = 'odd'; ?>
								<?php foreach ($module['products'] as $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
									<div id="product_<?php echo $module_row; ?>_<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?><img src="view/image/delete.png" />
										<input type="hidden" value="<?php echo $product['product_id']; ?>" />
									</div>
								<?php } ?>
							</div>
							<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][products_ids]" value="<?php echo $module['products_ids']; ?>" />
						</div>
					</div>
<!-- description -->
					<div class="control-group">
						<label class="control-label"><?php echo $product_description; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][show_description]">
								<?php if ($module['show_description'] == '1') { ?>
									<option value="1" selected><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select> &nbsp;&nbsp; 
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][description_length]" value="<?php echo isset($module['description_length']) ? $module['description_length'] : '300'; ?>" /><span class="help-inline"><?php echo $product_description_s; ?></span>
						</div>
					</div>
<!-- images width/height -->
					<div class="control-group">
						<label class="control-label"><?php echo $image_size; ?></label>
						<div class="controls">
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][image_width]" value="<?php echo isset($module['image_width']) ? $module['image_width'] : '552'; ?>" /> x 
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][image_height]" value="<?php echo isset($module['image_height']) ? $module['image_height'] : '266'; ?>" />
						</div>
					</div>
			</fieldset>
<!-- slider settings -->
			<fieldset>
				<legend><?php echo $slider_settings; ?></legend>
<!-- slider bg -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_bg; ?></label>
						<div class="controls">
							<div class="input-append color span2 colorpicker" data-color="<?php echo isset($module['slider_bg']) ? $module['slider_bg'] : 'rgba(255,255,255,1)'; ?>" data-color-format="rgba">
							<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][slider_bg]" value="<?php echo isset($module['slider_bg']) ? $module['slider_bg'] : 'rgba(255,255,255,1)'; ?>" />
							<span class="add-on"><i style="background-color:<?php echo isset($module['slider_bg']) ? $module['slider_bg'] : 'rgba(255,255,255,1)'; ?>"></i></span>
							</div>
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][show_bg]">
								<?php if ($module['show_bg'] == '0') { ?>
									<option value="1"><?php echo $text_enabled; ?></option>
									<option value="0" selected><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="1" selected><?php echo $text_enabled; ?></option>
									<option value="0"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
<!-- slider pattern -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_bg_pattern; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_pattern]">
								<?php foreach ($slider_pattern as $pattern) { ?>
								<?php if ($module['slider_pattern'] == $pattern['pattern']) { ?>
									<option value="<?php echo $pattern['pattern']; ?>" selected><?php echo $pattern['title']; ?></option>
								<?php } else { ?>
									<option value="<?php echo $pattern['pattern']; ?>"><?php echo $pattern['title']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
<!-- sticker bg -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_stick_color; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_sticker]">
								<?php foreach ($slider_sticker as $sticker) { ?>
								<?php if ($module['slider_sticker'] == $sticker['sticker']) { ?>
									<option value="<?php echo $sticker['sticker']; ?>" selected><?php echo $sticker['title']; ?></option>
								<?php } else { ?>
									<option value="<?php echo $sticker['sticker']; ?>"><?php echo $sticker['title']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
<!-- sticker new -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_stick_ncolor; ?></label>
							<div class="controls">
								<div class="input-append color span2 colorpicker" data-color="<?php echo isset($module['sticker_ncolor']) ? $module['sticker_ncolor'] : 'rgba(255,255,255,1)'; ?>" data-color-format="rgba">
									<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][sticker_ncolor]" value="<?php echo isset($module['sticker_ncolor']) ? $module['sticker_ncolor'] : 'rgba(255,255,255,1)'; ?>" />
									<span class="add-on"><i style="background-color:<?php echo isset($module['sticker_ncolor']) ? $module['sticker_ncolor'] : 'rgba(255,255,255,1)'; ?>"></i></span>
								</div>
							</div>
					</div>
<!-- sticker old -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_stick_ocolor; ?></label>
							<div class="controls">
								<div class="input-append color span2 colorpicker" data-color="<?php echo isset($module['sticker_ocolor']) ? $module['sticker_ocolor'] : 'rgba(191,183,140,1)'; ?>" data-color-format="rgba">
									<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][sticker_ocolor]" value="<?php echo isset($module['sticker_ocolor']) ? $module['sticker_ocolor'] : 'rgba(191,183,140,1)'; ?>" />
									<span class="add-on"><i style="background-color:<?php echo isset($module['sticker_ocolor']) ? $module['sticker_ocolor'] : 'rgba(191,183,140,1)'; ?>"></i></span>
								</div>
							</div>
					</div>
<!-- text color -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_text_color; ?></label>
							<div class="controls">
								<div class="input-append color span2 colorpicker" data-color="<?php echo isset($module['slider_tcolor']) ? $module['slider_tcolor'] : 'rgba(0,0,0,1)'; ?>" data-color-format="rgba">
									<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][slider_tcolor]" value="<?php echo isset($module['slider_tcolor']) ? $module['slider_tcolor'] : 'rgba(0,0,0,1)'; ?>" />
									<span class="add-on"><i style="background-color:<?php echo isset($module['slider_tcolor']) ? $module['slider_tcolor'] : 'rgba(0,0,0,1)'; ?>"></i></span>
								</div>
							</div>
					</div>
<!-- text size -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_text_size; ?></label>
							<div class="controls">
								<input type="text" class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_tsize]" value="<?php echo isset($module['slider_tsize']) ? $module['slider_tsize'] : '15'; ?>" />
							</div>
					</div>
<!-- title color -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_title_color; ?></label>
						<div class="controls">
								<div class="input-append color span2 colorpicker" data-color="<?php echo isset($module['slider_hcolor']) ? $module['slider_hcolor'] : 'rgba(0,0,0,1)'; ?>" data-color-format="rgba">
									<input type="hidden" name="parallax_module[<?php echo $module_row; ?>][slider_hcolor]" value="<?php echo isset($module['slider_hcolor']) ? $module['slider_hcolor'] : 'rgba(0,0,0,1)'; ?>" />
									<span class="add-on"><i style="background-color:<?php echo isset($module['slider_hcolor']) ? $module['slider_hcolor'] : 'rgba(0,0,0,1)'; ?>"></i></span>
								</div>
						</div>
					</div>
<!-- title size -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_title_size; ?></label>
						<div class="controls">
							<input type="text" class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_hsize]" value="<?php echo isset($module['slider_hsize']) ? $module['slider_hsize'] : '22'; ?>" />
						</div>
					</div>
<!-- slider button -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_buttons; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_button]">
								<?php foreach ($slider_button as $button) { ?>
								<?php if ($module['slider_button'] == $button['button']) { ?>
									<option value="<?php echo $button['button']; ?>" selected><?php echo $button['title']; ?></option>
								<?php } else { ?>
									<option value="<?php echo $button['button']; ?>"><?php echo $button['title']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
<!-- slider interval -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_interval; ?></label>
						<div class="controls">
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][slider_interval]" value="<?php echo isset($module['slider_interval']) ? $module['slider_interval'] : '5000'; ?>" />
						</div>
					</div>
<!-- slider bgincrement -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_bgincrement; ?></label>
						<div class="controls">
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][slider_bgincrement]" value="<?php echo isset($module['slider_bgincrement']) ? $module['slider_bgincrement'] : '100'; ?>" />
						</div>
					</div>
<!-- slider autoplay -->
					<div class="control-group">
						<label class="control-label"><?php echo $slider_autoplay; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][slider_autoplay]">
								<?php if ($module['slider_autoplay'] == 'true') { ?>
									<option value="true" selected><?php echo $text_enabled; ?></option>
									<option value="false"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
									<option value="true"><?php echo $text_enabled; ?></option>
									<option value="false" selected><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select> 
						</div>
					</div>
<!-- slider width/height -->					
					<div class="control-group">
						<label class="control-label"><?php echo $slider_size; ?></label>
						<div class="controls">
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][slider_width]" value="<?php echo isset($module['slider_width']) ? $module['slider_width'] : '978'; ?>" /> x 
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][slider_height]" value="<?php echo isset($module['slider_height']) ? $module['slider_height'] : '286'; ?>" />
						</div>
					</div>
			</fieldset>
<!-- view setting -->
			<fieldset>
				<legend><?php echo $position_settings; ?></legend>
<!-- entry layout -->
					<div class="control-group">
					<label class="control-label"><?php echo $entry_layout; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][layout_id]">
							<?php foreach ($layouts as $layout) { ?>
							<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
								<option value="<?php echo $layout['layout_id']; ?>" selected><?php echo $layout['name']; ?></option>
							<?php } else { ?>
								<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
							<?php } ?>
							<?php } ?>
							</select>
						</div>
					</div>
<!-- entry position -->					
					<div class="control-group">
						<label class="control-label"><?php echo $entry_position; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][position]">
							<?php if ($module['position'] == 'content_top') { ?>
								<option value="content_top" selected><?php echo $text_content_top; ?></option>
							<?php } else { ?>
								<option value="content_top"><?php echo $text_content_top; ?></option>
							<?php } ?>
							<?php if ($module['position'] == 'content_bottom') { ?>
								<option value="content_bottom" selected><?php echo $text_content_bottom; ?></option>
							<?php } else { ?>
								<option value="content_bottom"><?php echo $text_content_bottom; ?></option>
							<?php } ?>
							<?php if ($module['position'] == 'content_middle') { ?>
								<option value="content_middle" selected><?php echo $text_content_middle; ?></option>
							<?php } else { ?>
								<option value="content_middle"><?php echo $text_content_middle; ?></option>
							<?php } ?>
							</select>
						</div>
					</div>
<!-- entry status -->
					<div class="control-group">
						<label class="control-label"><?php echo $entry_status; ?></label>
						<div class="controls">
							<select class="span2" name="parallax_module[<?php echo $module_row; ?>][status]">
							<?php if ($module['status']) { ?>
								<option value="1" selected><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected><?php echo $text_disabled; ?></option>
							<?php } ?>
							</select>
						</div>
					</div>
<!-- entry sort order -->
					<div class="control-group">
						<label class="control-label"><?php echo $entry_sort_order; ?></label>
						<div class="controls">
							<input class="span1" type="text" name="parallax_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" />
						</div>
					</div>
			</fieldset>
        </div>
		<?php $module_row++; ?>
		<?php } ?>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript"><!--

$('input[name^="product-search"]').live('focus', function(){
  $(this).autocomplete({
    delay: 0,
    source: function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
        dataType: 'json',
        success: function(json) {		
          response($.map(json, function(item) {
            return {
              label: item.name,
              value: item.product_id
            }
          }));
        }
      });
    },
    select: function(event, ui) {
      var box = $(this).closest('.control-group').next().find('.scrollbox');
      var module_row = parseInt(box.next('input').attr('name'));
      $('#product_'+module_row+'_'+ui.item.value).remove();
      $(box).append('<div id="product_'+module_row+'_'+ ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" value="' + ui.item.value + '" /></div>');
      $('div:odd', box).attr('class', 'odd');
      $('div:even', box).attr('class', 'even');
      data = $.map($('input', box), function(element){
        return $(element).attr('value');
      });
      $(box).parent().children('input').attr('value', data.join());		

      return false;
    }
  });
});

$('.scrollbox div img').live('click', function() {
  var box = $(this).closest('.scrollbox');
  $(this).parent().remove();
  $('div:odd', box).attr('class', 'odd');
  $('div:even', box).attr('class', 'even');
  data = $.map($('input', box), function(element){
    return $(element).attr('value');
  });
  $(box).next('input').attr('value', data.join());
});
	
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
// Product
html += '<fieldset>';
	// Change products
html += '	<legend><?php echo $products_settings; ?></legend>';
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $change_product; ?></label>';
html += '			<div class="controls">';
html += '				<input class="span2" type="text" name="product-search['+module_row+']" value="" />';
html += '			</div>';
html += '	</div>';
	// Selected products
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $selected_products; ?></label>';
html += '			<div class="controls">';
html += '				<div class="scrollbox"></div>';
html += '				<input type="hidden" name="parallax_module['+module_row+'][products_ids]" value="" />';
html += '			</div>';
html += '	</div>';
	// Description
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $product_description; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span2" name="parallax_module['+module_row+'][show_description]">';
html += '				<option value="1" selected><?php echo $text_enabled; ?></option>';
html += '				<option value="0"><?php echo $text_disabled; ?></option>';
html += '			</select> &nbsp;&nbsp; ';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][description_length]" value="<?php echo isset($module['description_length']) ? $module['description_length'] : '300'; ?>" />';
html += '			<span class="help-inline"><?php echo $product_description_s; ?></span>';
html += '		</div>';
html += '	</div>';
	// Image size
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $image_size; ?></label>';
html += '		<div class="controls">';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][image_width]" value="<?php echo isset($module['image_width']) ? $module['image_width'] : '552'; ?>" /> x ';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][image_height]" value="<?php echo isset($module['image_height']) ? $module['image_height'] : '266'; ?>" /> ';
html += '		</div>';
html += '	</div>';
html += '</fieldset>';
// Slider
html += '<fieldset>';
html += '	<legend><?php echo $slider_settings; ?></legend>';
	// Slider bg
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_bg; ?></label>';
html += '		<div class="controls">';
html += '			<div class="input-append color span2 colorpicker" data-color="rgba(255,255,255,1)" data-color-format="rgba">';
html += '				<input type="hidden" name="parallax_module['+module_row+'][slider_bg]" value="<?php echo isset($module['slider_bg']) ? $module['slider_bg'] : 'rgba(255,255,255,1)'; ?>" />';
html += '				<span class="add-on"><i style="background-color:rgba(255,255,255,1)"></i></span>';
html += '			</div>';
html += '			<select class="span2" name="parallax_module['+module_row+'][show_bg]">';
html += '				<option value="1"><?php echo $text_enabled; ?></option>';
html += '				<option value="0" selected><?php echo $text_disabled; ?></option>';
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Slider pattern
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_bg_pattern; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span2" name="parallax_module['+module_row+'][slider_pattern]">';
<?php foreach ($slider_pattern as $pattern) { ?>
html += '				<option value="<?php echo $pattern['pattern']; ?>"><?php echo $pattern['title']; ?></option>';
<?php } ?>
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Sticker bg
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_stick_color; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span2" name="parallax_module['+module_row+'][slider_sticker]">';
<?php foreach ($slider_sticker as $sticker) { ?>
html += '				<option value="<?php echo $sticker['sticker']; ?>"><?php echo $sticker['title']; ?></option>';
<?php } ?>
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Sticker new
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_stick_ncolor; ?></label>';
html += '		<div class="controls">';
html += '			<div class="input-append color span2 colorpicker" data-color="rgba(255,255,255,1)" data-color-format="rgba">';
html += '				<input type="hidden" name="parallax_module['+module_row+'][sticker_ncolor]" value="<?php echo isset($module['sticker_ncolor']) ? $module['sticker_ncolor'] : 'rgba(255,255,255,1)'; ?>" />';
html += '				<span class="add-on"><i style="background-color:rgba(255,255,255,1)"></i></span>';
html += '			</div>';
html += '		</div>';
html += '	</div>';
	// Sticker old
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_stick_ocolor; ?></label>';
html += '		<div class="controls">';
html += '			<div class="input-append color span2 colorpicker" data-color="rgba(191,183,140,1)" data-color-format="rgba">';
html += '				<input type="hidden" name="parallax_module['+module_row+'][sticker_ocolor]" value="<?php echo isset($module['sticker_ocolor']) ? $module['sticker_ocolor'] : 'rgba(191,183,140,1)'; ?>" />';
html += '				<span class="add-on"><i style="background-color:rgba(191,183,140,1)"></i></span>';
html += '			</div>';
html += '		</div>';
html += '	</div>';
	// Text color
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_text_color; ?></label>';
html += '		<div class="controls">';
html += '			<div class="input-append color span2 colorpicker" data-color="rgba(0,0,0,1)" data-color-format="rgba">';
html += '				<input type="hidden" name="parallax_module['+module_row+'][slider_tcolor]" value="<?php echo isset($module['slider_tcolor']) ? $module['slider_tcolor'] : 'rgba(0,0,0,1)'; ?>" />';
html += '				<span class="add-on"><i style="background-color:rgba(0,0,0,1)"></i></span>';
html += '			</div>';
html += '		</div>';
html += '	</div>';
	// Text size
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_text_size; ?></label>';
html += '		<div class="controls">';
html += '			<input type="text" class="span2" name="parallax_module['+module_row+'][slider_tsize]" value="<?php echo isset($module['slider_tsize']) ? $module['slider_tsize'] : '15'; ?>" />';
html += '		</div>';
html += '	</div>';
	// Title color
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_title_color; ?></label>';
html += '		<div class="controls">';
html += '			<div class="input-append color span2 colorpicker" data-color="rgba(0,0,0,1)" data-color-format="rgba">';
html += '				<input type="hidden" name="parallax_module['+module_row+'][slider_hcolor]" value="<?php echo isset($module['slider_hcolor']) ? $module['slider_hcolor'] : 'rgba(0,0,0,1)'; ?>" />';
html += '				<span class="add-on"><i style="background-color:rgba(0,0,0,1)"></i></span>';
html += '			</div>';
html += '		</div>';
html += '	</div>';
	// Title size
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_title_size; ?></label>';
html += '		<div class="controls">';
html += '			<input type="text" class="span2" name="parallax_module['+module_row+'][slider_hsize]" value="<?php echo isset($module['slider_hsize']) ? $module['slider_hsize'] : '22'; ?>" />';
html += '		</div>';
html += '	</div>';
	// Slider button
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_buttons; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span2" name="parallax_module['+module_row+'][slider_button]">';
<?php foreach ($slider_button as $button) { ?>
html += '				<option value="<?php echo $button['button']; ?>"><?php echo $button['title']; ?></option>';
<?php } ?>
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Slide interval
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_interval; ?></label>';
html += '		<div class="controls">';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][slider_interval]" value="<?php echo isset($module['slider_interval']) ? $module['slider_interval'] : '5000'; ?>" />';
html += '		</div>';
html += '	</div>';
	// Slider bgincrement
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_bgincrement; ?></label>';
html += '		<div class="controls">';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][slider_bgincrement]" value="<?php echo isset($module['slider_bgincrement']) ? $module['slider_bgincrement'] : '100'; ?>" />';
html += '		</div>';
html += '	</div>';
	// Slider autoplay -->
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_autoplay; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span2" name="parallax_module['+module_row+'][slider_autoplay]">';
html += '				<option value="true" selected><?php echo $text_enabled; ?></option>';
html += '				<option value="false"><?php echo $text_disabled; ?></option>';
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Slider width/height
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $slider_size; ?></label>';
html += '		<div class="controls">';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][slider_width]" value="<?php echo isset($module['slider_width']) ? $module['slider_width'] : '978'; ?>" /> x';
html += '			<input class="span1" type="text" name="parallax_module['+module_row+'][slider_height]" value="<?php echo isset($module['slider_height']) ? $module['slider_height'] : '286'; ?>" />';
html += '		</div>';
html += '	</div>';
html += '</fieldset>';
// Module
html += '<fieldset>';
html += '	<legend><?php echo $position_settings; ?></legend>';
	// Entry layout 
html += '	<div class="control-group">';
html += '	<label class="control-label"><?php echo $entry_layout; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span3" name="parallax_module[' + module_row + '][layout_id]">';
<?php foreach ($layouts as $layout) { ?>
html += '				<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
<?php } ?>
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Entry position
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $entry_position; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span3" name="parallax_module[' + module_row + '][position]">';
html += '				<option value="content_top" ><?php echo $text_content_top; ?></option>';
html += '				<option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
html += '				<option value="content_middle"><?php echo $text_content_middle; ?></option>';
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Entry status
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $entry_status; ?></label>';
html += '		<div class="controls">';
html += '			<select class="span3" name="parallax_module[' + module_row + '][status]">';
html += '				<option value="1"><?php echo $text_enabled; ?></option>';
html += '				<option value="0"><?php echo $text_disabled; ?></option>';
html += '			</select>';
html += '		</div>';
html += '	</div>';
	// Entry sort order
html += '	<div class="control-group">';
html += '		<label class="control-label"><?php echo $entry_sort_order; ?></label>';
html += '		<div class="controls">';
html += '			<input class="span1" type="text" name="parallax_module[' + module_row + '][sort_order]" value="" size="3" />';
html += '		</div>';
html += '	</div>';
html += '</fieldset>'; 
html += '</div>';
	
	$('#form').append(html);
		
	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	$(function(){
                $('.colorpicker').colorpicker();
    });
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script>  
<script>$(function(){$('.colorpicker').colorpicker();});</script>
<?php echo $footer; ?>