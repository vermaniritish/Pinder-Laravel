/** Ckeditor Image upload **/
function init_editor(selector, settings) {
    CKEDITOR.config.allowedContent = true;
    options = [];
    if(!$(selector).attr('id'))
    {
        id = 'ck_' + ((Math.random() * 5) + 1);
        $(selector).attr('id',  id);
        CKEDITOR.replace( id, options);
    }
    else
    {
        id = $(selector).attr('id');
        CKEDITOR.replace( id, options);
    }

    if($('#ck_image_upload').length < 1) {
        $('body').append('<form id="ck_image_upload" method="post" action="'+admin_url+'/actions/uploadFile" enctype="multipart/form-data" class="d-none"><input type="hidden" name="_token" value="'+csrf_token()+'"><input type="file" class="form-control hidden" name="file"><input type="hiden" name="path" value="editor"><input type="hiden" name="file_type" value="image"></form>');
    }

    setTimeout(function(){
    	$('.cke_toolbox .cke_button__image').replaceWith('<a data-selector="'+id+'" class="cke_button cke_button__image cke_button_off" href="javascript:;" title="Picture Upload"><i style="font-size:18px;" class="fas fa-image"></i></a>');
    }, 500);
}

$('body').on('click', '.cke_button__image', function(){
	selector = $(this).attr('data-selector');
	$('#ck_image_upload input').attr('data-selector', selector)
	$('#ck_image_upload input').click();
});  
$('body').on('change', '#ck_image_upload input', function(){
    var selector = $(this).attr('data-selector');
    icon = $('.cke_button__image[data-selector='+selector+']');
    if($(this).val())
    {
        icon.html('<i style="font-size:18px;" class="fas fa-spin fa-spinner"></i>');
        $('#ck_image_upload').ajaxSubmit({
            type: "post",
            success: function(resp) {
                if(resp)
                {
                    icon.html('<i style="font-size:18px;" class="fas fa-image"></i>');
                    $('#ck_image_upload input[type=file]').val("");
                    
                    if(resp.status == 'success') {
                        put_editor_html(selector, '<img src="'+resp.url+'" style="max-width: 100%; max-height: 400px;">');
                    }
                    else {
                        alert_float(resp.message);
                    }
                }
            }
        });
    }
    else
    {
        parent.find('.attachment-div a').html('<i class="material-icons">attach_file</i>');
    }
});

function put_editor_html(selector, value)
{
    CKEDITOR.instances[selector].insertHtml(value.trim());
}
/** Ckeditor Image upload **/
