<!DOCTYPE html>
<html lang="{LANG_CODE}" dir="{LANGUAGE_DIRECTION}">
<head>
    <title>IF("{PAGE_TITLE}"!=""){ {PAGE_TITLE} - {:IF}{SITE_TITLE}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-touch-fullscreen" content="yes">
    <meta name="HandheldFriendly" content="True">

    <meta name="author" content="{SITE_TITLE}">
    <meta name="keywords" content="{PAGE_META_KEYWORDS}">
    <meta name="description" content="{PAGE_META_DESCRIPTION}">

    <link rel="dns-prefetch" href="//fonts.googleapis.com">
    <link rel="dns-prefetch" href="//google.com">
    <link rel="dns-prefetch" href="//apis.google.com">
    <link rel="dns-prefetch" href="//ajax.googleapis.com">
    <link rel="dns-prefetch" href="//www.google-analytics.com">
    <link rel="dns-prefetch" href="//pagead2.googlesyndication.com">
    <link rel="dns-prefetch" href="//gstatic.com">
    <link rel="dns-prefetch" href="//oss.maxcdn.com">

    <link rel="shortcut icon" href="{SITE_URL}storage/logo/{SITE_FAVICON}">
    <script async>
        var themecolor = '{THEME_COLOR}';
        var siteurl = '{SITE_URL}';
        var template_name = '{TPL_NAME}';
        var ajaxurl = "{SITE_URL}php/{QUICKAD_USER_SECRET_FILE}.php";
    </script>
    <style>
        :root{{LOOP: COLORS}--theme-color-{COLORS.id}: {COLORS.value};{/LOOP: COLORS}}
    </style>

    <link rel="stylesheet" href="{SITE_URL}includes/assets/css/icons.css">
    <link rel="stylesheet" href="{SITE_URL}includes/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="{SITE_URL}vcard-templates/business-theme/css/style.css?ver={VERSION}">

    <script src="{SITE_URL}templates/{TPL_NAME}/js/jquery.min.js"></script>
</head>
<body>
<div class="page-wrapper">
    <div class="page-details" style="background-image:url({SITE_URL}storage/cards/cover/{COVER_IMAGE})">
        <div class="hero-section text-center">
            <div class="p-10"></div>

            <!-- User Profile Pic -->
            <div class="user-image">
                <img src="{SITE_URL}storage/cards/logo/{MAIN_IMAGE}" class="logo-img" alt="{TITLE}">
            </div>

            <!-- User First Name and Last Name -->
            <h1 class="company-name">{TITLE}</h1>
            <span class="user-status">{SUB_TITLE}</span>
            <div class="line-separator-50"></div>
            <div class="name">{DESCRIPTION}</div>

            <!-- Cover Photo, Photo, Name and Profession section completed -->
        </div>
        IF({SHOW_DETAILS}){
        <div class="hero-sub-section">

            <table class="contact-action-table">
                <tbody class="vCard-list">
                </tbody>
            </table>
        </div>
        {:IF}
    </div>
    IF(!{HIDE_BRANDING}){
    <div class="p-2 text-center vcard-branding">
        <a href="{SITE_URL}" class="text-white" target="_blank">{LANG_PROVIDED_BY}</a>
    </div>
    {:IF}
    <div class="add-to-contact-wrapper">
        <button class="btn btn-primary add-to-contact-btn"><i class="fa fa-address-card"></i>&nbsp; {LANG_ADD_TO_CONTACT}</button>
    </div>
</div>
</body>
<script>
    var VCARD_DETAILS = {DETAILS},
        TITLE = "{TITLE}",
        SUB_TITLE = "{SUB_TITLE}",
        LOGO = "{SITE_URL}storage/cards/logo/{MAIN_IMAGE}",
        DESCRIPTION = {DESCRIPTION_JS},
        DETAILS_FIELD_LIMIT = {DETAILS_FIELD_LIMIT};
</script>
<script src="{SITE_URL}vcard-templates/business-theme/js/script.js?ver={VERSION}"></script>
</html>