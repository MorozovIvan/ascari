<style type="text/css">
#pollResultsName {
    font-size:14px;
    margin-bottom:10px;
    margin-top:5px;
}
.holder {
	height:22px;
	width:162px;
	position:relative;
}
.emptyPoll, .fullPoll {
	height:20px;
	border:1px solid;
	border-radius:4px;
}
.emptyPoll {
	width:160px;
	background: #eeeeee;
	background: -moz-linear-gradient(top, #eeeeee 0%, #cccccc 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#eeeeee), color-stop(100%,#cccccc));
	background: -webkit-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	background: -o-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	background: -ms-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#eeeeee', endColorstr='#cccccc',GradientType=0 );
	background: linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	border-color:#aaa;
}
.fullPoll {
<?php if ($poll_color == 'red') { ?>
	background: #f85032;
	background: -moz-linear-gradient(top, #f85032 0%, #f16f5c 50%, #f6290c 51%, #f02f17 71%, #e73827 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f85032), color-stop(50%,#f16f5c), color-stop(51%,#f6290c), color-stop(71%,#f02f17), color-stop(100%,#e73827));
	background: -webkit-linear-gradient(top, #f85032 0%,#f16f5c 50%,#f6290c 51%,#f02f17 71%,#e73827 100%);
	background: -o-linear-gradient(top, #f85032 0%,#f16f5c 50%,#f6290c 51%,#f02f17 71%,#e73827 100%);
	background: -ms-linear-gradient(top, #f85032 0%,#f16f5c 50%,#f6290c 51%,#f02f17 71%,#e73827 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f85032', endColorstr='#e73827',GradientType=0 );
	background: linear-gradient(top, #f85032 0%,#f16f5c 50%,#f6290c 51%,#f02f17 71%,#e73827 100%);
	border-color:#BF2020;
<?php } elseif ($poll_color == 'blue') { ?>
	background: #3237f8;
	background: -moz-linear-gradient(top, #3237f8 0%, #7276ed 50%, #0d15f4 51%, #2027eb 71%, #2e34d5 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#3237f8), color-stop(50%,#7276ed), color-stop(51%,#0d15f4), color-stop(71%,#2027eb), color-stop(100%,#2e34d5));
	background: -webkit-linear-gradient(top, #3237f8 0%,#7276ed 50%,#0d15f4 51%,#2027eb 71%,#2e34d5 100%);
	background: -o-linear-gradient(top, #3237f8 0%,#7276ed 50%,#0d15f4 51%,#2027eb 71%,#2e34d5 100%);
	background: -ms-linear-gradient(top, #3237f8 0%,#7276ed 50%,#0d15f4 51%,#2027eb 71%,#2e34d5 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3237f8', endColorstr='#2e34d5',GradientType=0 );
	background: linear-gradient(top, #3237f8 0%,#7276ed 50%,#0d15f4 51%,#2027eb 71%,#2e34d5 100%);
	border-color:#1b20a7;

<?php } elseif ($poll_color == 'green') { ?>
	background: #53f343;
	background: -moz-linear-gradient(top, #53f343 0%, #b3f5ad 50%, #1ff20b 51%, #3edb2f 71%, #4fe740 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#53f343), color-stop(50%,#b3f5ad), color-stop(51%,#1ff20b), color-stop(71%,#3edb2f), color-stop(100%,#4fe740));
	background: -webkit-linear-gradient(top, #53f343 0%,#b3f5ad 50%,#1ff20b 51%,#3edb2f 71%,#4fe740 100%);
	background: -o-linear-gradient(top, #53f343 0%,#b3f5ad 50%,#1ff20b 51%,#3edb2f 71%,#4fe740 100%);
	background: -ms-linear-gradient(top, #53f343 0%,#b3f5ad 50%,#1ff20b 51%,#3edb2f 71%,#4fe740 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#53f343', endColorstr='#4fe740',GradientType=0 );
	background: linear-gradient(top, #53f343 0%,#b3f5ad 50%,#1ff20b 51%,#3edb2f 71%,#4fe740 100%);
	border-color:#22aa15;

<?php } ?>
	position:absolute;
	top:0;
	z-index:10;
}
.votes {
	font-size:10px;
	float:right;
}
.pollButton {
	text-shadow:0 1px #eee;
	padding:8px;
	color:#666 !important;
	height:20px;
	border-radius:5px;
	text-decoration:none;
	margin-right:5px;
	margin-top:10px;
	border:1px solid #ddd;
	background: #eeeeee;
	background: -moz-linear-gradient(top, #eeeeee 0%, #cccccc 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#eeeeee), color-stop(100%,#cccccc));
	background: -webkit-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	background: -o-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	background: -ms-linear-gradient(top, #eeeeee 0%,#cccccc 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#eeeeee', endColorstr='#cccccc',GradientType=0 );
	background: linear-gradient(top, #eeeeee 0%,#cccccc 100%);
}
.pollButton:hover {
	text-shadow:0 1px #408400;
	color:#fff !important;
	background: #bfd255;
	background: -moz-linear-gradient(top, #bfd255 0%, #8eb92a 50%, #72aa00 51%, #9ecb2d 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#bfd255), color-stop(50%,#8eb92a), color-stop(51%,#72aa00), color-stop(100%,#9ecb2d));
	background: -webkit-linear-gradient(top, #bfd255 0%,#8eb92a 50%,#72aa00 51%,#9ecb2d 100%);
	background: -o-linear-gradient(top, #bfd255 0%,#8eb92a 50%,#72aa00 51%,#9ecb2d 100%);
	background: -ms-linear-gradient(top, #bfd255 0%,#8eb92a 50%,#72aa00 51%,#9ecb2d 100%);
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#bfd255', endColorstr='#9ecb2d',GradientType=0 );
	background: linear-gradient(top, #bfd255 0%,#8eb92a 50%,#72aa00 51%,#9ecb2d 100%);
}
.pollBack {
	margin-bottom:0;
	margin-top:5px;
}
.responseP {
	margin-top:0 !important;
	margin-bottom:0 !important;

#responses {
	clear:both;
}
</style>
<div class="box">
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content" id="poll">
		<h5 id="pollResultsName"><?php echo($poll_name); ?></h5>
		<div id="responses">
		<?php foreach ($poll_responses as $response) { ?> 
			    <p class="responseP"><input type="radio" id="response<?php echo $response['id']; ?>" name="poll_response_add" value="<?php echo $response['id']; ?>" />
			  	&emsp;
			  	<label for="response<?php echo $response['id']; ?>"><?php echo $response['name']; ?></label></p>
		<?php } ?>
		<br style="clear:both" />
		</div>
	  		<a href="#" id="voteButton" class="pollButton" onclick="return answerPoll();">Ответить</a><a href="#" id="showButton" class="pollButton" onclick="return showResults();">Результаты</a>
	</div>
</div>
<script type="text/javascript">
function answerPoll()
{
	id = $("#poll input:checked").attr("value");
  	$.ajax({
  		  	url: "<?php echo $poll_ajax_url; ?>",
			type: "POST",
			data: "poll_response_add="+id,
			success: function(response) {
					$("#poll").html(response);
				}
  	});
  	return false;
}
function showResults()
{
	id = $("#poll input:checked").attr("value");
  	$.ajax({
  		  	url: "<?php echo $poll_ajax_url; ?>",
			type: "POST",
			success: function(response) {
					$("#poll").html(response);
				}
  	});
  	return false;
}
</script>