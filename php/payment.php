<?php
require_once("includes/lib/curl/curl.php");
require_once("includes/lib/curl/CurlResponse.php");



if(isset($_GET['i']) && trim($_GET['i']) == '')
{
    error($lang['INVALID_PAYMENT_PROCESS'], __LINE__, __FILE__, 1);
    exit();
}

if(isset($_GET['i']) && isset($_GET['access_token']))
{
    $access_token = $_GET['access_token'];
    if(isset($_SESSION['quickad'][$access_token])){
        $payment_settings = ORM::for_table($config['db']['pre'].'payments')
            ->select('payment_folder')
            ->where('payment_folder', $_GET['i'])
            ->find_one();

        if(!isset($payment_settings['payment_folder']))
        {
            error($lang['NOT_FOUND_PAYMENT'], __LINE__, __FILE__, 1);
            exit();
        }
        require_once('includes/payments/'.$payment_settings['payment_folder'].'/pay.php');
    }
}

if(isset($_GET['status']) && $_GET['status'] == 'cancel') {

    $access_token = isset($_GET['access_token']) ? $_GET['access_token'] : 0;

    if($access_token){
        payment_fail_save_detail($access_token);

        $error_msg = "Payment has been cancelled.";

        payment_error("cancel",$error_msg,$access_token);
    }else{
        error($lang['INVALID_PAYMENT_PROCESS'], __LINE__, __FILE__, 1);
        exit();
    }
}
if(isset($_POST['payment_method_id']))
{
    $access_token = $_POST['token'];
    $payment_type = $_SESSION['quickad'][$access_token]['payment_type'];
    $_SESSION['quickad'][$access_token]['payment_mode'] = "one-time";
    $_SESSION['quickad'][$access_token]['plan_interval'] = "day";

    if (isset($payment_type)) {

        $folder = $_POST['payment_method_id'];

        $_SESSION['quickad'][$access_token]['folder'] = $folder;

        if($folder == "2checkout"){
            $_SESSION['quickad'][$access_token]['firstname'] = $_POST['checkoutCardFirstName'];
            $_SESSION['quickad'][$access_token]['lastname'] = $_POST['checkoutCardLastName'];
            $_SESSION['quickad'][$access_token]['BillingAddress'] = $_POST['checkoutBillingAddress'];
            $_SESSION['quickad'][$access_token]['BillingCity'] = $_POST['checkoutBillingCity'];
            $_SESSION['quickad'][$access_token]['BillingState'] = $_POST['checkoutBillingState'];
            $_SESSION['quickad'][$access_token]['BillingZipcode'] = $_POST['checkoutBillingZipcode'];
            $_SESSION['quickad'][$access_token]['BillingCountry'] = $_POST['checkoutBillingCountry'];
        }

        if (file_exists('includes/payments/' . $folder . '/pay.php')) {
            require_once('includes/payments/' . $folder . '/pay.php');
        } else {
            error($lang['PAYMENT_METHOD_DISABLED'], __LINE__, __FILE__, 1);
            exit();
        }
    }else{

        error($lang['INVALID_PAYMENT_PROCESS'], __LINE__, __FILE__, 1);
        exit();
    }
}
else if(isset($_GET['token'])) {
    $access_token = $_GET['token'];
    if (isset($_SESSION['quickad'][$access_token]['payment_type'])) {


    }
    else{
        error($lang['INVALID_PAYMENT_PROCESS'], __LINE__, __FILE__, 1);
        exit();
    }
}
else
{
    error($lang['PAGE_NOT_FOUND'], __LINE__, __FILE__, 1);
    exit();
}

?>
