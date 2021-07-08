<?php
if(checkloggedin())
{
    $vcards = ORM::for_table($config['db']['pre'].'vcards')
        ->where('user_id', $_SESSION['user']['id'])
        ->find_one();

    if(isset($vcards['user_id'])){
        $card_id = $vcards['id'];
        $slug = $vcards['slug'];
        $color = $vcards['color'];
        $title = $vcards['title'];
        $sub_title = $vcards['sub_title'];
        $description = $vcards['description'];
        $cover_image = $vcards['cover_image'];
        $main_image = $vcards['main_image'];
        $details = $vcards['details'] ?: '[]';
        $vcards_link = $config['site_url'] . $slug;

    }else{
        $card_id = '';
        $slug = '';
        $color = $config['theme_color'];
        $title = '';
        $sub_title = '';
        $description = '';
        $cover_image = 'default.png';
        $main_image = 'default.png';
        $details = '[]';
        $vcards_link = '#';
    }

    $vcard_templates = array();

    if ($handle = opendir('vcard-templates/'))
    {
        while (false !== ($folder = readdir($handle)))
        {
            if ($folder != "." && $folder != "..")
            {
                $filepath = "vcard-templates/" . $folder . "/theme-info.txt";
                if(file_exists($filepath)){
                    $themefile = fopen($filepath,"r");

                    $themeinfo = array();
                    while(! feof($themefile)) {
                        $lineRead = fgets($themefile);
                        if (strpos($lineRead, ':') !== false) {
                            $line = explode(':',$lineRead);
                            $key = trim($line[0]);
                            $value = trim($line[1]);
                            $themeinfo[$key] = $value;
                        }
                    }
                    $vcard_templates[$folder]['folder'] = $folder;
                    $vcard_templates[$folder]['name'] = $themeinfo['Theme Name'];
                    fclose($themefile);
                }
            }
        }
        closedir($handle);
    }

    // Get usergroup details
    $user_info = ORM::for_table($config['db']['pre'] . 'user')
        ->select('group_id')
        ->find_one($_SESSION['user']['id']);

    $group_id = isset($user_info['group_id']) ? $user_info['group_id'] : 'free';

    // Get membership details
    switch ($group_id) {
        case 'free':
            $plan = json_decode(get_option('free_membership_plan'), true);
            $settings = $plan['settings'];
            $field_limit = $settings['field_limit'];
            break;
        case 'trial':
            $plan = json_decode(get_option('trial_membership_plan'), true);
            $settings = $plan['settings'];
            $field_limit = $settings['field_limit'];
            break;
        default:
            $plan = ORM::for_table($config['db']['pre'] . 'plans')
                ->select('settings')
                ->where('id', $group_id)
                ->find_one();
            if (!isset($plan['settings'])) {
                $plan = json_decode(get_option('free_membership_plan'), true);
                $settings = $plan['settings'];
                $field_limit = $settings['field_limit'];
            } else {
                $settings = json_decode($plan['settings'], true);
                $field_limit = $settings['field_limit'];
            }
            break;
    }


    $page = new HtmlTemplate ('templates/' . $config['tpl_name'] . '/add-vcard.tpl');
    $page->SetParameter ('OVERALL_HEADER', create_header($lang['MANAGE_VCARD']));
    $page->SetParameter ('SITE_TITLE', $config['site_title']);
    $page->SetLoop('VCARD_TEMPLATES', $vcard_templates);
    $page->SetParameter('VCARD_LINK', $vcards_link);
    $page->SetParameter('COLOR', $color);
    $page->SetParameter('CARD_ID', $card_id);
    $page->SetParameter('VCARD_TEMPLATE', get_vcard_option($card_id, 'vcard_template','classic-theme'));
    $page->SetParameter('TITLE', $title);
    $page->SetParameter('SLUG', $slug);
    $page->SetParameter('SUB_TITLE', $sub_title);
    $page->SetParameter('DESCRIPTION', $description);
    $page->SetParameter('MAIN_IMAGE', $main_image);
    $page->SetParameter('COVER_IMAGE', $cover_image);
    $page->SetParameter('DETAILS', $details);
    $page->SetParameter('DETAILS_FIELD_LIMIT', $field_limit);
    $page->SetParameter ('OVERALL_FOOTER', create_footer());
    $page->CreatePageEcho();
}
else{
    headerRedirect($link['LOGIN']);
}
?>