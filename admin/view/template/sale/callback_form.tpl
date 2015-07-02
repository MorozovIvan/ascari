<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div class="box">
    <div class="heading">
     <h1> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td><span class="required">*</span> <?php echo $text_id; ?></td>
              <td><input type="text" name="call_id" value="<?php echo $callback_id; ?>"  disabled/></td>
            </tr>
            <tr>
              <td> <?php echo $text_name; ?></td>
              <td><input type="text" name="name" value="<?php echo $name; ?>"  disabled/></td>
            </tr>
            <tr>
              <td><?php echo $text_telephone; ?></td>
              <td><input type="text" name="telephone" value="<?php echo $telephone; ?>"  disabled/></td>
            </tr>
            <tr>
              <td> <?php echo $text_comment; ?></td>
              <td><textarea style="width: 50%" rows="4" cols="40" name="comment"   ><?php echo $comment; ?></textarea></td>
            </tr>
			<tr>
              <td> <?php echo $text_comment_buyer; ?></td>
              <td><textarea style="width: 50%" rows="4" cols="40" name="comment_buyer"   disabled><?php echo $comment_buyer; ?></textarea></td>
            </tr>
			<tr>
              <td> <?php echo $text_email_buyer; ?></td>
              <td><input type="text" name="name" value="<?php echo $email_buyer; ?>"/></td>
            </tr>
			<tr>
			<tr>
				<td><?php echo $text_manager_form;?></td>
				<td>
					<select name="username">
					<?php if ($username !='') { ?>
					<option value="<?php echo $username ;?>"><?php echo $username; ?></option>
					<?php } else { ?>
					<option value=""><?php echo $text_manager_form; ?></option>
					<?php } ?>
					<?php foreach ($users as $user){?>
					<option value="<?php echo $user['username']?>"><?php echo $user['username']?></option>
					<?php }?>
					</select>
				</td>
			</tr>
            <tr>
              <td> <?php echo $text_status; ?></td>
            <td><select name="status_id">

                <?php if ($status_id == '0') { ?>
                <option value="0" selected="selected"><?php echo $status_wait; ?></option>
                <option value="1" ><?php echo $status_done; ?></option>
                <?php } else { ?>
                <option value="0" ><?php echo $status_wait; ?></option>
                <option value="1" selected="selected"><?php echo $status_done; ?></option>
                <?php } ?>
 
              </select></td>
            </tr>
            <tr>
              <td> <?php echo $text_added; ?></td>
              <td><input type="text" name="date_added" value="<?php echo $date_added; ?>"  disabled/>
	      </td>
            </tr>
            <tr>
              <td> <?php echo $text_modified; ?></td>
              <td><input type="text" name="date_modified" value="<?php echo $date_modified; ?>"  disabled/>
	      </td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--

//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs(); 
//--></script> 
<?php echo $footer; ?>
