<?php
if (isset($_GET['slug'])) {
    $vcard = ORM::for_table($config['db']['pre'] . 'vcards')
            ->where('slug', $_GET['slug'])
            ->find_one();

    if (isset($vcard['title'])) {

        // Get usergroup details
        $user_info = ORM::for_table($config['db']['pre'] . 'user')
            ->select('group_id')
            ->find_one($vcard['user_id']);

        $group_id = isset($user_info['group_id']) ? $user_info['group_id'] : 'free';

        // Get membership details
        switch ($group_id) {
            case 'free':
                $plan = json_decode(get_option('free_membership_plan'), true);
                $settings = $plan['settings'];
                $limit = $settings['scan_limit'];
                break;
            case 'trial':
                $plan = json_decode(get_option('trial_membership_plan'), true);
                $settings = $plan['settings'];
                $limit = $settings['scan_limit'];
                break;
            default:
                $plan = ORM::for_table($config['db']['pre'] . 'plans')
                    ->select('settings')
                    ->where('id', $group_id)
                    ->find_one();
                if (!isset($plan['settings'])) {
                    $plan = json_decode(get_option('free_membership_plan'), true);
                    $settings = $plan['settings'];
                    $limit = $settings['scan_limit'];
                } else {
                    $settings = json_decode($plan['settings'], true);
                    $limit = $settings['scan_limit'];
                }
                break;
        }

        // check for url
        if (!empty($_GET['qr-id'])) {
            $qr_id = quick_xor_decrypt(urldecode($_GET['qr-id']), 'quick-qr');
            if ($_GET['slug'] == $qr_id) {

                if ($limit != "999") {
                    $start = date('Y-m-01');
                    $end = date('Y-m-t');

                    $total = ORM::for_table($config['db']['pre'] . 'vcard_view')
                        ->where('vcard_id', $vcard['id'])
                        ->where_raw("`date` BETWEEN '$start' AND '$end'")
                        ->count();

                    if ($total >= $limit) {
                        message($lang['NOTIFY'], $lang['SCAN_LIMIT_EXCEED']);
                        exit();
                    }
                }

                $add_view = ORM::for_table($config['db']['pre'] . 'vcard_view')->create();
                $add_view->vcard_id = $vcard['id'];
                $add_view->ip = get_client_ip();
                $add_view->date = date('Y-m-d H:i:s');
                $add_view->save();

                headerRedirect($config['site_url'] . $vcard['slug']);
            }
        }

        $vcard_id = $vcard['id'];
        $title = escape_html($vcard['title']);
        $sub_title = escape_html($vcard['sub_title']);
        $description = stripUnwantedTagsAndAttrs(nl2br(stripcslashes($vcard['description'])));
        $main_image = $vcard['main_image'] ?: 'default.png';
        $cover_image = $vcard['cover_image'] ?: 'default.png';
        $color = $vcard['color'];

        $details = $vcard['details'] ?: '[]';

        $template = get_vcard_option($vcard_id, 'vcard_template','classic-theme');

        $page = new HtmlTemplate ('vcard-templates/'.$template.'/index.tpl');
        $page->SetParameter('PAGE_TITLE', $title);
        $page->SetParameter('SITE_TITLE', $config['site_title']);
        $page->SetParameter('PAGE_LINK', (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]");
        $page->SetParameter('PAGE_META_KEYWORDS', $config['meta_keywords']);
        $page->SetParameter('PAGE_META_DESCRIPTION', $config['meta_description']);
        $page->SetParameter('LANGUAGE_DIRECTION', get_current_lang_direction());
        $page->SetParameter('VCARD_ID', $vcard_id);
        $page->SetParameter('TITLE', $title);
        $page->SetParameter('SUB_TITLE', $sub_title);
        $page->SetParameter('DESCRIPTION', $description);
        $page->SetParameter('DESCRIPTION_JS', json_encode($vcard['description']));
        $page->SetParameter('MAIN_IMAGE', $main_image);
        $page->SetParameter('COVER_IMAGE', $cover_image);
        $page->SetParameter('DETAILS', $details);
        $page->SetParameter('DETAILS_FIELD_LIMIT', $settings['field_limit']);
        $page->SetParameter('SHOW_DETAILS', (int) !empty($vcard['details']));
        $page->SetParameter('HIDE_BRANDING', (int) $settings['hide_branding']);

        $colors = array();
        list($r, $g, $b) = sscanf($color, "#%02x%02x%02x");
        $i = 0.01;
        while ($i <= 1) {
            $colors["$i"]['id'] = str_replace('.', '_', $i);
            $colors["$i"]['value'] = "rgba($r,$g,$b,$i)";
            $i += 0.01;
        }
        $colors[1]['id'] = 1;
        $colors[1]['value'] = "rgba($r,$g,$b,1)";
        $page->SetLoop('COLORS', $colors);
        $page->CreatePageEcho();
    } else {
        error($lang['PAGE_NOT_FOUND'], __LINE__, __FILE__, 1);
        exit();
    }
} else {
    error($lang['PAGE_NOT_FOUND'], __LINE__, __FILE__, 1);
    exit();
}
?>