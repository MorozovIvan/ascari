<?php echo $header; ?>
<script type="text/javascript">
function addResponse() {
	var responseInput = '<tr class="responseInput"><td><input type="text" name="poll_response[]"></td></tr>';
	$(".responseInput:last").after(responseInput);
	return false;
}
</script>
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
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><?php echo $entry_status; ?></td>
          <td><select name="poll_active">
              <option value="1"<?php if ($poll_status) { echo ' selected="selected"'; } ?>><?php echo $text_active; ?></option>
              <option value="0"<?php if (!$poll_status) { echo ' selected="selected"'; } ?>><?php echo $text_inactive; ?></option>
            </select></td>
        </tr>
        <tr>
          <td><?php echo $entry_poll_name; ?></td>
          <td><input type="text" name="poll_name" value="<?php echo $poll_name; ?>" /></td>
        </tr>
        <tr>
        	<td><?php echo $entry_poll_responses; ?><a onclick="return addResponse();" class="button" style="float:right;"><span>+</span></a></td>
        	<td>
        	<table>
        	<?php if (isset($poll_responses) && count($poll_responses)) { ?>
        		<?php foreach ($poll_responses as $response) { ?>
        		<tr class="responseInput"><td><input type="text" name="poll_response[]" value="<?php echo $response['name']; ?>"></td></tr>
        		<?php } ?>
        	<?php } else { ?>
        		<tr class="responseInput"><td><input type="text" name="poll_response[]"></td></tr>
        	<?php } ?>
			</table>
			</td>
		</tr>
      </table>
    </form>
  </div>
</div>
<?php echo $footer; ?>