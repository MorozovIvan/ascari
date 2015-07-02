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
      <h1> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').attr('action', '<?php echo $update; ?>'); $('#form').submit();" class="button"><span><?php echo $status_done; ?></span></a><a onclick="$('form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>

              <td class="left"><?php if ($sort == 'call_id') { ?>
                <a href="<?php echo $sort_call_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo "Номер"; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_call_id; ?>"><?php echo "Номер"; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
              <td class="right"><?php if ($sort == 'telephone') { ?>
                <a href="<?php echo $sort_telephone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_telephone; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_telephone; ?>"><?php echo $column_telephone; ?></a>
                <?php } ?></td>
			  <td class="right"><?php echo $text_comment_buyer; ?></td>
			  <td class="right"><?php echo $text_email_buyer; ?></td>
			  <td class="right"><?php echo $text_comment; ?></td>
			  <td class="right"><?php if ($sort == 'username') { ?>
                <a href="<?php echo $sort_username; ?>" class="<?php echo strtolower($order); ?>"><?php echo $text_manager; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_username; ?>"><?php echo $text_manager; ?></a>
                <?php } ?></td>
			 
              <td class="right"><?php echo $text_status; ?></td>
              <td class="right"><?php echo $text_added; ?></td>
              <td class="right"><?php echo $text_modified; ?></td>
              <td class="right"><?php echo $text_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($callbacks) { ?>
            <?php foreach ($callbacks as $callback) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($callback['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $callback['callback_id']; ?></td>
              <td class="left"><?php echo $callback['name']; ?></td>
              <td class="right"><?php echo $callback['telephone']; ?></td>
              <td class="left"><?php echo utf8_substr(strip_tags($callback['comment_buyer']),0,50); ?></td>
              <td class="right"><?php echo $callback['email_buyer']; ?></td>
			  <td class="left"><?php echo utf8_substr(strip_tags($callback['comment']),0,50); ?></td> 
			  <td class="right"><?php echo $callback['username']; ?></td>
           <?php if ($callback['status'] == $status_done) { ?>
              <td class="right" style="background:#0BED0B;"><?php echo $callback['status']; ?></td>
            <?php } else { ?>
              <td class="right" style="background:#EDB40B;"><?php echo $callback['status']; ?></td>
            <?php } ?>
              <td class="right"><?php echo $callback['date_added']; ?></td>
             <td class="right"><?php echo $callback['date_modified']; ?></td>
              <td class="right">[ <a href="<?php echo $callback['action']; ?>"><?php echo $text_edit; ?></a> ]</td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="9"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
