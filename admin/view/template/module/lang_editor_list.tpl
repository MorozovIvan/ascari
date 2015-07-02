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
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_edit; ?></span></a></div>
  </div>
  <div class="content">
  <div class="error"><ul><?php echo $writable_main; ?></ul></div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	    <table align="center" style="width:400px;margin:-20px auto 5px">
	    	<tr>
			    <td align="center"><input type="radio" name="type" value="front" id="radio_front" checked="checked" /><h3 style="margin:0;"><label for="radio_front"><?php echo $entry_frontend; ?></label></h3></td>
			    <td align="center"><input type="radio" name="type" value="back" id="radio_back" /><h3 style="margin:0;"><label for="radio_back"><?php echo $entry_backend; ?></label></h3></td>
	    	</tr>
	    </table>
      <table id="module" class="list">
        <thead>
          <tr>
          	<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
          	<td width="16"></td>
            <td class="left"><?php echo $entry_languages; ?></td>
            <td class="left"><?php echo $entry_code; ?></td>
            <td class="left"><?php echo $entry_directory; ?></td>
            <td class="left"><?php echo $entry_locale; ?></td>
            <td class="left"><?php echo $entry_permissions; ?></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($languages as $language) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $language['directory']; ?>" /></td>
            <td><img src="/image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['code']; ?>" /></td>
            <td class="left"><?php echo $language['name']; ?></td>
            <td class="left"><?php echo $language['code']; ?></td>
            <td class="left">/<?php echo $language['directory']; ?>/</td>
            <td class="left"><?php echo $language['locale']; ?></td>
            <td class="left"><?php echo $writable[$language['code']]['front']; ?><?php echo $writable[$language['code']]['back']; ?></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
      </table>
    </form>
  </div>
</div>
