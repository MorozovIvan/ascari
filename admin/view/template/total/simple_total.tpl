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
      <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_custom_id; ?><span class="help"><?php echo $entry_custom_help ?></span></td>
            <td>
              <select name="simple_total_custom_id">
              <?php foreach ($custom_fields as $key => $value) { ?>
                <option value="<?php echo $key ?>" <?php echo $simple_total_custom_id == $key ? 'selected="selected"' : ''; ?>><?php echo $value ?></option>      
              <?php } ?>  
              </select>
            </td>
          </tr>
          <tr>
            <td><?php echo $entry_custom_value; ?></td>
            <td><input type="text" name="simple_total_custom_value" value="<?php echo $simple_total_custom_value; ?>" /></td>
          </tr>
          <tr>
            <td>
                <?php echo $entry_total_label; ?>
            </td>
            <td>
                <?php foreach ($languages as $language) { ?>
                <div><img src="view/image/flags/<?php echo $language['image']; ?>" />&nbsp;<input type="text" name="simple_total_label[<?php echo $language['code'] ?>]" value="<?php echo !empty($simple_total_label[$language['code']]) ? $simple_total_label[$language['code']] : '' ?>"></div>
                <?php } ?>
            </td>  
          </tr>
          <tr>
            <td><?php echo $entry_total_value; ?></td>
            <td><input type="text" name="simple_total_value" value="<?php echo $simple_total_value; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="simple_total_status">
                <?php if ($simple_total_status) { ?>
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
            <td><input type="text" name="simple_total_sort_order" value="<?php echo $simple_total_sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>