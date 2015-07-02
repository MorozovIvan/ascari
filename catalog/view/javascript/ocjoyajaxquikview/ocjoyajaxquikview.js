// Ocjoy Ajaxquikview
function AjaxQuikview(current) {  
    if(typeof(current)=="string") {
        current = $('#' + current);
    } 
    var sel = $(current).data('qvisel');
    var ajid = parseInt($(current).attr('id').replace(/\D+/g,"")); 
    var nextajip = parseInt(ajid+1);
    var nextid = $('#' + sel + nextajip).data('qvi');
    var id = $(current).data('qvi');
    var backajip = parseInt(ajid-1);
    var backid = $('#' + sel + backajip).data('qvi');

    if(typeof(nextid) !== "undefined") {
        lnkhtml = '<a id="ajaxnext" onclick="AjaxQuikview(\''+sel+nextajip+'\')"><img src="image/ocjoyajaxquikview/ocjoy_next_button.png"/></a>';
    }

    if(typeof(backid) !== "undefined") {
        lnkhtml = '<a id="ajaxback" onclick="AjaxQuikview(\''+sel+backajip+'\')"><img src="image/ocjoyajaxquikview/ocjoy_prev_button.png"/></a>';
    }

    if((typeof(backid) !== "undefined") && (typeof(nextid) !== "undefined")) {
        lnkhtml = '<a id="ajaxback" onclick="AjaxQuikview(\''+sel+backajip+'\')"><img src="image/ocjoyajaxquikview/ocjoy_prev_button.png"/></a>';
        lnkhtml += '<a id="ajaxnext" onclick="AjaxQuikview(\''+sel+nextajip+'\')"><img src="image/ocjoyajaxquikview/ocjoy_next_button.png"/></a>';
    }
    if(typeof(lnkhtml) == "undefined") {
        lnkhtml = null;
    }
    $.ajax({
        type: 'post',
        data: 'product_id=' + id,
        url: 'index.php?route=product/ocjoyajaxquikview',
        dataType: 'html',
        success: function(data) {
            if ($('#quikview_modal_fon').length > 0) {
                $('#quikview_modal_fon').html(data);
            } else {
                $('<div>').attr({'id':'quikview_modal_fon'}).html(data).prependTo('body');
            }

            $('#ajaxlnks').html(lnkhtml);
            
            $('a.zoom').zoom({
              on:'mouseover',
              duration:  620,
            });

            $("#ajaxquikview").draggable({ 
                cursor: "crosshair"
            });
        }
    });
}
function addToWishList2(product_id) {
    $.ajax({
        url: 'index.php?route=account/wishlist/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            if (json['success']) {
                $('#ajaxquikviewnotification').html('<div class="success">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                $('.success, .warning, .attention, .information, .error').delay(2000).fadeOut(1000);
                $('#wishlist-total').html(json['total']);
            }   
        }
    });
}
function addToCompare2(product_id) { 
    $.ajax({
        url: 'index.php?route=product/compare/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) { 
            if (json['success']) {
                $('#ajaxquikviewnotification').html('<div class="success">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                $('.success, .warning, .attention, .information, .error').delay(2000).fadeOut(1000);
                $('#compare-total').html(json['total']);
            }   
        }
    });
}