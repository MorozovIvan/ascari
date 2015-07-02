$(document).ready(function() {
	/* Search */
	$('.button-search').bind('click', function() {
		url = $('base').attr('href') + 'index.php?route=product/search';
				 
		var search = $('input[name=\'search\']').attr('value');
		
		if (search) {
			url += '&search=' + encodeURIComponent(search);
		}
		
		location = url;
	});
	
	$('#header input[name=\'search\']').bind('keydown', function(e) {
		if (e.keyCode == 13) {
			url = $('base').attr('href') + 'index.php?route=product/search';
			 
			var search = $('input[name=\'search\']').attr('value');
			
			if (search) {
				url += '&search=' + encodeURIComponent(search);
			}
			
			location = url;
		}
	});
	
	/* Ajax Cart */
	$('#cart').live('click', function() {
		$('#cart').addClass('active');
		
		$('#cart').load('index.php?route=module/cart #cart > *');
		
		$('#cart').live('mouseleave', function() {
			$(this).removeClass('active');
		});
	});
	
	/* Mega Menu */
	$('#menu ul > li > a + div').each(function(index, element) {
		// IE6 & IE7 Fixes
		if ($.browser.msie && ($.browser.version == 7 || $.browser.version == 6)) {
			var category = $(element).find('a');
			var columns = $(element).find('ul').length;
			
			$(element).css('width', (columns * 143) + 'px');
			$(element).find('ul').css('float', 'left');
		}		
		
		var menu = $('#menu').offset();
		var dropdown = $(this).parent().offset();
		
		i = (dropdown.left + $(this).outerWidth()) - (menu.left + $('#menu').outerWidth());
		
		if (i > 0) {
			$(this).css('margin-left', '-' + (i + 5) + 'px');
		}
	});

	// IE6 & IE7 Fixes
	if ($.browser.msie) {
		if ($.browser.version <= 6) {
			$('#column-left + #column-right + #content, #column-left + #content').css('margin-left', '195px');
			
			$('#column-right + #content').css('margin-right', '195px');
		
			$('.box-category ul li a.active + ul').css('display', 'block');	
		}
		
		if ($.browser.version <= 7) {
			$('#menu > ul > li').bind('mouseover', function() {
				$(this).addClass('active');
			});
				
			$('#menu > ul > li').bind('mouseout', function() {
				$(this).removeClass('active');
			});	
		}
	}
	
	$('.success img, .warning img, .attention img, .information img').live('click', function() {
		$(this).parent().fadeOut('slow', function() {
			$(this).remove();
		});
	});

    // CUSTOM BY IVAN BEGIN

    var htmlModalQView = '<div id="quickViewModal" class="reveal-modal">'+
                            '<div id="modal-inner">'+
                                '<h1>Modal Title</h1>'+
                                '<p>Any content could go in here.</p>'+
                                '<a class="close-reveal-modal">&#215;</a>'+
                            '</div>'+
                        '</div>';

    var htmlModalCart = '<div id="cartModal" class="reveal-modal">'+
                            '<div id="modal-inner">'+
                                '<h1>Modal Title</h1>'+
                                '<p>Any content could go in here.</p>'+
                                '<a class="close-reveal-modal">&#215;</a>'+
                            '</div>'+
                        '</div>';
    $body = $('body');
    $body.append(htmlModalQView);
    $body.append(htmlModalCart);

    $(document).on('click', '.add-quick-view', function(){
        $('#quickViewModal').reveal({
            animation: 'fadeAndPop',                   //fade, fadeAndPop, none
            animationspeed: 300,                       //how fast animtions are
            closeonbackgroundclick: true,              //if you click background will modal close?
            dismissmodalclass: 'close-reveal-modal'    //the class of a button or element that will close an open modal
        });
    });

    nodeToButton();

    $(document).on('click', '.quick-view-btn', function(){
        loadProductInfo('#quickViewModal #modal-inner', $(this).data('product-id'));
    });

    // CUSTOM BY IVAN END

});

// CUSTOM BY IVAN BEGIN

function nodeToButton(){
    var buttonName = 'My Quick Show';
    $('.add-quick-view').each(function(index, value){
        var productId = $(this).data('id');
        if (!$(this).next().hasClass('quick-view-btn')){
            $(this).after('<a class="quick-view-btn" href="#" data-reveal-id="quickViewModal" data-product-id="' + productId + '">' + buttonName + '</a>');
        }
    });
}

function loadProductInfo(node, id){
    $.ajax({
        method: "GET",
        url: "index.php?route=product/product&product_id=" + id
    }) .done(function( productPageHtml ) {
        $(node).html($(productPageHtml).find('.product-info').html());
        $(document).ready(function() {
            $('.colorbox').colorbox({
                overlayClose: true,
                opacity: 0.5,
                rel: "colorbox"
            });
        });
        $(document).on('click', '#button-cart', function() {
            addToCart2($('.right input[type=\'text\'], .right input[type=\'hidden\'], .right input[type=\'radio\']:checked, .right input[type=\'checkbox\']:checked, .right select, .right textarea'));
        });

    });
}

function addToCart2(p_data){
    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: p_data,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, information, .error').remove();

            if (json['error']) {
                if (json['error']['option']) {
                    for (i in json['error']['option']) {
                        $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                    }
                }

                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
            }

            if (json['success']) {
                $('.close-reveal-modal').trigger('click');
                $('#cartModal #modal-inner').html(json['success']);
                $('#cartModal').reveal({
                    animation: 'fadeAndPop',                   //fade, fadeAndPop, none
                    animationspeed: 300,                       //how fast animtions are
                    closeonbackgroundclick: true,              //if you click background will modal close?
                    dismissmodalclass: 'close-reveal-modal'    //the class of a button or element that will close an open modal
                });
            }
        }
    });
}

// CUSTOM BY IVAN END

function getURLVar(key) {
	var value = [];
	
	var query = String(document.location).split('?');
	
	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');
			
			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}
		
		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
} 

function addToCart(product_id, quantity) {
	quantity = typeof(quantity) != 'undefined' ? quantity : 1;

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: 'product_id=' + product_id + '&quantity=' + quantity,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			}
			
			if (json['success']) {
                $('#cartModal #modal-inner').html(json['success']);
                $('#cartModal').reveal({
                    animation: 'fadeAndPop',                   //fade, fadeAndPop, none
                    animationspeed: 300,                       //how fast animtions are
                    closeonbackgroundclick: true,              //if you click background will modal close?
                    dismissmodalclass: 'close-reveal-modal'    //the class of a button or element that will close an open modal
                });
			}	
		}
	});
}
function addToWishList(product_id) {
	$.ajax({
		url: 'index.php?route=account/wishlist/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#wishlist-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow');
			}	
		}
	});
}

function addToCompare(product_id) { 
	$.ajax({
		url: 'index.php?route=product/compare/add',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information').remove();
						
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
				
				$('.success').fadeIn('slow');
				
				$('#compare-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
}