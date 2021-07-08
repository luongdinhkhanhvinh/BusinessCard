<?php
/*
Copyright (c) 2015 Devendra Katariya (bylancer.com)
*/
require_once('includes.php');

// initilize all variable
$params = $columns = $totalRecords = $data = array();
$params = $_REQUEST;
if($params['draw'] == 1)
    $params['order'][0]['dir'] = "desc";
//define index of column
$columns = array(
    0 =>'c.id',
    1 =>'c.title',
    2 =>'u.username',
    3 =>'c.created_at'
);

$where = $sqlTot = $sqlRec = "";

// check search value exist
if( !empty($params['search']['value']) ) {
    $where .=" WHERE ";
    $where .=" ( r.name LIKE '".$params['search']['value']."%' ";
    $where .=" OR u.username LIKE '%".$params['search']['value']."%' ";
    $where .=" OR r.address LIKE '".$params['search']['value']."%' )";
}

// getting total number records without any search
$sql = "SELECT c.*, u.username as username, u.name as fullname
FROM `".$config['db']['pre']."vcards` as c
INNER JOIN `".$config['db']['pre']."user` as u ON u.id = c.user_id ";

$sqlTot .= $sql;
$sqlRec .= $sql;
//concatenate search sql if value exist
if(isset($where) && $where != '') {
    $sqlTot .= $where;
    $sqlRec .= $where;
}


$sqlRec .=  " ORDER BY ". $columns[$params['order'][0]['column']]."   ".$params['order'][0]['dir']."  LIMIT ".$params['start']." ,".$params['length']." ";

$queryTot = $pdo->query($sqlTot);
$totalRecords = $queryTot->rowCount();
$queryRecords = $pdo->query($sqlRec);

//iterate on results row and create new index array of data
foreach ($queryRecords as $row) {
    //$data[] = $row;
    $id = $row['id'];
    $title = htmlentities( (string) $row['title'], ENT_QUOTES, 'UTF-8' );
    $subtitle = htmlentities( (string) $row['sub_title'], ENT_QUOTES, 'UTF-8' );
    $username = htmlentities( (string) $row['username'], ENT_QUOTES, 'UTF-8' );
    $fullname = htmlentities( (string) $row['fullname'], ENT_QUOTES, 'UTF-8' );
    $address = htmlentities( (string) $row['address'], ENT_QUOTES, 'UTF-8' );
    $image = $row['main_image'];
    $created_at = timeAgo($row['created_at']);

    $membership = get_user_membership_detail($row['user_id']);
    $membership_name = $membership['name'];

    $row0 = '<td>
                <label class="css-input css-checkbox css-checkbox-default">
                    <input type="checkbox" class="service-checker" value="'.$id.'" id="row_'.$id.'" name="row_'.$id.'"><span></span>
                </label>
            </td>';
    $row1 = '<td class="text-center">
                <div class="pull-left m-r"><img class="img-avatar img-avatar-48" src="../storage/cards/logo/'.$image.'"></div>
                <p class="font-500 m-b-0 pad-top-3"><a href="'.$config['site_url'].$row['slug'].'" target="_blank">'.$title.'</a></p>
                <p class="text-muted m-b-0">'.$subtitle.'</p>
            </td>';
    $row2 = '<td class="hidden-xs">'.$fullname.'<p class="text-muted m-b-0">#'.$username.'</p></td>';
    $row3 = '<td class="hidden-xs">'.$membership_name.'</td>';
    $row4 = '<td class="hidden-xs">'.$created_at.'</td>';
    $row5 = '<td class="text-center">
                <div class="btn-group">
                    <a href="javascript:void(0)" class="btn btn-xs btn-default item-js-delete" data-ajax-action="deleteVCard"><i class="ion-close"></i> Delete</a>
                </div>
            </td>';
    $value = array(
        "DT_RowId" => $id,
        0 => $row0,
        1 => $row1,
        2 => $row2,
        3 => $row3,
        4 => $row4,
        5 => $row5,
    );
    $data[] = $value;
}

$json_data = array(
    "draw"            => intval( $params['draw'] ),
    "recordsTotal"    => intval( $totalRecords ),
    "recordsFiltered" => intval($totalRecords),
    "data"            => $data   // total data array
);

echo json_encode($json_data);  // send data as json format
?>
