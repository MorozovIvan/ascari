<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/jquery/jquery.scrollTo-1.4.3.1-min.js"></script>
<div id="content">
<style>
.clr{clear:both;}
.filelistall{float:left;margin:4px 5px 0 0}
.t_lang td input{width:200px}
input, textarea{outline:none;}
.t_lang tr:hover td input, .t_lang tr:hover td textarea {background:#f5f5f5;}
.t_lang tr td input:focus, .t_lang tr td textarea:focus {box-shadow: 0 0 5px rgba(47, 197, 240, 1);
    -webkit-box-shadow: 0 0 5px rgba(47, 197, 240, 1); 
    -moz-box-shadow: 0 0 5px rgba(47, 197, 240, 1);
    border:1px solid rgba(47, 197, 240, 0.8); }
    
.show_hide{clear:both;margin:10px 0 10px 20px;font-size:18px}
.filelist{float:left;margin:4px 5px 0 0}
.folders_block{border:1px solid #ccc;display:none;margin:0 20px 30px 20px;padding:10px}
.files_block{border:1px dotted #ccc;margin:5px 20px 20px 15px;padding:10px;}
.files_block .button_add_var{float:left;}
.files_block .button_save_lang{float:right;}
.t_lang td input.new_value{font-size:10px;width:100px;font-weight:bold;}
.s{border-color:#BE2026;}
.save_time{display:none;float:right;font-weight:bold;margin:5px 10px 0 0;}
td input{width:200px; border:1px solid #abadb3;padding:1px;}
td textarea{width:202px; border:1px solid #abadb3;padding:1px;}

.back_error{position:fixed;top:243px;left:36px;display:block;padding:0px 5px 1px;text-align:center;font-size:12px;font-weight:bold;text-decoration:none;color:#fff;background:#BE2026;border:1px solid #BE2026;
-webkit-border-radius:10px 3px 3px 3px;
-moz-border-radius:10px 3px 3px 3px;
-khtml-border-radius:10px 3px 3px 3px;
border-radius:10px 3px 3px 3px;
}
.next_error{position:fixed;top:267px;left:36px;display:block;padding:0px 5px 1px;text-align:center;font-size:12px;font-weight:bold;text-decoration:none;color:#fff;background:#BE2026;border:1px solid #BE2026;
-webkit-border-radius:3px 3px 3px 10px;
-moz-border-radius:3px 3px 3px 10px;
-khtml-border-radius:3px 3px 3px 10px;
border-radius:3px 3px 3px 10px;
}
.back_error:hover, .next_error:hover{color:#BE2026;background:#fff;}
.lang_error{display:block;position:absolute;left:70px;width:10px;height:10px;margin:3px 0 0;background:#BE2026;
-webkit-border-radius:10px;
-moz-border-radius:10px;
-khtml-border-radius:10px;
border-radius:10px;
}
</style>
        
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
  </div>
  <div class="content">
  <span><a class="filelistall" title="<?php echo $entry_showhide; ?>"><?php echo $entry_showhideall; ?></a></span>
   <div class="clr"></div>

    <h2 style="text-transform:uppercase;"><?php echo $entry_title; ?></h2>
        <a class="back_error">˄</a>
        <a class="next_error">˅</a>
      <div class="clr">
        <script type="text/javascript">
			$(document).ready(function(){				
				var notext;
				$('.back_error').click(function() {
					if($('.lang_error:visible:eq(0)').length!=0){
						$('.lang_error:visible:eq(' + notext + ')').stop(true, true);
						$('.lang_error').css('opacity', '0.5');
						
						if ( notext === undefined) {
							notext=0;
						} else {
							notext=notext-1;
						}
						if($('.lang_error:visible:eq(' + notext + ')').length==0){
							notext=$('.lang_error:visible').length-1;
						}
						$('body').scrollTo($('.lang_error:visible:eq(' + notext + ')'), 200, {offset:-258, } );
						$('.lang_error:visible:eq(' + notext + ')').stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
					}else{
						$('body').scrollTo(0, 200);
					}
				});
				
				$('.next_error').click(function() {
					if($('.lang_error:visible:eq(0)').length!=0){
						$('.lang_error:visible:eq(' + notext + ')').stop(true, true);
						$('.lang_error').css('opacity', '0.5');
						
						if ( notext === undefined) {
							notext=0;
						} else {
							notext=notext+1;
						}
						if($('.lang_error:visible:eq(' + notext + ')').length==0){
							notext=0;
						}
						$('body').scrollTo($('.lang_error:visible:eq(' + notext + ')'), 200, {offset:-258, } );
						$('.lang_error:visible:eq(' + notext + ')').stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
					}else{
						$('body').scrollTo($(document).height(), 200);
					}
				});

				$('.lang_error').live('click', function(){
					notext = $(this).index('.lang_error:visible');

					$('.lang_error').css('opacity', '0.5');
					$('body').scrollTo($(this), 200, {offset:-258, } );
					$(this).stop(true, true).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200).animate({opacity: 0.2,}, 200).animate({opacity: 1,}, 200);
				});
			});
		</script>
        <?php 
        $show_folder = '';

        $td_num = 0;
      	foreach($paths_array as $path){
      		$folder = explode('/', $path);
      		if($show_folder != $folder [0]){
      			$show_folder = $folder [0];
      	?>
      			</div>
      			<div class="show_hide">
      				<a class="filelist" title="<?php echo $entry_showhide; ?>">
      					<img src="view/image/add.png" alt="<?php echo $entry_showhide; ?>">
      				</a>
      				<a onclick="$(this).prev().click();"  title="<?php echo $entry_showhide; ?>"><?php echo $show_folder; ?></a>
      			</div>
      			<div class="folders_block">
      		<?php } ?>
      		<div>
	      		<?php echo $folder [1]; ?>
	      		<div class="files_block">
	      			<form method="post" action="<?php echo $action; ?>">
	      			<input type="hidden" name="type" value="<?php echo $this->request->post ['type']; ?>" />
	      			<input type="hidden" name="path" value="<?php echo $path; ?>" />
	      			<table class="t_lang">
						<tr>
						<th></th>
						<?php foreach ($this->request->post ['selected'] as $lang){ ?>
							<th><?php echo $lang; ?></th>
						<?php } ?>
						</tr>
						<?php $input_val = $this->getFileValuesByLang($path, $this->request->post ['selected'], $end_side); ?>
						<?php foreach ($this->getFileVarsByLang($path, $this->request->post ['selected'], $end_side) as $k => $v){ ?>
						<?php $td_num++; ?>
							<tr>
								<td class="tn<?php echo $td_num; ?>"><?php echo $v; ?></td>
								<?php
									$len = 0;
									foreach ($this->request->post ['selected'] as $lang){
										if(isset($input_val{$lang}{$v}) && $len < mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8"))
											$len = mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8");
									}
								?>
								<?php $error_var = 0; ?>
				      			<?php foreach ($this->request->post ['selected'] as $lang){ ?>
									<td>
										<?php if(!isset($input_val{$lang}{$v}) && $error_var==0) { ?>
											<?php $error_var=1; ?>
											<script type="text/javascript">
												$(document).ready(function(){
													$('.tn<?php echo $td_num; ?>').prepend('<div class="lang_error"></div>');
												});
											</script>
										<?php } ?>
										
										<?php if($len > 25){ ?>
											<textarea name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" rows="<?php echo ceil($len / 25);?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?>><?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?></textarea>
										<?php }else{ ?>
											<input type="text" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" value="<?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?> />
										<?php } ?>
									</td>
								<?php } ?>
							</tr>
						<?php } ?>
					</table>
					<div class="buttons">
						<a class="button button_add_var"><span>+</span></a>
						<a class="button button_save_lang"><span><?php echo $button_save; ?></span></a>
						<div class="save_time"></div>
					</div>
					</form>
					<div class="clr"></div>
	
	      		</div>
      		</div>
      	<?php } ?>
      	</div>


	      		<div class="folders_block" style="display:block;">
				<div class="show_hide"><?php echo $entry_languages; ?></div>
	      			<div class="files_block">
		      			<form method="post" action="<?php echo $action; ?>">
		      			<input type="hidden" name="type" value="<?php echo $this->request->post ['type']; ?>" />
		      			<input type="hidden" name="path" value="#main_file" />
		      			<table class="t_lang">
							<tr>
							<th></th>
							<?php foreach ($this->request->post ['selected'] as $lang){ ?>
								<th><?php echo $lang; ?></th>
							<?php } ?>
							</tr>
							<?php $input_val = $this->getFileValuesByLang('#main_file', $this->request->post ['selected'], $end_side); ?>
							<?php foreach ($this->getFileVarsByLang('#main_file', $this->request->post ['selected'], $end_side) as $k => $v){ ?>
							<?php $td_num++; ?>
								<tr>
									<td class="tn<?php echo $td_num; ?>"><?php echo $v; ?>:</td>
									<?php
										$len = 0;
										foreach ($this->request->post ['selected'] as $lang){
											if(isset($input_val{$lang}{$v}) && $len < mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8"))
												$len = mb_strlen (htmlspecialchars($input_val{$lang}{$v}), "UTF-8");
										}
									?>
									<?php $error_var = 0; ?>
					      			<?php foreach ($this->request->post ['selected'] as $lang){ ?>
										<td>
										
											<?php if(!isset($input_val{$lang}{$v}) && $error_var==0) { ?>
											<?php $error_var=1; ?>
												<script type="text/javascript">
													$(document).ready(function(){
														$('.tn<?php echo $td_num; ?>').prepend('<div class="lang_error"></div>');
													});
												</script>
											<?php } ?>
											
											<?php if($len > 25){ ?>
												<textarea name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" rows="<?php echo ceil($len / 25);?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?>><?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?></textarea>
											<?php }else{ ?>
												<input type="text" name="<?php echo 'data[' . $lang . '][' . $v . ']'; ?>" value="<?php echo (isset($input_val{$lang}{$v}) ? htmlspecialchars($input_val{$lang}{$v}) : '') ?>"<?php if(!isset($input_val{$lang}{$v})) echo ' class="s"'; ?> />
											<?php } ?>
										</td>
									<?php } ?>
								</tr>
							<?php } ?>
						</table>
						<div class="buttons">
							<a class="button button_add_var"><span>+</span></a>
							<a class="button button_save_lang"><span><?php echo $button_save; ?></span></a>
							<div class="save_time"></div>
						</div>
						</form>
						<div class="clr"></div>
					</div>
	      		</div>






  </div>
</div>
<?php

?>
<script type="text/javascript">
	$(document).ready(function(){
		$('.button_add_var').click(function(){
			$(this).parent().prev().append("<tr><td><span>text_</span><br /><input type=\"text\" class=\"new_value\" value=\"text_\" /></td><?php foreach ($this->request->post ['selected'] as $lang){ ?><td><textarea name=\"<?php echo 'data[' . $lang . '][-]'; ?>\" rows=\"3\" class=\"<?php echo $lang; ?>\"></textarea></td><?php } ?></tr>");
		});
		$('.new_value').live('keyup', function(){
			//alert($(this).val());
			$(this).prevAll('span').html($(this).val());
			<?php foreach ($this->request->post ['selected'] as $lang){ ?>
			$(this).parent().nextAll().children('.<?php echo $lang; ?>').attr('name', 'data[<?php echo $lang; ?>][' + $(this).val() + ']');
			<?php } ?>
		});
		
		$('.button_save_lang').click(function(){
			var now = new Date();
			var hours = now.getHours();
			var minutes = now.getMinutes();
			var seconds = now.getSeconds();
			var timeValue = '<?php echo $entry_saved; ?>: ' + ((hours < 10) ? "0" : "") + hours;
			timeValue += ((minutes < 10) ? ":0" : ":") + minutes;
			timeValue += ((seconds < 10) ? ":0" : ":") + seconds;

			
			  var save_time = $(this).next('.save_time');
			  $.ajax({
			      type: 'POST',
			      url: $(this).parents('form').attr('action'),
			      data: $(this).parents('form').serialize(),
			      beforeSend: function() {
			    	  save_time.show();
			    	  save_time.html('<?php echo $entry_saving; ?>');
			      },
			      success: function(msg) {
				      if(msg == 'ok') {
					      save_time.fadeOut(500,function(){
					    	  save_time.html(timeValue);
					    	  save_time.fadeIn(500);
						  });
					  } else if(msg == 'error') {
					  	alert(msg);
		      		  } else {
			      		window.location.href = '<?php echo $redirect?>';
		      		  }
			      }
			    });
		});
		
		$('.filelistall').toggle(function(){
			$('.filelist').parent().next().show();
			$('.filelist').children('img').attr('src','view/image/delete.png');
		},function(){
			$('.filelist').parent().next().hide();
			$('.filelist').children('img').attr('src','view/image/add.png');
		}
		);
		  
		$('.filelist').click(function(){
			$(this).parent().next().toggle();
			if($(this).children('img').attr('src')=='view/image/delete.png')
				$(this).children('img').attr('src','view/image/add.png');
			else
				$(this).children('img').attr('src','view/image/delete.png');
		});

		$('.lang_error').css('opacity', '0.5');
		$('.lang_error').hover(function(){ $(this).css('opacity', '0.7'); },function(){ $(this).css('opacity', '0.5'); });
	});
	
</script>
