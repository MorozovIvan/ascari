$(document).ready(function() {
	$("#zatvor").live('click',function(){
		$(this).hide();
		$("#popup").hide();
		$("#popup").html('');
	});
	$("#close_popup").live('click',function(){
		$("#zatvor").hide();
		$("#popup").hide();
		$("#popup").html('');
	});
	$("a.fast_view").live('click',function(){
		var id = $(this).attr('rel');
		$.ajax({
			url: 'index.php?route=product/productpopup',
			type: 'post',
			data: 'product_id='+id,
			dataType: 'json',
			beforeSend: function() {
				$("#zatvor").show();
				$("#zatvor").addClass('active_za');
			},		
			complete: function() {
				$("#zatvor").removeClass('active_za');
			},			
			success: function(json) {
				if (json['redirect']) {
					location = json['redirect'];
				}
				if (json['success']) {
					var top_sc = $(window).scrollTop() + 50;
					$('#popup').html(json['success']);
					$('#popup').css({top:top_sc});
					$('#popup').show();
					//$('html, body').animate({ scrollTop: 0 },'slow');
				}
			}
		});
	});
});