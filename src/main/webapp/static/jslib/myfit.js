

function fixHeight(percent)
{
    return (document.body.clientHeight) * percent ;
}

function fixWidth(percent)
{
    return (document.body.clientWidth -5) * percent ;
}

function showMoreContent(obj) {
    console.info($(obj).data('context'));
    var mydiv = $('<div style="word-break:break-all"/>').dialog({
        width : 270,
        height : 200,
        content : $(obj).data('context'),
        modal : true,
        align : 'center',
        title : '完整内容',
        buttons : [ {
            text : '确定',
            handler : function() {
                mydiv.dialog('close');
            }
        } ],
        onClose : function() {
            $(this).dialog('destroy');
        }
    });
    mydiv.show();
   // alert(content);
}

