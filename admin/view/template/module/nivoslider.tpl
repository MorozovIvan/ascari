<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#apply').val(1); $('#form').submit();" class="button"><span><?php echo $button_apply; ?></span></a><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a href="<?php echo $cancel; ?>" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
        <input type="hidden" name="apply" id="apply" value="0" />
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>">
          <?php if (!empty($module['module_name'])) { ?>
          <?php echo $module['module_name']; ?>
          <?php } else { ?>
          <?php echo $tab_module . ' ' . $module_row; ?>
          <?php } ?>
          &nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> </div>
        <?php $module_row = 1; ?>
        <?php foreach ($modules as $module) { ?>
        <div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
          <div id="tabs-<?php echo $module_row; ?>" class="htabs"><a href="#tab-module-setting-<?php echo $module_row; ?>"><?php echo $tab_setting; ?></a><a href="#tab-slider-config-<?php echo $module_row; ?>"><?php echo $tab_config; ?></a><a href="#tab-triggers-<?php echo $module_row; ?>"><?php echo $tab_triggers; ?></a></div>
          <div id="tab-module-setting-<?php echo $module_row; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_module_name; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][module_name]" value="<?php echo isset($module['module_name']) ? $module['module_name'] : ''; ?>" class="span3" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_store; ?></td>
                <td><div class="row">
                    <div class="span3">
                      <label class="checkbox">
                        <input type="checkbox" name="nivoslider_module[<?php echo $module_row; ?>][store_id][]" value="0" <?php echo isset($module['store_id']) && in_array(0, $module['store_id']) ? 'checked="checked" ' : ''; ?> />
                        <?php echo $default_store; ?> </label>
                      <?php foreach ($stores as $store) { ?>
                      <label class="checkbox">
                        <input type="checkbox" name="nivoslider_module[<?php echo $module_row; ?>][store_id][]" value="<?php echo $store['store_id']; ?>" <?php echo isset($module['store_id']) && in_array($store['store_id'], $module['store_id']) ? 'checked="checked" ' : ''; ?> />
                        <?php echo $store['name']; ?> </label>
                      <?php } ?>
                    </div>
                  </div></td>
              </tr>
              <tr>
                <td><?php echo $entry_layout; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][layout_id]" class="span3" onchange="if ($(this).val() == '3') {$('#featured-cid-<?php echo $module_row; ?>').show();} else {$('#featured-cid-<?php echo $module_row; ?>').hide();}">
                    <?php foreach ($layouts as $layout) { ?>
                    <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                    <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr id="featured-cid-<?php echo $module_row; ?>" <?php echo ($module['layout_id'] == '3' ? '' : 'style="display:none;"'); ?>>
                <td><?php echo $entry_featured_cat; ?></td>
                <td><div class="scrollbox">
                    <?php $class = 'odd'; ?>
                    <?php foreach ($categories as $category) { ?>
                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                    <div class="<?php echo $class; ?>">
                      <?php if (!empty($module['featured_cid']) && in_array($category['category_id'], $module['featured_cid'])) { ?>
                      <label>
                        <input type="checkbox" name="nivoslider_module[<?php echo $module_row; ?>][featured_cid][]" value="<?php echo $category['category_id']; ?>" checked="checked" />
                        <?php echo $category['name']; ?> </label>
                      <?php } else { ?>
                      <label>
                        <input type="checkbox" name="nivoslider_module[<?php echo $module_row; ?>][featured_cid][]" value="<?php echo $category['category_id']; ?>" />
                        <?php echo $category['name']; ?> </label>
                      <?php } ?>
                    </div>
                    <?php } ?>
                  </div>
                  <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
              </tr>
              <tr>
                <td><?php echo $entry_position; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][position]" class="span3">
                    <?php if ($module['position'] == 'content_top') { ?>
                    <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                    <?php } else { ?>
                    <option value="content_top"><?php echo $text_content_top; ?></option>
                    <?php } ?>
                    <?php if ($module['position'] == 'content_bottom') { ?>
                    <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                    <?php } else { ?>
                    <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                    <?php } ?>
                    <?php if ($module['position'] == 'column_left') { ?>
                    <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                    <?php } else { ?>
                    <option value="column_left"><?php echo $text_column_left; ?></option>
                    <?php } ?>
                    <?php if ($module['position'] == 'column_right') { ?>
                    <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                    <?php } else { ?>
                    <option value="column_right"><?php echo $text_column_right; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][status]" class="span3">
                    <?php if ($module['status']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_sort_order; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" class="span1" /></td>
              </tr>
            </table>
          </div>
          <div id="tab-slider-config-<?php echo $module_row; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_banner; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][banner_id]" class="span3">
                    <?php foreach ($banners as $banner) { ?>
                    <?php if ($banner['banner_id'] == $module['banner_id']) { ?>
                    <option value="<?php echo $banner['banner_id']; ?>" selected="selected"><?php echo $banner['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $banner['banner_id']; ?>"><?php echo $banner['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_dimension; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][width]" value="<?php echo !empty($module['width']) ? $module['width'] : '980'; ?>" class="span1" />
                  <span>&nbsp;x&nbsp;</span>
                  <input type="text" name="nivoslider_module[<?php echo $module_row; ?>][height]" value="<?php echo !empty($module['height']) ? $module['height'] : '280'; ?>" class="span1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_style; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][style]" class="span3">
                    <?php if ($module['style'] == 'elegant') { ?>
                    <option value="elegant" selected="selected"><?php echo $text_elegant_style; ?></option>
                    <?php } else { ?>
                    <option value="elegant"><?php echo $text_elegant_style; ?></option>
                    <?php } ?>
                    <?php if ($module['style'] == 'bar') { ?>
                    <option value="bar" selected="selected"><?php echo $text_bar_style; ?></option>
                    <?php } else { ?>
                    <option value="bar"><?php echo $text_bar_style; ?></option>
                    <?php } ?>
                    <?php if ($module['style'] == 'light') { ?>
                    <option value="light" selected="selected"><?php echo $text_light_style; ?></option>
                    <?php } else { ?>
                    <option value="light"><?php echo $text_light_style; ?></option>
                    <?php } ?>
                    <?php if ($module['style'] == 'dark') { ?>
                    <option value="dark" selected="selected"><?php echo $text_dark_style; ?></option>
                    <?php } else { ?>
                    <option value="dark"><?php echo $text_dark_style; ?></option>
                    <?php } ?>
                    <?php if ($module['style'] == 'default') { ?>
                    <option value="default" selected="selected"><?php echo $text_default_style; ?></option>
                    <?php } else { ?>
                    <option value="default"><?php echo $text_default_style; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_autoplay; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][autoplay]" class="span3">
                    <?php if (isset($module['autoplay']) && $module['autoplay'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if (isset($module['autoplay']) && $module['autoplay'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_effect; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][effect]" class="span3">
                    <?php if ($module['effect'] == 'random') { ?>
                    <option value="random" selected="selected">random</option>
                    <?php } else { ?>
                    <option value="random">random</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'fade') { ?>
                    <option value="fade" selected="selected">fade</option>
                    <?php } else { ?>
                    <option value="fade">fade</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'fold') { ?>
                    <option value="fold" selected="selected">fold</option>
                    <?php } else { ?>
                    <option value="fold">fold</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceDown') { ?>
                    <option value="sliceDown" selected="selected">sliceDown</option>
                    <?php } else { ?>
                    <option value="sliceDown">sliceDown</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceDownLeft') { ?>
                    <option value="sliceDownLeft" selected="selected">sliceDownLeft</option>
                    <?php } else { ?>
                    <option value="sliceDownLeft">sliceDownLeft</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceUp') { ?>
                    <option value="sliceUp" selected="selected">sliceUp</option>
                    <?php } else { ?>
                    <option value="sliceUp">sliceUp</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceUpLeft') { ?>
                    <option value="sliceUpLeft" selected="selected">sliceUpLeft</option>
                    <?php } else { ?>
                    <option value="sliceUpLeft">sliceUpLeft</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceUpDown') { ?>
                    <option value="sliceUpDown" selected="selected">sliceUpDown</option>
                    <?php } else { ?>
                    <option value="sliceUpDown">sliceUpDown</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'sliceUpDownLeft') { ?>
                    <option value="sliceUpDownLeft" selected="selected">sliceUpDownLeft</option>
                    <?php } else { ?>
                    <option value="sliceUpDownLeft">sliceUpDownLeft</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'slideInRight') { ?>
                    <option value="slideInRight" selected="selected">slideInRight</option>
                    <?php } else { ?>
                    <option value="slideInRight">slideInRight</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'slideInLeft') { ?>
                    <option value="slideInLeft" selected="selected">slideInLeft</option>
                    <?php } else { ?>
                    <option value="slideInLeft">slideInLeft</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'boxRandom') { ?>
                    <option value="boxRandom" selected="selected">boxRandom</option>
                    <?php } else { ?>
                    <option value="boxRandom">boxRandom</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'boxRain') { ?>
                    <option value="boxRain" selected="selected">boxRain</option>
                    <?php } else { ?>
                    <option value="boxRain">boxRain</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'boxRainReverse') { ?>
                    <option value="boxRainReverse" selected="selected">boxRainReverse</option>
                    <?php } else { ?>
                    <option value="boxRainReverse">boxRainReverse</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'boxRainGrow') { ?>
                    <option value="boxRainGrow" selected="selected">boxRainGrow</option>
                    <?php } else { ?>
                    <option value="boxRainGrow">boxRainGrow</option>
                    <?php } ?>
                    <?php if ($module['effect'] == 'boxRainGrowReverse') { ?>
                    <option value="boxRainGrowReverse" selected="selected">boxRainGrowReverse</option>
                    <?php } else { ?>
                    <option value="boxRainGrowReverse">boxRainGrowReverse</option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_speed; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][speed]" value="<?php echo !empty($module['speed']) ? $module['speed'] : '3000'; ?>" class="span1" />
                  &nbsp;&nbsp;
                  <input type="text" name="nivoslider_module[<?php echo $module_row; ?>][duration]" value="<?php echo !empty($module['duration']) ? $module['duration'] : '500'; ?>" class="span1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_boxes; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][boxcols]" value="<?php echo !empty($module['boxcols']) ? $module['boxcols'] : '8'; ?>" class="span1" />
                  &nbsp;&nbsp;
                  <input type="text" name="nivoslider_module[<?php echo $module_row; ?>][boxrows]" value="<?php echo !empty($module['boxrows']) ? $module['boxrows'] : '4'; ?>" class="span1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_slices; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][slices]" value="<?php echo !empty($module['slices']) ? $module['slices'] : '15'; ?>" class="span1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_start; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][start]" value="<?php echo !empty($module['start']) ? $module['start'] : '1'; ?>" class="span1" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_pause; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][pause]" class="span3">
                    <?php if ($module['pause'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if ($module['pause'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_random; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][random]" class="span3">
                    <?php if ($module['random'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if ($module['random'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_directionnav; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][directionnav]" class="span3">
                    <?php if ($module['directionnav'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if ($module['directionnav'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_controlnav; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][controlnav]" class="span3">
                    <?php if ($module['controlnav'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if ($module['controlnav'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_caption; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][caption]" class="span3">
                    <?php if ($module['caption']) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_thumbnails; ?></td>
                <td><select name="nivoslider_module[<?php echo $module_row; ?>][controlnavthumbs]" class="span3">
                    <?php if ($module['controlnavthumbs'] == 'true') { ?>
                    <option value="true" selected="selected"><?php echo $text_enabled; ?></option>
                    <?php } else { ?>
                    <option value="true"><?php echo $text_enabled; ?></option>
                    <?php } ?>
                    <?php if ($module['controlnavthumbs'] == 'false') { ?>
                    <option value="false" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="false"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_thumbwidth; ?></td>
                <td><input type="text" name="nivoslider_module[<?php echo $module_row; ?>][thumb_width]" value="<?php echo !empty($module['thumb_width']) ? $module['thumb_width'] : '120'; ?>" class="span1" /></td>
              </tr>
            </table>
          </div>
          <div id="tab-triggers-<?php echo $module_row; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_beforechange; ?></td>
                <td><textarea name="nivoslider_module[<?php echo $module_row; ?>][beforechange]" class="span3" rows="5" placeholder="function() { ... }"><?php echo isset($module['beforechange']) ? $module['beforechange'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_afterchange; ?></td>
                <td><textarea name="nivoslider_module[<?php echo $module_row; ?>][afterchange]" class="span3" rows="5" placeholder="function() { ... }"><?php echo isset($module['afterchange']) ? $module['afterchange'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_slideshowend; ?></td>
                <td><textarea name="nivoslider_module[<?php echo $module_row; ?>][slideshowend]" class="span3" rows="5" placeholder="function() { ... }"><?php echo isset($module['slideshowend']) ? $module['slideshowend'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_lastslide; ?></td>
                <td><textarea name="nivoslider_module[<?php echo $module_row; ?>][lastslide]" class="span3" rows="5" placeholder="function() { ... }"><?php echo isset($module['lastslide']) ? $module['lastslide'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_afterload; ?></td>
                <td><textarea name="nivoslider_module[<?php echo $module_row; ?>][afterload]" class="span3" rows="5" placeholder="function() { ... }"><?php echo isset($module['afterload']) ? $module['afterload'] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
  html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
  html += '  <div id="tabs-'+ module_row + '" class="htabs">';
  html += '    <a href="#tab-module-setting-'+ module_row + '"><?php echo $tab_setting; ?></a><a href="#tab-slider-config-'+ module_row + '"><?php echo $tab_config; ?></a><a href="#tab-triggers-'+ module_row + '"><?php echo $tab_triggers; ?></a>';
  html += '  </div>';
  html += '  <div id="tab-module-setting-'+ module_row + '">';
  html += '    <table class="form">';
  html += '      <tr>';
  html += '        <td><?php echo $entry_module_name; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][module_name]" value="" class="span3" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_store; ?></td>';
  html += '        <td><div class="row">';
  html += '          <div class="span3">';
  html += '            <label class="checkbox">';
  html += '              <input type="checkbox" name="nivoslider_module[' + module_row + '][store_id][]" value="" checked="checked" />';
  html += '              <?php echo addslashes($default_store); ?> </label>';
  <?php foreach ($stores as $store) { ?>
  html += '            <label class="checkbox">';
  html += '              <input type="checkbox" name="nivoslider_module[' + module_row + '][store_id][]" value="<?php echo $store['store_id']; ?>" checked="checked" />';
  html += '              <?php echo addslashes($store['name']); ?> </label>';
  <?php } ?>
  html += '          </div>';
  html += '        </div></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_layout; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][layout_id]" class="span3" onchange="if ($(this).val() == 3) {$(\'#featured-cid-' + module_row + '\').show();} else {$(\'#featured-cid-' + module_row + '\').hide();}">';
  <?php foreach ($layouts as $layout) { ?>
  html += '          <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  <?php } ?>
  html += '          </select></td>';
  html += '      </tr>';
  html += '      <tr id="featured-cid-' + module_row + '" style="display:none;">';
  html += '        <td><?php echo $entry_featured_cat; ?></td>';
  html += '        <td><div class="scrollbox">';
  <?php $class = 'odd'; ?>
  <?php foreach ($categories as $category) { ?>
  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
  html += '          <div class="<?php echo $class; ?>">';
  html += '          <label><input type="checkbox" name="nivoslider_module[' + module_row + '][featured_cid][]" value="<?php echo $category['category_id']; ?>" />';
  html += '          <?php echo addslashes($category['name']); ?></label>';
  html += '          </div>';
  <?php } ?>
 html += '        </div><a onclick="$(this).parent().find(\':checkbox\').attr(\'checked\', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(\':checkbox\').attr(\'checked\', false);"><?php echo $text_unselect_all; ?></a></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_position; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][position]" class="span3">';
  html += '          <option value="content_top"><?php echo $text_content_top; ?></option>';
  html += '          <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
  html += '          <option value="column_left"><?php echo $text_column_left; ?></option>';
  html += '          <option value="column_right"><?php echo $text_column_right; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_status; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][status]" class="span3">';
  html += '          <option value="1"><?php echo $text_enabled; ?></option>';
  html += '          <option value="0"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_sort_order; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][sort_order]" value="" class="span1" /></td>';
  html += '      </tr>';
  html += '    </table>';
  html += '  </div>';
  html += '  <div id="tab-slider-config-'+ module_row + '">';
  html += '    <table class="form">';
  html += '      <tr>';
  html += '        <td><?php echo $entry_banner; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][banner_id]" class="span3">';
  <?php foreach ($banners as $banner) { ?>
  html += '          <option value="<?php echo $banner['banner_id']; ?>"><?php echo addslashes($banner['name']); ?></option>';
  <?php } ?>
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_dimension; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][width]" value="980" class="span1" /> <span>&nbsp;x&nbsp;</span> <input type="text" name="nivoslider_module[' + module_row + '][height]" value="280" class="span1" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_style; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][style]" class="span3">';
  html += '          <option value="elegant"><?php echo $text_elegant_style; ?></option>';
  html += '          <option value="bar"><?php echo $text_bar_style; ?></option>';
  html += '          <option value="light"><?php echo $text_light_style; ?></option>';
  html += '          <option value="dark"><?php echo $text_dark_style; ?></option>';
  html += '          <option value="default"><?php echo $text_default_style; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_autoplay; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][autoplay]" class="span3">';
  html += '          <option value="false"><?php echo $text_enabled; ?></option>';
  html += '          <option value="true"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_effect; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][effect]" class="span3">';
  html += '          <option value="random">random</option>';
  html += '          <option value="fade">fade</option>';
  html += '          <option value="fold">fold</option>';
  html += '          <option value="sliceDown">sliceDown</option>';
  html += '          <option value="sliceDownLeft">sliceDownLeft</option>';
  html += '          <option value="sliceUp">sliceUp</option>';
  html += '          <option value="sliceUpLeft">sliceUpLeft</option>';
  html += '          <option value="sliceUpDown">sliceUpDown</option>';
  html += '          <option value="sliceUpDownLeft">sliceUpDownLeft</option>';
  html += '          <option value="slideInRight">slideInRight</option>';
  html += '          <option value="slideInLeft">slideInLeft</option>';
  html += '          <option value="boxRandom">boxRandom</option>';
  html += '          <option value="boxRain">boxRain</option>';
  html += '          <option value="boxRainReverse">boxRainReverse</option>';
  html += '          <option value="boxRainGrow">boxRainGrow</option>';
  html += '          <option value="boxRainGrowReverse">boxRainGrowReverse</option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_speed; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][speed]" value="3000" class="span1" /> &nbsp;&nbsp; <input type="text" name="nivoslider_module[' + module_row + '][duration]" value="500" class="span1" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_boxes; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][boxcols]" value="8" class="span1" /> &nbsp;&nbsp; <input type="text" name="nivoslider_module[' + module_row + '][boxrows]" value="4" class="span1" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_slices; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][slices]" value="15" class="span1" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_start; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][start]" value="1" class="span1" /></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_pause; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][pause]" class="span3">';
  html += '          <option value="true"><?php echo $text_enabled; ?></option>';
  html += '          <option value="false"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_random; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][random]" class="span3">';
  html += '          <option value="false"><?php echo $text_disabled; ?></option>';
  html += '          <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_directionnav; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][directionnav]" class="span3">';
  html += '          <option value="true"><?php echo $text_enabled; ?></option>';
  html += '          <option value="false"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_controlnav; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][controlnav]" class="span3">';
  html += '          <option value="true"><?php echo $text_enabled; ?></option>';
  html += '          <option value="false"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_caption; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][caption]" class="span3">';
  html += '          <option value="1"><?php echo $text_enabled; ?></option>';
  html += '          <option value="0"><?php echo $text_disabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_thumbnails; ?></td>';
  html += '        <td><select name="nivoslider_module[' + module_row + '][controlnavthumbs]" class="span3">';
  html += '          <option value="false"><?php echo $text_disabled; ?></option>';
  html += '          <option value="true"><?php echo $text_enabled; ?></option>';
  html += '        </select></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_thumbwidth; ?></td>';
  html += '        <td><input type="text" name="nivoslider_module[' + module_row + '][thumb_width]" value="120" class="span1" /></td>';
  html += '      </tr>';
  html += '    </table>';
  html += '  </div>';
  html += '  <div id="tab-triggers-'+ module_row + '">';
  html += '    <table class="form">';
  html += '      <tr>';
  html += '        <td><?php echo $entry_beforechange; ?></td>';
  html += '        <td><textarea name="nivoslider_module[' + module_row + '][beforechange]" class="span3" rows="5" placeholder="function() { ... }"></textarea></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_afterchange; ?></td>';
  html += '        <td><textarea name="nivoslider_module[' + module_row + '][afterchange]" class="span3" rows="5" placeholder="function() { ... }"></textarea></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_slideshowend; ?></td>';
  html += '        <td><textarea name="nivoslider_module[' + module_row + '][slideshowend]" class="span3" rows="5" placeholder="function() { ... }"></textarea></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_lastslide; ?></td>';
  html += '        <td><textarea name="nivoslider_module[' + module_row + '][lastslide]" class="span3" rows="5" placeholder="function() { ... }"></textarea></td>';
  html += '      </tr>';
  html += '      <tr>';
  html += '        <td><?php echo $entry_afterload; ?></td>';
  html += '        <td><textarea name="nivoslider_module[' + module_row + '][afterload]" class="span3" rows="5" placeholder="function() { ... }"></textarea></td>';
  html += '      </tr>';
  html += '    </table>';
  html += '  </div>';
  
  $('#form').append(html);
  $('#tabs-' + module_row + ' a').tabs();
  
  $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();  
  $('#module-' + module_row).trigger('click');
  
  module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#tabs-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>