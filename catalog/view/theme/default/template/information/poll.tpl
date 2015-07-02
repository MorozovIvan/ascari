<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
  <div class="top">
    <div class="left"></div>
    <div class="right"></div>
    <div class="center">
      <h1><?php echo $heading_title; ?></h1>
    </div>
  </div>
  <div class="middle">
    <?php if (isset($reactions)) { ?>
      <?php $labels = array(); $values = array(); ?>
      <h2 style="margin-top: 0px;"><?php echo $poll_data['question']; ?></h2>
        <table width="100%">
        <thead>
          <tr>
            <th width="10%"><?php echo $text_percent; ?></td>
            <th><?php echo $text_answer; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php for($i = 0; $i < 8; $i++) { ?>
            <?php if (!empty($poll_data['answer_' . ($i + 1)])) { ?>
              <?php array_push($labels, $poll_data['answer_' . ($i + 1)]); ?>
              <?php array_push($values, $percent[$i]); ?>
              <tr>
                <td width="10%"><strong><?php echo $percent[$i]; ?>%</strong></td>
                <td><?php echo $poll_data['answer_' . ($i + 1)]; ?></td>
              </tr>
            <?php } ?>
          <?php } ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="2"><?php echo $text_total_votes . $total_votes; ?></td>
          </tr>
        </tfoot>
      </table>
      <div style="text-align: center; margin-top: 10px; margin-bottom: 10px;">
        <?php $labels = implode('|', $labels); $values = implode(',', $values); ?>
        <img style="border: 1px solid #DDDDDD; text-align: center;" src="http://chart.apis.google.com/chart?cht=p3&chco=303F4A,E4EEF7,849721&chd=t:<?php echo $values; ?>&chs=770x200&chl=<?php echo $labels; ?>" width="500" height="150" alt="chart" />
      </div>
    <?php } else { ?>
      <div style="text-align: center; margin-top: 10px; margin-bottom: 10px;"><?php echo $text_no_votes; ?></div>
    <?php } ?>
    <div class="buttons">
      <table>
        <tr>
          <td align="right"><a onclick="location='<?php echo $continue; ?>'" class="button"><span><?php echo $button_continue; ?></span></a></td>
        </tr>
      </table>
    </div>
  </div>
  <div class="bottom">
    <div class="left"></div>
    <div class="right"></div>
    <div class="center"></div>
  </div>
</div>
<?php echo $footer; ?>
