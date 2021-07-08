jQuery(function ($) {

    // email resend
    $('.resend').on('click',function(e) { 						// Button which will activate our modal
        var the_id = $(this).attr('id');						//get the id
        // show the spinner
        $(this).html("<i class='fa fa-spinner fa-pulse'></i>");
        $.ajax({											//the main ajax request
            type: "POST",
            data: "action=email_verify&id="+$(this).attr("id"),
            url: ajaxurl,
            success: function(data)
            {
                $("span#resend_count"+the_id).html(data);
                //fadein the vote count
                $("span#resend_count"+the_id).fadeIn();
                //remove the spinner
                $("a.resend_buttons"+the_id).remove();

            }
        });
        return false;
    });

    // user login
    $("#login-form").on('submit',function (e) {
        e.preventDefault();
        $("#login-status").slideUp();
        $('#login-button').addClass('button-progress').prop('disabled', true);
        var form_data = {
            action: 'ajaxlogin',
            username: $("#username").val(),
            password: $("#password").val(),
            is_ajax: 1
        };
        $.ajax({
            type: "POST",
            url: ajaxurl,
            data: form_data,
            dataType: 'json',
            success: function (response) {
                $('#login-button').removeClass('button-progress').prop('disabled', false);
                if (response.success) {
                    $("#login-status").addClass('success').removeClass('error').html('<p>'+LANG_LOGGED_IN_SUCCESS+'</p>').slideDown();
                    window.location.href = response.message;
                }
                else {
                    $("#login-status").removeClass('success').addClass('error').html('<p>'+response.message+'</p>').slideDown();
                }
            }
        });
        return false;
    });

    // blog comment with ajax
    $('.blog-comment-form').on('submit', function (e) {
        e.preventDefault();
        var action = 'submitBlogComment';
        var data = $(this).serialize();
        var $parent_cmnt = $(this).find('#comment_parent').val();
        var $cmnt_field = $(this).find('#comment-field');
        var $btn = $(this).find('.button');
        $btn.addClass('button-progress').prop('disabled',true);
        $.ajax({
            type: "POST",
            url: ajaxurl+'?action='+action,
            data: data,
            dataType: 'json',
            success: function (response) {
                $btn.removeClass('button-progress').prop('disabled',false);
                if(response.success){
                    if($parent_cmnt == 0){
                        $('.latest-comments > ul').prepend(response.html);
                    }else{
                        $('#li-comment-'+$parent_cmnt).after(response.html);
                    }
                    $('html, body').animate({
                        scrollTop: $("#li-comment-"+response.id).offset().top
                    }, 2000);
                    $cmnt_field.val('');
                }else{
                    $('#respond > .widget-content').prepend('<div class="notification error"><p>'+response.error+'</p></div>');
                }
            }
        });
    });

    /* save vcard details */
    $('#vcard-details-form').on('submit',function (e) {
        e.preventDefault();
        e.stopPropagation();
        var action = 'saveVCard';
        var data = new FormData(this),
            $form = $(this);

        var $btn = $(this).find('.button'),
            $error = $(this).find('.form-error');
        $btn.addClass('button-progress').prop('disabled',true);

        $error.slideUp();
        $.ajax({
            type: "POST",
            url: ajaxurl+'?action='+action,
            data: data,
            dataType: 'json',
            cache:false,
            contentType: false,
            processData: false,
            success: function (response) {
                $btn.removeClass('button-progress').prop('disabled',false);
                if(response.success){
                    Snackbar.show({
                        text: response.message,
                        pos: 'bottom-center',
                        showAction: false,
                        actionText: "Dismiss",
                        duration: 3000,
                        textColor: '#fff',
                        backgroundColor: '#383838'
                    });
                }else{
                    $error.html(response.error).slideDown().focus();
                }
            }
        });
    });
});