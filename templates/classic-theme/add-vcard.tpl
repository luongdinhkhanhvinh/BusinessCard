{OVERALL_HEADER}

<!-- Dashboard Container -->
<div class="dashboard-container">

    <!-- Dashboard Sidebar
    ================================================== -->
    <div class="dashboard-sidebar">
        <div class="dashboard-sidebar-inner" data-simplebar>
            <div class="dashboard-nav-container">

                <!-- Responsive Navigation Trigger -->
                <a href="#" class="dashboard-responsive-nav-trigger">
					<span class="hamburger hamburger--collapse" >
						<span class="hamburger-box">
							<span class="hamburger-inner"></span>
						</span>
					</span>
                    <span class="trigger-title">{LANG_DASH_NAVIGATION}</span>
                </a>

                <!-- Navigation -->
                <div class="dashboard-nav">
                    <div class="dashboard-nav-inner">

                        <ul data-submenu-title="{LANG_MANAGEMENT}">
                            <li><a href="{LINK_DASHBOARD}"><i class="icon-feather-grid"></i> {LANG_DASHBOARD}</a></li>
                            <li class="active"><a href="{LINK_ADD_VCARD}"><i class="icon-feather-layers"></i> {LANG_VCARD}</a></li>
                            <li><a href="{LINK_MEMBERSHIP}"><i class="icon-feather-gift"></i> {LANG_MEMBERSHIP}</a></li>
                            <li><a href="{LINK_QRBUILDER}"><i class="icon-material-outline-dashboard"></i> {LANG_QRBUILDER}</a></li>
                        </ul>

                        <ul data-submenu-title="{LANG_ACCOUNT}">
                            <li><a href="{LINK_TRANSACTION}"><i class="icon-material-outline-description"></i> {LANG_TRANSACTIONS}</a></li>
                            <li><a href="{LINK_ACCOUNT_SETTING}"><i class="icon-material-outline-settings"></i> {LANG_ACCOUNT_SETTING}</a></li>
                            <li><a href="{LINK_LOGOUT}"><i class="icon-material-outline-power-settings-new"></i> {LANG_LOGOUT}</a></li>
                        </ul>

                    </div>
                </div>
                <!-- Navigation / End -->

            </div>
        </div>
    </div>
    <!-- Dashboard Sidebar / End -->


    <!-- Dashboard Content
    ================================================== -->
    <div class="dashboard-content-container" data-simplebar>
        <div class="dashboard-content-inner" >

            <!-- Dashboard Headline -->
            <div class="dashboard-headline">
                <h3>{LANG_MANAGE_VCARD}</h3>
            </div>

            <!-- Row -->
                <div class="row">
                    <!-- Dashboard Box -->
                    <div class="col-md-6">
                        <form id="vcard-details-form" name="vcard_form" method="post" action="#" enctype="multipart/form-data">
                        <div class="dashboard-box margin-top-0 margin-bottom-30">
                            <!-- Headline -->
                            <div class="headline">
                                <h3><i class="icon-feather-layers"></i>{LANG_YOUR_CARD}</h3>
                                <a href="{VCARD_LINK}" title="{LANG_LIVE_PREVIEW}" data-tippy-placement="top" class="margin-left-auto live-preview-button"><i class="icon-feather-eye"></i></a>
                            </div>
                            <div class="content with-padding padding-bottom-0" id="card-details-box">
                                <div class="submit-field">
                                    <div class="account-type row template-chooser">
                                        {LOOP: VCARD_TEMPLATES}
                                            <div class="col-md-6 col-6 margin-right-0">
                                                <input type="radio" name="vcard_template" value="{VCARD_TEMPLATES.folder}" id="{VCARD_TEMPLATES.folder}" class="account-type-radio" IF("{VCARD_TEMPLATE}" == "{VCARD_TEMPLATES.folder}"){ checked {:IF}>
                                                <label for="{VCARD_TEMPLATES.folder}" class="ripple-effect-dark">
                                                    <img class="margin-bottom-5" src="{SITE_URL}/vcard-templates/{VCARD_TEMPLATES.folder}/screenshot.png">
                                                    <strong>{VCARD_TEMPLATES.name}</strong>
                                                </label>
                                            </div>
                                        {/LOOP: VCARD_TEMPLATES}
                                    </div>
                                </div>
                                    <div class="d-flex align-items-center submit-field">
                                        <div class="flex-grow-1">
                                            <h5 class="margin-bottom-0">{LANG_CARD_COLOR}</h5></div>
                                        <div>
                                            <div class="card-color-wrapper">
                                                <button class="bm-color-picker"></button>
                                                <input type="hidden" class="color-input" name="color" value="{COLOR}">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="submit-field">
                                        <div class="d-flex">
                                            <div class="flex-grow-1">
                                                <h5>{LANG_BANNER}</h5>
                                                <div class="uploadButton">
                                                    <input class="uploadButton-input" type="file" accept="image/*"
                                                           id="cover_image"
                                                           name="cover_image" onchange="readImageURL(this, 'vcard-banner');"/>
                                                    <label class="uploadButton-button ripple-effect"
                                                           for="cover_image">{LANG_UPLOAD_IMAGE}</label>
                                                </div>
                                            </div>
                                            <img alt="" id="vcard-banner" src="{SITE_URL}storage/cards/cover/{COVER_IMAGE}"
                                                 style="max-width: 50%; height: 90px">
                                        </div>
                                    </div>
                                    <div class="submit-field">
                                        <div class="d-flex">
                                            <div class="flex-grow-1">
                                                <h5>{LANG_LOGO}</h5>
                                                <div class="uploadButton">
                                                    <input class="uploadButton-input" type="file" accept="image/*"
                                                           id="main_image"
                                                           name="main_image" onchange="readImageURL(this, 'vcard-logo');"/>
                                                    <label class="uploadButton-button ripple-effect"
                                                           for="main_image">{LANG_UPLOAD_IMAGE}</label>
                                                </div>
                                            </div>
                                            <img alt="" id="vcard-logo" src="{SITE_URL}storage/cards/logo/{MAIN_IMAGE}"
                                                 style="max-width: 50%; height: 90px">
                                        </div>
                                    </div>
                                    <div class="submit-field">
                                        <h5>{LANG_SLUG}</h5>
                                        <input id="slug" class="with-border" name="slug" type="text" value="{SLUG}">
                                        <div id="slug-availability-status"></div>
                                        <small>{LANG_SLUG_HINT}</small>
                                    </div>
                                    <div class="submit-field">
                                        <h5>{LANG_TITLE}</h5>
                                        <input id="title" class="with-border" name="title" type="text" value="{TITLE}">
                                    </div>
                                    <div class="submit-field">
                                        <h5>{LANG_SUBTITLE}</h5>
                                        <input id="sub-title" class="with-border" name="sub_title" type="text" value="{SUB_TITLE}">
                                    </div>
                                    <div class="submit-field">
                                        <h5>{LANG_DESCRIPTION}</h5>
                                        <textarea id="description" class="with-border" name="description">{DESCRIPTION}</textarea>
                                    </div>
                                <div id="card-details-container"></div>
                            </div>
                            <div class="headline dashboard-box-footer">
                                <div>
                                    <small class="form-error"></small>
                                    <button type="submit" name="submit" class="button ripple-effect full-width">{LANG_SAVE}</button>
                                </div>
                            </div>
                        </div>
                        </form>
                    </div>
                    <div class="col-md-6">
                        <div class="dashboard-box margin-top-0">
                            <!-- Headline -->
                            <div class="headline">
                                <h3><i class="icon-feather-info"></i>{LANG_ADD_NEW_INFORMATION}</h3>
                            </div>
                            <div class="content with-padding">
                                <div class="vcard-info-items-group">
                                    <button class="vcard-info-items" data-type="phone" data-field-type="text" data-placeholder="{LANG_PHONE}" data-value="">
                                        <i class="fa fa-phone"></i><span>{LANG_PHONE}</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="email" data-field-type="email" data-placeholder="{LANG_EMAILL}" data-value="">
                                        <i class="fa fa-envelope"></i><span>{LANG_EMAILL}</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="address" data-field-type="text" data-placeholder="{LANG_ADDRESS}" data-value="">
                                        <i class="fa fa-map-marker"></i><span>{LANG_ADDRESS}</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="website" data-field-type="url" data-placeholder="{LANG_WEBSITE}" data-value="">
                                        <i class="fa fa-link"></i><span>{LANG_WEBSITE}</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="text" data-field-type="textarea" data-placeholder="" data-value="">
                                        <i class="fa fa-align-left"></i><span>{LANG_TEXT}</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="facebook" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-facebook"></i><span>Facebook</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="twitter" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-twitter"></i><span>Twitter</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="instagram" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-instagram"></i><span>Instagram</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="whatsapp" data-field-type="text" data-placeholder="+19876543210" data-value="">
                                        <i class="fa fa-whatsapp"></i><span>WhatsApp</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="telegram" data-field-type="text" data-placeholder="+19876543210" data-value="">
                                        <i class="fa fa-send"></i><span>Telegram</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="skype" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-skype"></i><span>Skype</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="wechat" data-field-type="text" data-placeholder="+19876543210" data-value="">
                                        <i class="fa fa-wechat"></i><span>WeChat</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="signal" data-field-type="text" data-placeholder="+19876543210" data-value="">
                                        <svg aria-hidden="true" focusable="false" viewBox="0 0 27 27" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="fill: currentcolor; height: 1em; overflow: visible; width: 1em;">
                                            <path d="M10.249 0.411007L10.5446 1.63349C9.36239 1.92857 8.22244 2.39227 7.16693 3.02459L6.51251 1.94965C7.67357 1.2541 8.94019 0.727166 10.249 0.411007ZM16.751 0.411007L16.4554 1.63349C17.6376 1.92857 18.7776 2.39227 19.8331 3.02459L20.4875 1.94965C19.3264 1.2541 18.0598 0.727166 16.751 0.411007ZM1.93159 6.52342C1.23495 7.68267 0.707193 8.94731 0.390539 10.2541L1.61493 10.5492C1.91048 9.36885 2.3749 8.23068 3.00821 7.17681L1.93159 6.52342ZM1.25606 13.5C1.25606 12.8888 1.29828 12.2775 1.40383 11.6663L0.158327 11.4766C-0.0527756 12.8255 -0.0527756 14.1745 0.158327 15.5234L1.40383 15.3337C1.29828 14.7225 1.25606 14.1112 1.25606 13.5ZM20.4875 25.0504L19.8331 23.9754C18.7776 24.6077 17.6376 25.0925 16.4343 25.3876L16.7299 26.6101C18.0598 26.2728 19.3264 25.7459 20.4875 25.0504ZM25.7439 13.5C25.7439 14.1112 25.7017 14.7225 25.5962 15.3337L26.8417 15.5234C27.0528 14.1745 27.0528 12.8255 26.8417 11.4766L25.5962 11.6663C25.7017 12.2775 25.7439 12.8888 25.7439 13.5ZM26.6095 16.7459L25.3851 16.4508C25.0895 17.6522 24.6251 18.7904 23.9918 19.8443L25.0684 20.4977C25.7651 19.3173 26.2928 18.0527 26.6095 16.7459ZM15.3366 25.5984C14.1122 25.7881 12.8878 25.7881 11.6634 25.5984L11.4734 26.8419C12.8245 27.0527 14.1755 27.0527 15.5266 26.8419L15.3366 25.5984ZM23.3585 20.7506C22.6196 21.7412 21.7541 22.6054 20.7619 23.3431L21.5219 24.3548C22.6196 23.5539 23.5696 22.5843 24.3929 21.5094L23.3585 20.7506ZM20.7619 3.65691C21.7541 4.39461 22.6196 5.25878 23.3585 6.24941L24.3718 5.49063C23.5696 4.39461 22.5985 3.44614 21.5219 2.6452L20.7619 3.65691ZM3.64152 6.24941C4.38038 5.25878 5.2459 4.39461 6.23808 3.65691L5.47811 2.6452C4.38038 3.44614 3.43041 4.41569 2.62823 5.49063L3.64152 6.24941ZM25.0684 6.52342L23.9918 7.17681C24.6251 8.23068 25.1106 9.36885 25.4062 10.5703L26.6306 10.2752C26.2928 8.94731 25.7651 7.68267 25.0684 6.52342ZM11.6634 1.40164C12.8878 1.21194 14.1122 1.21194 15.3366 1.40164L15.5266 0.15808C14.1755 -0.0526932 12.8245 -0.0526932 11.4734 0.15808L11.6634 1.40164ZM4.29593 24.692L1.67826 25.3033L2.29046 22.6897L1.04496 22.3946L0.43276 25.0082C0.263878 25.6827 0.686083 26.3782 1.38272 26.5258C1.57271 26.5679 1.76271 26.5679 1.9527 26.5258L4.57037 25.9356L4.29593 24.692ZM1.31939 21.2775L2.54378 21.5726L2.96599 19.76C2.35379 18.7272 1.88937 17.6101 1.59382 16.4508L0.369429 16.7459C0.643862 17.863 1.06607 18.9379 1.61493 19.9496L1.31939 21.2775ZM7.23026 24.0176L5.41478 24.4391L5.71032 25.6616L7.04027 25.3454C8.05356 25.8934 9.13018 26.315 10.249 26.589L10.5446 25.3665C9.3835 25.0925 8.26466 24.6288 7.23026 24.0176ZM13.5 2.53981C7.44136 2.53981 2.52267 7.45082 2.52267 13.5C2.52267 15.5656 3.11376 17.589 4.21149 19.3173L3.15598 23.8279L7.65246 22.774C12.7823 25.9988 19.5586 24.4602 22.7885 19.3384C26.0184 14.2166 24.4773 7.45082 19.3475 4.226C17.5954 3.12998 15.5688 2.53981 13.5 2.53981Z"></path></svg><span>Signal</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="snapchat" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-snapchat-ghost"></i><span>Snapchat</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="linkedin" data-field-type="url" data-placeholder="{LANG_PROFILE_URL}" data-value="">
                                        <i class="fa fa-linkedin"></i><span>LinkedIn</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="pinterest" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-pinterest"></i><span>Pinterest</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="soundcloud" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-soundcloud"></i><span>Soundcloud</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="vimeo" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-vimeo"></i><span>Vimeo</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="dribbble" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-dribbble"></i><span>Dribbble</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="behance" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-behance"></i><span>Behance</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="flickr" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-flickr"></i><span>Flickr</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="youtube" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-youtube-play"></i><span>YouTube</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="tiktok" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <svg aria-hidden="true" focusable="false" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="fill: currentcolor; height: 1em; overflow: visible; width: 1em;">
                                            <path fill-rule="evenodd" clip-rule="evenodd" d="M15.2585 3C15.5561 5.55428 16.9848 7.07713 19.4688 7.23914V10.112C18.0292 10.2524 16.7683 9.78262 15.3018 8.89699V14.2702C15.3018 21.096 7.84449 23.2291 4.84643 18.3365C2.91988 15.1882 4.09962 9.66382 10.2797 9.44241V12.4719C9.80893 12.5475 9.30564 12.6663 8.84565 12.8229C7.47109 13.2873 6.69181 14.1568 6.90827 15.6904C7.32497 18.6281 12.7258 19.4975 12.2766 13.7571V3.0054H15.2585V3Z"></path></svg><span>TikTok</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="discord" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <svg aria-hidden="true" focusable="false" viewBox="0 0 30 21" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="fill: currentcolor; height: 1em; overflow: visible; width: 1em;">
                                            <path d="M25.9091 1.625C25.9091 1.625 22.7727 -0.7375 19.0909 -1L18.75 -0.34375C22.0909 0.44375 23.5909 1.55938 25.2273 2.9375C22.5 1.55938 19.7727 0.3125 15 0.3125C10.2273 0.3125 7.5 1.55938 4.77273 2.9375C6.34091 1.55938 8.18182 0.3125 11.25 -0.34375L10.9091 -1C7.02273 -0.671875 4.09091 1.625 4.09091 1.625C4.09091 1.625 0.613636 6.48125 0 16.0625C3.54545 20 8.86364 20 8.86364 20L9.95455 18.5562C8.04545 17.9 5.93182 16.7844 4.09091 14.75C6.27273 16.3906 9.61364 18.0312 15 18.0312C20.3864 18.0312 23.7273 16.3906 25.9091 14.75C24.0682 16.7844 21.8864 17.9 20.0455 18.5562L21.1364 20C21.1364 20 26.4545 20 30 16.0625C29.3864 6.48125 25.9091 1.625 25.9091 1.625ZM10.5682 13.4375C9.27273 13.4375 8.18182 12.2563 8.18182 10.8125C8.18182 9.36875 9.27273 8.1875 10.5682 8.1875C11.8636 8.1875 12.9545 9.36875 12.9545 10.8125C12.9545 12.2563 11.8636 13.4375 10.5682 13.4375ZM19.4318 13.4375C18.1364 13.4375 17.0455 12.2563 17.0455 10.8125C17.0455 9.36875 18.1364 8.1875 19.4318 8.1875C20.7273 8.1875 21.8182 9.36875 21.8182 10.8125C21.8182 12.2563 20.7273 13.4375 19.4318 13.4375Z"></path></svg><span>Discord</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="twitch" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-twitch"></i><span>Twitch</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="github" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-github"></i><span>Github</span>
                                    </button>
                                    <button class="vcard-info-items" data-type="paypal" data-field-type="text" data-placeholder="{LANG_USERNAME}" data-value="">
                                        <i class="fa fa-paypal"></i><span>PayPal</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!-- Row / End -->

            <!-- Footer -->
            <div class="dashboard-footer-spacer"></div>
            <div class="small-footer margin-top-15">
                <div class="small-footer-copyrights">
                    {COPYRIGHT_TEXT}
                </div>
                <ul class="footer-social-links">
                    IF('{FACEBOOK_LINK}'!=""){
                    <li>
                        <a href="{FACEBOOK_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-facebook"></i>
                        </a>
                    </li>
                    {:IF}
                    IF('{TWITTER_LINK}'!=""){
                    <li>
                        <a href="{TWITTER_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-twitter"></i>
                        </a>
                    </li>
                    {:IF}
                    IF('{INSTAGRAM_LINK}'!=""){
                    <li>
                        <a href="{INSTAGRAM_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-instagram"></i>
                        </a>
                    </li>
                    {:IF}
                    IF('{LINKEDIN_LINK}'!=""){
                    <li>
                        <a href="{LINKEDIN_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-linkedin"></i>
                        </a>
                    </li>
                    {:IF}
                    IF('{PINTEREST_LINK}'!=""){
                    <li>
                        <a href="{PINTEREST_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-pinterest-p"></i>
                        </a>
                    </li>
                    {:IF}
                    IF('{YOUTUBE_LINK}'!=""){
                    <li>
                        <a href="{YOUTUBE_LINK}" target="_blank" rel="nofollow">
                            <i class="fa fa-youtube-play"></i>
                        </a>
                    </li>
                    {:IF}
                </ul>
                <div class="clearfix"></div>
            </div>
            <!-- Footer / End -->

        </div>
    </div>
    <!-- Dashboard Content / End -->

</div>
<!-- Dashboard Container / End -->

</div>
<!-- Wrapper / End -->
<script>
    $(document).ready(function () {
        $("#header-container").addClass('dashboard-header not-sticky');
    });
</script>
<!-- Footer Code -->

<script>
    var session_uname = "{USERNAME}";
    var session_uid = "{USER_ID}";
    // Language Var
    var LANG_ERROR_TRY_AGAIN = "{LANG_ERROR_TRY_AGAIN}";
    var LANG_LOGGED_IN_SUCCESS = "{LANG_LOGGED_IN_SUCCESS}";
    var LANG_ERROR = "{LANG_ERROR}";
    var LANG_CANCEL = "{LANG_CANCEL}";
    var LANG_DELETED = "{LANG_DELETED}";
    var LANG_ARE_YOU_SURE = "{LANG_ARE_YOU_SURE}";
    var LANG_YES_DELETE = "{LANG_YES_DELETE}";
    var LANG_SHOW = "{LANG_SHOW}";
    var LANG_HIDE = "{LANG_HIDE}";
    var LANG_HIDDEN = "{LANG_HIDDEN}";
    var LANG_TYPE_A_MESSAGE = "{LANG_TYPE_A_MESSAGE}";
    var LANG_JUST_NOW = "{LANG_JUST_NOW}";
    var LANG_PREVIEW = "{LANG_PREVIEW}";
    var LANG_SEND = "{LANG_SEND}";
    var LANG_STATUS = "{LANG_STATUS}";
    var LANG_SIZE = "{LANG_SIZE}";
    var LANG_NO_MSG_FOUND = "{LANG_NO_MSG_FOUND}";
    var LANG_ONLINE = "{LANG_ONLINE}";
    var LANG_OFFLINE = "{LANG_OFFLINE}";
    var LANG_GOT_MESSAGE = "{LANG_GOT_MESSAGE}";

    var LANG_LABEL = "{LANG_LABEL}",
        LANG_LIMIT_EXCEED_UPGRADE = "{LANG_LIMIT_EXCEED_UPGRADE}";

    var VCARD_DETAILS = {DETAILS},
        DETAILS_FIELD_LIMIT = {DETAILS_FIELD_LIMIT};
</script>

<script type="text/javascript" src="{SITE_URL}templates/{TPL_NAME}/js/chosen.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/jquery.lazyload.min.js"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/tippy.all.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/simplebar.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/bootstrap-slider.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/bootstrap-select.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/snackbar.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/counterup.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/magnific-popup.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/slick.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/jquery.cookie.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/user-ajax.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/custom.js?ver={VERSION}"></script>

<script src="{SITE_URL}templates/{TPL_NAME}/js/color-picker.es5.min.js?ver={VERSION}"></script>
<script src="{SITE_URL}templates/{TPL_NAME}/js/add-vcard.js?ver={VERSION}"></script>

<script>
    /* THIS PORTION OF CODE IS ONLY EXECUTED WHEN THE USER THE LANGUAGE(CLIENT-SIDE) */
    $(function () {
        $('.language-switcher').on('click', '.dropdown-menu li', function (e) {
            e.preventDefault();
            var lang = $(this).data('lang');
            if (lang != null) {
                var res = lang.substr(0, 2);
                $('#selected_lang').html(res);
                $.cookie('Quick_lang', lang,{ path: '/' });
                location.reload();
            }
        });
    });
    $(document).ready(function () {
        var lang = $.cookie('Quick_lang');
        if (lang != null) {
            var res = lang.substr(0, 2);
            $('#selected_lang').html(res);
        }
    });

    function checkAvailabilityStoreSlug() {
        var $item = $("#store-slug").closest('.submit-field');
        var form_data = {
            action: 'checkStoreSlug',
            slug: $("#store-slug").val()
        };
        $.ajax({
            type: "POST",
            url: ajaxurl,
            data: form_data,
            dataType: 'html',
            success: function (response) {
                $("#slug-availability-status").html(response);
            }
        });
    }
</script>

</body>
</html>