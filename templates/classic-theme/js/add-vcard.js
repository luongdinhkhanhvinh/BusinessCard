(function ($) {
    "use strict";

    // add card detail fields
    if(VCARD_DETAILS.length){
        for (var i in VCARD_DETAILS) {
            if (VCARD_DETAILS.hasOwnProperty(i)) {
                let type = VCARD_DETAILS[i].type,
                    value = VCARD_DETAILS[i].value,
                    label = VCARD_DETAILS[i].label;

                if(DETAILS_FIELD_LIMIT == i){
                    break;
                }
                add_field(type, value, label);
            }
        }
    }

    initColorPicker('.card-color-wrapper');

    $('.vcard-info-items').on('click', function (e) {
        e.preventDefault();
        let type = $(this).data('type'),
            value = $(this).data('value');

        if(DETAILS_FIELD_LIMIT == $('#card-details-container .submit-field').length){
            Snackbar.show({
                text: LANG_LIMIT_EXCEED_UPGRADE,
                pos: 'bottom-center',
                showAction: false,
                actionText: "Dismiss",
                duration: 3000,
                textColor: '#fff',
                backgroundColor: '#383838'
            });
            return;
        }
        add_field(type, value, '');
    });

    $(document).on('click','.vcard-info-items-delete',function (e) {
        e.preventDefault();
        $(this).closest('.submit-field').remove();
    });

    $(window).on('load resize',function (e) {
        // manage heights
        let header_height = $('#header-container').outerHeight(),
            container_height = $(window).outerHeight() - header_height - 30;

        $('#card-details-box').css('max-height',container_height);
    });

    function add_field(type, value, label){
        let $field_shadow = $('.vcard-info-items[data-type="'+type+'"]'),
            placeholder = $field_shadow.data('placeholder'),
            field_type = $field_shadow.data('field-type'),
            index = $('#card-details-container .submit-field').length,
            field;

        switch (field_type) {
            case 'text':
                field = '<input class="with-border" name="card-details['+index+'][value]" placeholder="'+placeholder+'" type="text" value="'+value+'" required>';
                break;
            case 'email':
                field = '<input class="with-border" name="card-details['+index+'][value]" placeholder="'+placeholder+'" type="email" value="'+value+'" required>';
                break;
            case 'tel':
                field = '<input class="with-border" name="card-details['+index+'][value]" placeholder="'+placeholder+'" type="tel" value="'+value+'" required>';
                break;
            case 'url':
                field = '<input class="with-border" name="card-details['+index+'][value]" placeholder="'+placeholder+'" type="url" value="'+value+'" required>';
                break;
            case 'textarea':
                field = '<textarea class="with-border" name="card-details['+index+'][value]" placeholder="'+placeholder+'" required>'+value+'</textarea>';
                break;
        }

        let title = $field_shadow.find('span').html();

        let $tpl = $('<div class="submit-field">' +
            '<h5>'+title+' <button class="vcard-info-items-delete pull-right padding-top-5"><i class="icon-feather-x"></i></button></h5>' +
            field +
            (field_type != 'textarea'
                ? '<input class="with-border" name="card-details['+index+'][label]" value="'+label+'" placeholder="'+LANG_LABEL+'" type="text">'
                : '') +
            '<input name="card-details['+index+'][type]" value="'+type+'" type="hidden">' +
            '</div>');
        $('#card-details-container').append($tpl);
        $tpl.find('.with-border').first().focus();
    }
})(jQuery);