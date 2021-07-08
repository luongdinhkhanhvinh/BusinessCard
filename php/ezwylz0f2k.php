<?php
require_once('../includes/config.php');
require_once('../includes/sql_builder/idiorm.php');
require_once('../includes/db.php');
require_once('../includes/classes/class.template_engine.php');
require_once('../includes/classes/class.country.php');
require_once('../includes/functions/func.global.php');
require_once('../includes/functions/func.sqlquery.php');
require_once('../includes/functions/func.users.php');
require_once('../includes/lang/lang_' . $config['lang'] . '.php');
require_once('../includes/seo-url.php');

sec_session_start();
define("ROOTPATH", dirname(__DIR__));

if (isset($_GET['action'])) {

    if ($_GET['action'] == "submitBlogComment") {
        submitBlogComment();
    }
    if ($_GET['action'] == "saveVCard") {
        saveVCard();
    }
    die(0);
}

if (isset($_POST['action'])) {

    if ($_POST['action'] == "ajaxlogin") {
        ajaxlogin();
    }
    if ($_POST['action'] == "email_verify") {
        email_verify();
    }

    if ($_POST['action'] == "checkStoreSlug") {
        checkStoreSlug();
    }
    die(0);
}

function ajaxlogin()
{
    global $config, $lang, $link;
    $loggedin = userlogin($_POST['username'], $_POST['password']);
    $result['success'] = false;
    $result['message'] = $lang['ERROR_TRY_AGAIN'];
    if (!is_array($loggedin)) {
        $result['message'] = $lang['USERNOTFOUND'];
    } elseif ($loggedin['status'] == 2) {
        $result['message'] = $lang['ACCOUNTBAN'];
    } else {
        $user_browser = $_SERVER['HTTP_USER_AGENT']; // Get the user-agent string of the user.
        $user_id = preg_replace("/[^0-9]+/", "", $loggedin['id']); // XSS protection as we might print this value
        $_SESSION['user']['id'] = $user_id;
        $username = preg_replace("/[^a-zA-Z0-9_\-]+/", "", $loggedin['username']); // XSS protection as we might print this value
        $_SESSION['user']['username'] = $username;
        $_SESSION['user']['login_string'] = hash('sha512', $loggedin['password'] . $user_browser);
        $_SESSION['user']['user_type'] = $loggedin['user_type'];
        update_lastactive();

        $result['success'] = true;
        $result['message'] = $link['DASHBOARD'];
    }
    die(json_encode($result));
}

function email_verify()
{
    global $config, $lang;

    if (checkloggedin()) {
        /*SEND CONFIRMATION EMAIL*/
        email_template("signup_confirm", $_SESSION['user']['id']);

        $respond = $lang['SENT'];
        echo '<a class="button gray" href="javascript:void(0);">' . $respond . '</a>';
        die();

    } else {
        header("Location: " . $config['site_url'] . "login");
        exit;
    }
}

function submitBlogComment()
{
    global $config, $lang;
    $comment_error = $name = $email = $user_id = $comment = null;
    $result = array();
    $is_admin = '0';
    $is_login = false;
    if (checkloggedin()) {
        $is_login = true;
    }
    $avatar = $config['site_url'] . 'storage/profile/default_user.png';
    if (!($is_login || isset($_SESSION['admin']['id']))) {
        if (empty($_POST['user_name']) || empty($_POST['user_email'])) {
            $comment_error = $lang['ALL_FIELDS_REQ'];
        } else {
            $name = removeEmailAndPhoneFromString($_POST['user_name']);
            $email = $_POST['user_email'];

            $regex = '/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/';
            if (!preg_match($regex, $email)) {
                $comment_error = $lang['EMAILINV'];
            }
        }
    } else if ($is_login && isset($_SESSION['admin']['id'])) {
        $commenting_as = 'admin';
        if (!empty($_POST['commenting-as'])) {
            if (in_array($_POST['commenting-as'], array('admin', 'user'))) {
                $commenting_as = $_POST['commenting-as'];
            }
        }
        if ($commenting_as == 'admin') {
            $is_admin = '1';
            $info = ORM::for_table($config['db']['pre'] . 'admins')->find_one($_SESSION['admin']['id']);
            $user_id = $_SESSION['admin']['id'];
            $name = $info['name'];
            $email = $info['email'];
            if (!empty($info['image'])) {
                $avatar = $config['site_url'] . 'storage/profile/' . $info['image'];
            }
        } else {
            $user_id = $_SESSION['user']['id'];
            $user_data = get_user_data(null, $user_id);
            $name = $user_data['name'];
            $email = $user_data['email'];
            if (!empty($user_data['image'])) {
                $avatar = $config['site_url'] . 'storage/profile/' . $user_data['image'];
            }
        }
    } else if ($is_login) {
        $user_id = $_SESSION['user']['id'];
        $user_data = get_user_data(null, $user_id);
        $name = $user_data['name'];
        $email = $user_data['email'];
        if (!empty($user_data['image'])) {
            $avatar = $config['site_url'] . 'storage/profile/' . $user_data['image'];
        }
    } else if (isset($_SESSION['admin']['id'])) {
        $is_admin = '1';
        $info = ORM::for_table($config['db']['pre'] . 'admins')->find_one($_SESSION['admin']['id']);
        $user_id = $_SESSION['admin']['id'];
        $name = $info['name'];
        $email = $info['email'];
        if (!empty($info['image'])) {
            $avatar = $config['site_url'] . 'storage/profile/' . $info['image'];
        }
    } else {
        $comment_error = $lang['LOGIN_POST_COMMENT'];
    }

    if (empty($_POST['comment'])) {
        $comment_error = $lang['ALL_FIELDS_REQ'];
    } else {
        $comment = validate_input($_POST['comment']);
    }

    $duplicates = ORM::for_table($config['db']['pre'] . 'blog_comment')
        ->where('blog_id', $_POST['comment_post_ID'])
        ->where('name', $name)
        ->where('email', $email)
        ->where('comment', $comment)
        ->count();

    if ($duplicates > 0) {
        $comment_error = $lang['DUPLICATE_COMMENT'];
    }

    if (!$comment_error) {
        if ($is_admin) {
            $approve = '1';
        } else {
            if ($config['blog_comment_approval'] == 1) {
                $approve = '0';
            } else if ($config['blog_comment_approval'] == 2) {
                if ($is_login) {
                    $approve = '1';
                } else {
                    $approve = '0';
                }
            } else {
                $approve = '1';
            }
        }

        $blog_cmnt = ORM::for_table($config['db']['pre'] . 'blog_comment')->create();
        $blog_cmnt->blog_id = $_POST['comment_post_ID'];
        $blog_cmnt->user_id = $user_id;
        $blog_cmnt->is_admin = $is_admin;
        $blog_cmnt->name = $name;
        $blog_cmnt->email = $email;
        $blog_cmnt->comment = $comment;
        $blog_cmnt->created_at = date('Y-m-d H:i:s');
        $blog_cmnt->active = $approve;
        $blog_cmnt->parent = $_POST['comment_parent'];
        $blog_cmnt->save();

        $id = $blog_cmnt->id();
        $date = date('d, M Y');
        $approve_txt = '';
        if ($approve == '0') {
            $approve_txt = '<em><small>' . $lang['COMMENT_REVIEW'] . '</small></em>';
        }

        $html = '<li id="li-comment-' . $id . '"';
        if ($_POST['comment_parent'] != 0) {
            $html .= 'class="children-2"';
        }
        $html .= '>
                   <div class="comments-box" id="comment-' . $id . '">
                        <div class="comments-avatar">
                            <img src="' . $avatar . '" alt="' . $name . '">
                        </div>
                        <div class="comments-text">
                            <div class="avatar-name">
                                <h5>' . $name . '</h5>
                                <span>' . $date . '</span>
                            </div>
                            ' . $approve_txt . '
                            <p>' . nl2br(stripcslashes($comment)) . '</p>
                        </div>
                    </div>
                </li>';

        $result['success'] = true;
        $result['html'] = $html;
        $result['id'] = $id;
    } else {
        $result['success'] = false;
        $result['error'] = $comment_error;
    }
    die(json_encode($result));
}

/**
 *  Save vCard details
 */
function saveVCard(){
    global $config, $lang, $link;

    $errors = null;

    if (empty($_POST['title'])) {
        $errors = $lang['TITLE_REQ'];
    }
    if (empty($_POST['slug'])) {
        $errors = $lang['SLUG_REQ'];

    }else if(!preg_match('/^[a-z0-9]+(-?[a-z0-9]+)*$/i', $_POST['slug'])){
        $errors = $lang['SLUG_INVALID'];
    } else{
        $count = ORM::for_table($config['db']['pre'].'vcards')
            ->where('slug', $_POST['slug'])
            ->where_not_equal('user_id',$_SESSION['user']['id'])
            ->count();
        // check row exist
        if ($count) {
            $errors = $lang['SLUG_NOT_EXIST'];
        }else if(in_array($config['site_url'] .$_POST['slug'],$link)){
            $errors = $lang['SLUG_NOT_EXIST'];
        }
    }


    if(!$errors){
        $vcards = ORM::for_table($config['db']['pre'].'vcards')
            ->where('user_id', $_SESSION['user']['id'])
            ->find_one();

        $MainFileName = null;
        $CoverFileName = null;

        if(isset($vcards['main_image'])){
            $main_imageName = $vcards['main_image'];
        }else{
            $main_imageName = '';
        }

        if(isset($vcards['main_image'])){
            $cover_imageName = $vcards['cover_image'];
        }else{
            $cover_imageName = '';
        }
        // Valid formats
        $valid_formats = array("jpeg", "jpg", "png");

            /*Start Logo Image Uploading*/
            $file = $_FILES['main_image'];
            $filename = $file['name'];
            $ext = getExtension($filename);
            $ext = strtolower($ext);
            if (!empty($filename)) {
                //File extension check
                if (in_array($ext, $valid_formats)) {
                    $main_path = ROOTPATH . "/storage/cards/logo/";
                    $filename = uniqid(time()) . '.' . $ext;
                    if (move_uploaded_file($file['tmp_name'], $main_path . $filename)) {
                        $MainFileName = $filename;
                        resizeImage(300, $main_path . $filename, $main_path . $filename);
                        resizeImage(60, $main_path . 'small_' . $filename, $main_path . $filename);
                        if (file_exists($main_path . $main_imageName) && $main_imageName != 'default.png') {
                            unlink($main_path . $main_imageName);
                            unlink($main_path . 'small_' . $main_imageName);
                        }
                    } else {
                        $errors = $lang['ERROR_LOGO_IMAGE'];
                    }
                } else {
                    $errors = $lang['ONLY_JPG_ALLOW'];
                }
            }
            /*End Logo Image Uploading*/

        if(!$errors) {
            /*Start Cover Image Uploading*/
            $cover_file = $_FILES['cover_image'];
            // Valid formats
            $valid_formats = array("jpeg", "jpg", "png");

            $cover_filename = $cover_file['name'];
            $ext = getExtension($cover_filename);
            $ext = strtolower($ext);
            if (!empty($cover_filename)) {
                //File extension check
                if (in_array($ext, $valid_formats)) {
                    $cover_path = ROOTPATH . "/storage/cards/cover/";
                    $cover_filename = uniqid(time()) . '.' . $ext;
                    if (move_uploaded_file($cover_file['tmp_name'], $cover_path . $cover_filename)) {
                        $CoverFileName = $cover_filename;
                        //resizeImage(300, $cover_path . $cover_filename, $cover_path . $cover_filename);
                        resizeImage(60, $cover_path . 'small_' . $cover_filename, $cover_path . $cover_filename);
                        if (file_exists($cover_path . $cover_imageName) && $cover_imageName != 'default.png') {
                            unlink($cover_path . $cover_imageName);
                            unlink($cover_path . 'small_' . $cover_imageName);
                        }
                    } else {
                        $errors = $lang['ERROR_BANNER_IMAGE'];
                    }
                } else {
                    $errors = $lang['ONLY_JPG_ALLOW'];
                }
            }
            /*End Cover Image Uploading*/
        }

        if(!$errors) {
            $now = date("Y-m-d H:i:s");
            $details = null;
            if(!empty($_POST['card-details'])){
                $_POST['card-details'] = array_values($_POST['card-details']);
                $details = json_encode($_POST['card-details']);
            }

            if (isset($vcards['user_id'])) {
                $vcards_update = ORM::for_table($config['db']['pre'] . 'vcards')
                    ->where('user_id', $_SESSION['user']['id'])
                    ->find_one();
                $vcards_update->set('color', validate_input($_POST['color']));
                $vcards_update->set('slug', validate_input($_POST['slug']));
                $vcards_update->set('title', validate_input($_POST['title']));
                $vcards_update->set('sub_title', validate_input($_POST['sub_title']));
                $vcards_update->set('description', validate_input($_POST['description']));
                $vcards_update->set('details', $details);
                if ($MainFileName) {
                    $vcards_update->set('main_image', $MainFileName);
                }
                if ($CoverFileName) {
                    $vcards_update->set('cover_image', $CoverFileName);
                }

            } else {
                $vcards_update = ORM::for_table($config['db']['pre'] . 'vcards')->create();
                $vcards_update->user_id = validate_input($_SESSION['user']['id']);
                $vcards_update->color = validate_input($_POST['color']);
                $vcards_update->slug = validate_input($_POST['slug']);
                $vcards_update->title = validate_input($_POST['title']);
                $vcards_update->sub_title = validate_input($_POST['sub_title']);
                $vcards_update->description = validate_input($_POST['description']);
                $vcards_update->details = $details;
                $vcards_update->created_at = $now;
                if ($MainFileName) {
                    $vcards_update->main_image = $MainFileName;
                }
                if ($CoverFileName) {
                    $vcards_update->cover_image = $CoverFileName;
                }
            }
            if($vcards_update->save()){
                $id = $vcards_update->id();
                update_vcard_option($id, 'vcard_template', validate_input($_POST['vcard_template']));
            }
            $result['success'] = true;
            $result['message'] = $lang['SAVED_SUCCESS'];
        }
    }
    if($errors) {
        $result['success'] = false;
        $result['error'] = $errors;
    }

    die(json_encode($result));
}