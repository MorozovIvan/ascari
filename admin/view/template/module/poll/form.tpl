<?php echo $header; ?>
<?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="left"></div>
  <div class="right"></div>
  <div class="heading">
    <h1 style="background-image: url('view/image/pie.png');"><?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location='<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <div id="tabs" class="htabs"><a tab="#tab_general"><?php echo $tab_general; ?></a><a tab="#tab_data"><?php echo $tab_data; ?></a><a tab="#tab_results"><?php echo $tab_results; ?></a></div>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <div id="tab_general">
        <div id="languages" class="htabs">
          <?php foreach ($languages as $language) { ?>
          <a tab="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
          <?php } ?>
        </div>
        <?php foreach ($languages as $language) { ?>
        <div id="language<?php echo $language['language_id']; ?>">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_question; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][question]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['question'] : ''; ?>" size="60" />
                <?php if (isset($error_title[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_title[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_1; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_1]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_1'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_1[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_1[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_2; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_2]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_2'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_2[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_2[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_3; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_3]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_3'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_3[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_3[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_4; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_4]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_4'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_4[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_4[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_5; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_5]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_5'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_5[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_5[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_6; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_6]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_6'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_6[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_6[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_7; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_7]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_7'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_7[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_7[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_answer_8; ?></td>
              <td><input name="poll_description[<?php echo $language['language_id']; ?>][answer_8]" value="<?php echo isset($poll_description[$language['language_id']]) ? $poll_description[$language['language_id']]['answer_8'] : ''; ?>" size="60" />
                <?php if (isset($error_answer_8[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_answer_8[$language['language_id']]; ?></span>
                <?php } ?></td>
            </tr>
          </table>
        </div>
        <?php } ?>
      </div>
      <div id="tab_data">
        <table class="form">
          <tr>
            <td width="25%"><?php echo $entry_status; ?></td>
            <td><select name="status">
              <?php if ($status) { ?>
              <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              <option value="0"><?php echo $text_disabled; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_enabled; ?></option>
              <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
              <?php } ?>
            </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_store; ?></td>
            <td><div class="scrollbox">
                <?php $class = 'even'; ?>
                <div class="<?php echo $class; ?>">
                  <?php if (in_array(0, $poll_store)) { ?>
                  <input type="checkbox" name="poll_store[]" value="0" checked="checked" />
                  <?php echo $text_default; ?>
                  <?php } else { ?>
                  <input type="checkbox" name="poll_store[]" value="0" />
                  <?php echo $text_default; ?>
                  <?php } ?>
                </div>
                <?php foreach ($stores as $store) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php if (in_array($store['store_id'], $poll_store)) { ?>
                  <input type="checkbox" name="poll_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                  <?php echo $store['name']; ?>
                  <?php } else { ?>
                  <input type="checkbox" name="poll_store[]" value="<?php echo $store['store_id']; ?>" />
                  <?php echo $store['name']; ?>
                  <?php } ?>
                </div>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td><?php echo $entry_active; ?></td>
            <td><?php if (isset($new_poll)) { echo $text_new_poll; ?>
              <input type="hidden" name="active" value="0" />
              <?php } else { ?>
              <select name="active">
              <?php if ($active) { ?>
              <option value="1" selected="selected"><?php echo $text_active; ?></option>
              <option value="0"><?php echo $text_inactive; ?></option>
              <?php } else { ?>
              <option value="1"><?php echo $text_active; ?></option>
              <option value="0" selected="selected"><?php echo $text_inactive; ?></option>
              <?php } ?>
              </select>
              <?php foreach ($languages as $language) { ?>
                <?php if (isset($error_active_poll[$language['language_id']])) { ?>
                <span class="error"><?php echo $error_active_poll[$language['language_id']]; ?></span>
                <?php } ?>
              <?php } ?>
            <?php } ?></td>
          </tr>
        </table>
      </div>
      <div id="tab_results">
        <?php if (isset($reactions)) { ?>
          <?php $labels = array(); $values = array(); ?>
          <h1><?php echo $text_poll_results; ?></h1>
          <h2><?php echo $poll_data['question']; ?></h2>
          <table class="list">
            <thead>
              <tr>
                <td width="10%"><?php echo $text_percent; ?></td>
                <td><?php echo $text_answer; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php $class = 'odd'; ?>
              <?php for($i = 0; $i < 8; $i++) { ?>
                <?php if (!empty($poll_data['answer_' . ($i + 1)])) { ?>
                  <?php $class = $class=='even' ? 'odd' : 'even'; ?>
                  <?php array_push($labels, $poll_data['answer_' . ($i + 1)]); ?>
                  <?php array_push($values, $percent[$i]); ?>
                  <tr class="<?php echo $class; ?>">
                    <td><strong><?php echo $percent[$i]; ?>%</strong></td>
                    <td><?php echo $poll_data['answer_' . ($i + 1)]; ?></td>
                  </tr>
                <?php } ?>
              <?php } ?>
            </tbody>
          </table>
          <div style="text-align: center; margin-top: 10px;">
            <?php $labels = implode('|', $labels); $values = implode(',', $values); ?>
            <img src="http://chart.apis.google.com/chart?cht=p3&chco=303F4A,E4EEF7,849721&chd=t:<?php echo $values; ?>&chs=770x200&chl=<?php echo $labels; ?>" width="770" height="200" alt="chart" />
          </div>
        <?php } else { ?>
          <div style="text-align: center; margin-top: 10px;"><?php echo $text_no_votes; ?></div>
        <?php } ?>
      </div>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
$.tabs('#tabs a'); 
$.tabs('#languages a'); 
//--></script>
<?php echo $footer; ?>
