<?php
if(checkloggedin())
{
    $start = date('Y-m-01');
    $end = date('Y-m-t');

    $days = $scans = [];
    $total_scans = 0;

    $period = new \DatePeriod( date_create($start), \DateInterval::createFromDateString( '1 day' ), date_create($end) );
    /** @var \DateTime $dt */
    foreach ( $period as $dt ) {
        $days[] = date('d M', $dt->getTimestamp() );
        $scans[date('d M', $dt->getTimestamp() )] = 0;
    }

    $vcard = ORM::for_table($config['db']['pre'].'vcards')
        ->where('user_id', $_SESSION['user']['id'])
        ->find_one();

    if(isset($vcard['user_id'])) {
        $sql = "SELECT DATE(`date`) AS created, COUNT(1) AS scans 
                FROM " . $config['db']['pre'] . "vcard_view 
                WHERE 
                    `vcard_id` = {$vcard['id']} 
                    AND `date` BETWEEN '$start' AND '$end'
                GROUP BY DATE(`date`)";

        $result = ORM::for_table($config['db']['pre'] . 'vcard_view')
            ->raw_query($sql)
            ->find_many();

        foreach ($result as $data) {
            $scans[date('d M', strtotime($data['created']))] = $data['scans'];
        }

        $total_scans = ORM::for_table($config['db']['pre'].'vcard_view')
            ->where('vcard_id', $vcard['id'])
            ->count();
    }

    $membership = get_user_membership_detail($_SESSION['user']['id']);
    $membership_name = $membership['name'];


    $page = new HtmlTemplate ('templates/' . $config['tpl_name'] . '/dashboard.tpl');
    $page->SetParameter ('OVERALL_HEADER', create_header($lang['DASHBOARD']));
    $page->SetParameter ('SCANS', json_encode(array_values($scans)));
    $page->SetParameter ('DAYS', json_encode(array_values($days)));
    $page->SetParameter ('MEMBERSHIP_NAME', $membership_name);
    $page->SetParameter ('TOTAL_SCANS', $total_scans);
    $page->SetParameter ('OVERALL_FOOTER', create_footer());
    $page->CreatePageEcho();
}
else{
    headerRedirect($link['LOGIN']);
}