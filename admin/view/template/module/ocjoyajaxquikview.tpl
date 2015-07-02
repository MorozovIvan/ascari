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
<?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons">
      <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
      <a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a>
    </div>
  </div>
 <div class="content">
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
  <div class="content" style="min-height:500px;">
  <div id="tab-ocjoyajaxquikview">
    <div class="vtabs" style="min-height:470px;" >
      <a href="#ocjoyajaxquikview-settingmain"><?php echo $text_main_tab_setting; ?></a>
      <a href="#ocjoyajaxquikview-licence">Licence</a>
    </div>
    <div id="ocjoyajaxquikview-settingmain" class="vtabs-content" >
    <table class="form">
      <tr>
        <td><?php echo $text_show_on_category; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_category]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_category'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_category'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_category'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_brands; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_brands]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_brands'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_brands'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_brands'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_search; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_search]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_search'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_search'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_search'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_specials; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_specials]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_specials'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_specials'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_specials'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_module_latest; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_latest]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_latest'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_latest'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_latest'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_module_special; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_special]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_special'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_special'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_special'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_module_featured; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_featured]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_featured'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_featured'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_featured'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_on_module_bestseller; ?></td>
        <td>
            <select name="config_ocjoyajaxquikview_form[show_on_bestseller]">
              <option value="0" <?php echo ($config_ocjoyajaxquikview_form['show_on_bestseller'] == 0) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_makeachoice; ?></option>
              <option value="1" <?php echo ($config_ocjoyajaxquikview_form['show_on_bestseller'] == 1) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_yes; ?></option>
              <option value="2" <?php echo ($config_ocjoyajaxquikview_form['show_on_bestseller'] == 2) ? 'selected="selected"' : '' ?>><?php echo $text_ocjoyajaxquikview_no; ?></option>
            </select>
        </td>
      </tr>
      <tr>
        <td></td>
        <td><a id="select_all"><?php echo $text_show_everywhere; ?></a></td>
      </tr>
      <tr>
        <td><?php echo $text_main_image_size; ?></td>
        <td><input type="text" name="config_ocjoyajaxquikview_form[main_width]" value="<?php echo $config_ocjoyajaxquikview_form['main_width'];?>" size="6"/> Х <input type="text" name="config_ocjoyajaxquikview_form[main_height]" value="<?php echo $config_ocjoyajaxquikview_form['main_height'];?>" size="6"/></td>
      </tr>
      <tr>
        <td><?php echo $text_main_popup_image_size; ?></td>
        <td><input type="text" name="config_ocjoyajaxquikview_form[main_popup_width]" value="<?php echo $config_ocjoyajaxquikview_form['main_popup_width'];?>" size="6"/> Х <input type="text" name="config_ocjoyajaxquikview_form[main_popup_height]" value="<?php echo $config_ocjoyajaxquikview_form['main_popup_height'];?>" size="6"/></td>
      </tr>
      <tr>
        <td><?php echo $text_sub_image_size; ?></td>
        <td><input type="text" name="config_ocjoyajaxquikview_form[sub_width]" value="<?php echo $config_ocjoyajaxquikview_form['sub_width'];?>" size="6"/> Х <input type="text" name="config_ocjoyajaxquikview_form[sub_height]" value="<?php echo $config_ocjoyajaxquikview_form['sub_height'];?>" size="6"/></td>
      </tr>
      <tr>
        <td><?php echo $text_show_buttons; ?></td>
        <td>
          <label for="compare"><input type="checkbox" name="config_ocjoyajaxquikview_form[compare]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['compare'])) ? 'checked' : '';?> id="compare"/> <?php echo $text_compare_button; ?></label><br/>
          <label for="wishlist"><input type="checkbox" name="config_ocjoyajaxquikview_form[wishlist]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['wishlist'])) ? 'checked' : '';?> id="wishlist"/> <?php echo $text_wishlist_button; ?></label><br/>
          <label for="more"><input type="checkbox" name="config_ocjoyajaxquikview_form[more]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['more'])) ? 'checked' : '';?> id="more"/> <?php echo $text_more_button; ?></label>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_tabs; ?></td>
        <td>
          <label for="description"><input type="checkbox" name="config_ocjoyajaxquikview_form[show_description]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['show_description'])) ? 'checked' : '';?> id="description"/> <?php echo $text_description_tab; ?></label><br/>
          <label for="reviews"><input type="checkbox" name="config_ocjoyajaxquikview_form[show_reviews]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['show_reviews'])) ? 'checked' : '';?> id="reviews"/> <?php echo $text_reviews_tab; ?></label><br/>
          <label for="related"><input type="checkbox" name="config_ocjoyajaxquikview_form[show_related]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['show_related'])) ? 'checked' : '';?> id="related"/> <?php echo $text_related_tab; ?></label><br/>
          <label for="attributes"><input type="checkbox" name="config_ocjoyajaxquikview_form[show_attributes]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['show_attributes'])) ? 'checked' : '';?> id="attributes"/> <?php echo $text_attributes_tab; ?></label>
        </td>
      </tr>
      <tr>
        <td><?php echo $text_show_socials; ?></td>
        <td>
          <input type="checkbox" name="config_ocjoyajaxquikview_form[socials]" value="1" <?php echo (!empty($config_ocjoyajaxquikview_form['socials'])) ? 'checked' : '';?> />
        </td>
      </tr>
    </table>
  </div>
  <div id="ocjoyajaxquikview-licence" class="vtabs-content" >
    <table class="form">
      <tr>
        <td><?php echo $text_activationcode; ?></td>
        <td>Уже не нужна... </td>
      </tr>
    </table>
  </div>
  
<script type="text/javascript">
  $('.vtabs a').tabs();
  $("#select_all").click(function(){
    $("select option[value='1']").attr('selected', 'selected');
  });
</script>
</div>
  </form>
  </div>
</div>
</div>
<style type="text/css">
input[type="checkbox"] {margin: 2px 6px 0 0 !important;float: left;}
label {padding: 2px 0;display: inline-block;}
</style>
<?php echo $footer; ?>