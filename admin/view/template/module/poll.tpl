<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1 style="background-image: url('view/image/module.png');"><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="htabs"><a tab="#tab_general"><?php echo $tab_general; ?></a><a tab="#tab_data"><?php echo $tab_data; ?></a></div>
    <div id="tab_general">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td width="25%"><?php echo $entry_position; ?></td>
            <td><select name="poll_position">
                <?php if ($poll_position == 'left') { ?>
                <option value="left" selected="selected"><?php echo $text_left; ?></option>
                <?php } else { ?>
                <option value="left"><?php echo $text_left; ?></option>
                <?php } ?>
                <?php if ($poll_position == 'right') { ?>
                <option value="right" selected="selected"><?php echo $text_right; ?></option>
                <?php } else { ?>
                <option value="right"><?php echo $text_right; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="poll_status">
                <?php if ($poll_status) { ?>
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
            <td><input type="text" name="poll_sort_order" value="<?php echo $poll_sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
    </div>
    <div id="tab_data">
      <?php if ($poll_status) { ?>
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="list_form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
              <td class="left"><?php echo $column_question; ?></td>
              <td class="right"><?php echo $column_status; ?></td>
              <td class="right"><?php echo $column_active; ?></td>
              <td class="right"><?php echo $column_date_added; ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if ($questions) { ?>
            <?php $class = 'odd'; ?>
            <?php foreach ($questions as $poll) { ?>
            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
            <tr class="<?php echo $class; ?>">
              <td style="align: center;"><?php if ($poll['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $poll['poll_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $poll['poll_id']; ?>" />
                <?php } ?></td>
              <td class="left"><?php echo $poll['question']; ?></td>
              <td class="right"><?php echo $poll['status']; ?></td>
              <td class="right"><?php echo $poll['active']; ?></td>
              <td class="right"><?php echo $poll['date_added']; ?></td>
              <td class="right"><?php foreach ($poll['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr class="even">
              <td class="center" colspan="6"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="buttons"><a onclick="location='<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a><a onclick="$('#list_form').submit();" class="button"><span><?php echo $button_delete; ?></span></a></div>
      <?php } else { ?>
      <div style="text-align: center;"><?php echo $text_module_disabled; ?></div>
      <?php } ?>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$.tabs('#tabs a'); 
//--></script>
<?php echo $footer; ?>
