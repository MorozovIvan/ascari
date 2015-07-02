$(function () {
    $('[data-toggle="tooltip"]').tooltip({html:true});
});

function initMultiSelect(selector,text_all,text_title)
{
    $(selector).each(function(){
        var all = $(this).attr('multiselect-text-all') ? $(this).attr('multiselect-text-all') : text_all;
        var title = $(this).attr('multiselect-text-button') ? $(this).attr('multiselect-text-button') : text_title;
        $(this).multiselect({
            maxHeight: 200,
            buttonWidth: '100%',
            includeSelectAllOption: !$(this).hasClass('no-select-all'),
            selectAllText: all,
            buttonText: function(options, select) {
                return title;
            },
        });
    });
}