
<div style='display:block'>
    <div class='contact-top'></div>
		
		<div class='contact-content'>
		<?php if (($mob !='') || ($config_email_1 !='') || ($block_name_phone !='') || ($config_skype !='') || ($config_title_schedule != '') || ($config_daily !='') || ($config_weekend !='')) { ?>
			<div class="contact-right">
			 
					<h1 class="contact-title">
						<?php if ($block_name_phone[$lang_id]['block_name_phone'] != ''){?>
							<?php echo $block_name_phone[$lang_id]['block_name_phone']; ?>
						<?php }?>
					</h1>
			<div class="content-right">
					<?php if ($mob !='') {?>
						<div class="mob">
						<i style="width:17px; font-size:24px; padding-left:2px;" class="fa fa-mobile"></i>	
							<?php echo $mob; ?>
						</div>
					<?php } ?>
					
					<?php if ($mob2 !='') {?>
						<div class="mob">
						<i style="width:17px; font-size:24px; padding-left:2px;" class="fa fa-mobile"></i>	
							<?php echo $mob2; ?>
						</div>
					<?php } ?>
					<?php if ($mob3 !='') {?>
						<div class="mob">
						<i style="width:20px; font-size:16px;" class="fa fa-print"></i>

							<?php echo $mob3; ?>
						</div>
					<?php } ?>
					<?php if ($config_skype !='') {?>
					<div class="skype">
					<i style="width:20px; font-size:16px;" class="fa fa-skype"></i>

						<?php echo $config_skype; ?>
					</div>
					<?php } ?>
					<?php if ($config_email_1 !='') {?>
					<div class="email">
					<i style="width:20px; font-size:16px;" class="fa fa-envelope-o"></i>
						<?php echo $config_email_1; ?>
					</div>
					<?php } ?>
					<div class="title-schedule">
					<?php if ($config_title_schedule[$lang_id]['config_title_schedule'] != ''){?>
							<i style="width:20px; font-size:16px;" class="fa fa-clock-o"></i>
							<span><?php echo $config_title_schedule[$lang_id]['config_title_schedule']; ?></span>
						<?php }?>
					</div>
					<div>
						<?php if ($config_daily[$lang_id]['config_daily'] != ''){?>
							<span><?php echo $config_daily[$lang_id]['config_daily']; ?></span>
						<?php }?>
					</div>
					<div>
						<?php if ($config_weekend[$lang_id]['config_weekend'] != ''){?>
							<span><?php echo $config_weekend[$lang_id]['config_weekend']; ?></span>
						<?php }?>
					</div>
					</div>
			</div>
			<?php } ?>
	<?php if (($mob !='') || ($config_email_1 !='') || ($block_name_phone !='') || ($config_skype !='') || ($config_title_schedule != '') || ($config_daily !='') || ($config_weekend !='')) {  ?>		
<div class="content-left-50">
<?php } else { ?>
<div class="content-left-100">
<?php } ?>
                <h1 class="contact-title"><?php echo $sendthis; ?></h1>
                <div class='contact-loading' style='display:block'></div>
                <div class='contact-message' style='display:block'></div>
                <form id="data" style='display:block'>
		  <div style="margin:10px 5px;">
		    <div  class="contact-data">
		      <div >
			<div >			
                         <label for='contact-name'><span style="color:red;">*</span> <?php echo $namew; ?></label>
			 <div id="error_name" class="error"></div>
		  	</div>
			<div style="margin-bottom: 3px;">
                         <input type='text' id='contact-name' class='contact-input' placeholder='' name='name' tabindex='1001' />
			</div>
		      </div>
		      <div style="margin-top:15px;">
			<div >			
                         <label for='contact-phone'><span style="color:red;">*</span> <?php echo $phonew; ?></label>
			 <div id="error_phone" class="error"></div>
		  	</div>
			<div style="margin-bottom: 3px;">
                         <input type='text' id='contact-phone' class='contact-input' placeholder='0xx xxxxx' name='phone' tabindex='1002' />
			</div>
		      </div>
			  <div style="margin-top:15px;">
			<div >			
                         <?php echo $email_buyer; ?>
		  	</div>
			<div style="margin-bottom: 3px;">
                         <input type='text' id='contact-email' class='contact-input' placeholder='E-mail' name='email_buyer' tabindex='1003' />
			</div>
		      </div>
			  
			  <div style="margin-top:15px;">
			<div >			
                         <?php echo $comment_buyer; ?>
			 <div id="error_phone" class="error"></div>
		  	</div>
			<div style="margin-bottom: 3px;"> 
						 <textarea name="comment_buyer" id='contact-phone' class='contact-textarea'  cols="40" rows="5" placeholder='Ваш коментарий' tabindex='1004'></textarea>
			</div>
		      </div>

		    </div>
		    
		    
 
		  </div>

                </form>
</div>
<div class="contact-success">
    <div class='success' style='display:none;margin-top:10px;'></div>
</div>
<div class="button-send" style="clear:both;">
          <label>&nbsp;</label>
          <button type='button' class='contact-send contact-button' tabindex='1006'><i style="width:30px; font-size:24px;" class="fa fa-phone-square"></i><?php echo $button_send; ?></button>
	</div>
        </div>
        <div class='contact-bottom'></div>
<script type="text/javascript"><!--
$('.contact-send').bind('click',function() {
		var success = 'false';
		$.ajax({
			url: 'index.php?route=module/callback',
			type: 'post',
			data: $('#data').serialize() + '&action=send',
			dataType: 'json',
			beforeSend: function() {
				$('#subm').bind('click', false);
			},
			complete: function() {
				$('#subm').unbind('click', false);
				if (success == 'true'){
//					setTimeout = ($.colorbox.remove(),1500);
				}
			},
			success: function(json) {
				$('#error_name').empty();
				$('#error_phone').empty();
				$('.success').hide();

				if (json['warning']) {
					if (json['warning']['name']) {
						$('#error_name').html(json['warning']['name']);
					}
					if (json['warning']['phone']) {
						$('#error_phone').html(json['warning']['phone']);
					}
				}
				if (json['success']){ 
					$('.success').html(json['success']);
					$('.success').show('slow');
					success = 'true';
					setTimeout(function () { $.colorbox.close()},2000);

				} 
			}

		});

});

$('.contact-cancel').bind('click',function() {
	$.colorbox.close()
});
//--></script> 
</div>
