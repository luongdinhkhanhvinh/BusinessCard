SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Table structure for table `<<prefix>>admins`
--

DROP TABLE IF EXISTS `<<prefix>>admins`;
CREATE TABLE `<<prefix>>admins` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_user.png',
  `permission` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>balance`
--

DROP TABLE IF EXISTS `<<prefix>>balance`;
CREATE TABLE `<<prefix>>balance` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `current_balance` double(9,2) DEFAULT NULL,
  `total_earning` double(9,2) DEFAULT NULL,
  `total_withdrawal` double(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>blog`
--

DROP TABLE IF EXISTS `<<prefix>>blog`;
CREATE TABLE `<<prefix>>blog` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `author` int(10) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` text CHARACTER SET utf32 COLLATE utf32_unicode_ci,
  `status` enum('publish','pending') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'publish',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>blog_categories`
--

DROP TABLE IF EXISTS `<<prefix>>blog_categories`;
CREATE TABLE `<<prefix>>blog_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(10) NOT NULL DEFAULT '0',
  `active` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>blog_cat_relation`
--

DROP TABLE IF EXISTS `<<prefix>>blog_cat_relation`;
CREATE TABLE `<<prefix>>blog_cat_relation` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `blog_id` int(10) DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>blog_comment`
--

DROP TABLE IF EXISTS `<<prefix>>blog_comment`;
CREATE TABLE `<<prefix>>blog_comment` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `blog_id` int(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `is_admin` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `name` tinytext COLLATE utf8mb4_unicode_ci,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `active` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `parent` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>countries`
--

DROP TABLE IF EXISTS `<<prefix>>countries`;
CREATE TABLE `<<prefix>>countries` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `code` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso3` char(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iso_numeric` int(10) UNSIGNED DEFAULT NULL,
  `fips` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `asciiname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capital` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `area` int(10) UNSIGNED DEFAULT NULL,
  `population` int(10) UNSIGNED DEFAULT NULL,
  `continent_code` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tld` char(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code_format` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code_regex` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `languages` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `neighbours` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `equivalent_fips_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>currencies`
--

DROP TABLE IF EXISTS `<<prefix>>currencies`;
CREATE TABLE `<<prefix>>currencies` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `code` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `html_entity` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'From Github : An array of currency symbols as HTML entities',
  `font_arial` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `font_code2000` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unicode_decimal` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unicode_hex` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `in_left` tinyint(1) DEFAULT '0',
  `decimal_places` int(10) UNSIGNED DEFAULT '2' COMMENT 'Currency Decimal Places - ISO 4217',
  `decimal_separator` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '.',
  `thousand_separator` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT ',',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>faq_entries`
--

DROP TABLE IF EXISTS `<<prefix>>faq_entries`;
CREATE TABLE `<<prefix>>faq_entries` (
  `faq_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `translation_lang` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `translation_of` int(10) UNSIGNED DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `faq_pid` smallint(4) NOT NULL DEFAULT '0',
  `faq_weight` mediumint(6) NOT NULL DEFAULT '0',
  `faq_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faq_content` mediumtext COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>languages`
--

DROP TABLE IF EXISTS `<<prefix>>languages`;
CREATE TABLE `<<prefix>>languages` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direction` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `default` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>logs`
--

DROP TABLE IF EXISTS `<<prefix>>logs`;
CREATE TABLE `<<prefix>>logs` (
  `log_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `log_date` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `log_summary` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `log_details` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>options`
--

DROP TABLE IF EXISTS `<<prefix>>options`;
CREATE TABLE `<<prefix>>options` (
  `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_value` longtext COLLATE utf8mb4_unicode_ci,
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>pages`
--

DROP TABLE IF EXISTS `<<prefix>>pages`;
CREATE TABLE `<<prefix>>pages` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `translation_lang` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `translation_of` int(10) UNSIGNED DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `type` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>payments`
--

DROP TABLE IF EXISTS `<<prefix>>payments`;
CREATE TABLE `<<prefix>>payments` (
  `payment_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `payment_install` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `payment_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_folder` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_desc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>plans`
--

DROP TABLE IF EXISTS `<<prefix>>plans`;
CREATE TABLE `<<prefix>>plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `badge` text COLLATE utf8mb4_unicode_ci,
  `monthly_price` float DEFAULT NULL,
  `annual_price` float DEFAULT NULL,
  `lifetime_price` float DEFAULT NULL,
  `recommended` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `settings` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `taxes_ids` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(4) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>plan_options`
--

DROP TABLE IF EXISTS `<<prefix>>plan_options`;
CREATE TABLE `<<prefix>>plan_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `translation_lang` longtext COLLATE utf8mb4_unicode_ci,
  `translation_name` longtext COLLATE utf8mb4_unicode_ci,
  `position` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>taxes`
--

DROP TABLE IF EXISTS `<<prefix>>taxes`;
CREATE TABLE `<<prefix>>taxes` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `internal_name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` decimal(10,2) DEFAULT NULL,
  `value_type` enum('percentage','fixed') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('inclusive','exclusive') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_type` enum('personal','business','both') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `countries` text COLLATE utf8mb4_unicode_ci,
  `datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>testimonials`
--

DROP TABLE IF EXISTS `<<prefix>>testimonials`;
CREATE TABLE `<<prefix>>testimonials` (
  `id` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>time_zones`
--

DROP TABLE IF EXISTS `<<prefix>>time_zones`;
CREATE TABLE `<<prefix>>time_zones` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `country_code` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `gmt` float DEFAULT NULL,
  `dst` float DEFAULT NULL,
  `raw` float DEFAULT NULL,
  UNIQUE KEY `time_zone_id` (`time_zone_id`),
  KEY `country_code` (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>transaction`
--

DROP TABLE IF EXISTS `<<prefix>>transaction`;
CREATE TABLE `<<prefix>>transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `product_name` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `amount` double(9,2) DEFAULT NULL,
  `base_amount` double(9,2) DEFAULT NULL,
  `featured` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `urgent` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `highlight` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `transaction_time` int(11) DEFAULT NULL,
  `status` enum('pending','success','failed','cancel') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_gatway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_ip` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_method` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `frequency` enum('MONTHLY','YEARLY','LIFETIME') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing` text COLLATE utf8mb4_unicode_ci,
  `taxes_ids` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>upgrades`
--

DROP TABLE IF EXISTS `<<prefix>>upgrades`;
CREATE TABLE `<<prefix>>upgrades` (
  `upgrade_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `sub_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pay_mode` enum('one_time','recurring') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'one_time',
  `upgrade_lasttime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `upgrade_expires` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `unique_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_profile_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `authorizenet_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_day` int(2) DEFAULT NULL,
  `length` int(4) DEFAULT NULL,
  `interval` int(4) DEFAULT NULL,
  `trial_days` int(4) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_trial_ends` date DEFAULT NULL,
  `date_canceled` datetime DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>user`
--

DROP TABLE IF EXISTS `<<prefix>>user`;
CREATE TABLE `<<prefix>>user` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'free',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_type` enum('user','employer') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` float(10,2) NOT NULL DEFAULT '0.00',
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forgot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `confirm` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('0','1','2') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `view` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tagline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `dob` date DEFAULT NULL,
  `salary_min` bigint(20) NOT NULL DEFAULT '0',
  `salary_max` bigint(20) NOT NULL DEFAULT '0',
  `category` int(11) DEFAULT NULL,
  `subcategory` int(11) DEFAULT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sex` enum('Male','Female','Other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_code` char(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_code` char(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` char(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default_user.png',
  `lastactive` datetime DEFAULT NULL,
  `facebook` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `googleplus` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_provider` enum('','facebook','google','twitter') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_uid` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `online` enum('0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `notify` enum('0','1') COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `notify_cat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_layout` enum('both','grid','list') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'both'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>user_options`
--

DROP TABLE IF EXISTS `<<prefix>>user_options`;
CREATE TABLE `<<prefix>>user_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) DEFAULT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>vcards`
--

DROP TABLE IF EXISTS `<<prefix>>vcards`;
CREATE TABLE `<<prefix>>vcards` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(11) DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `main_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default.png',
  `cover_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'default.png',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>vcard_options`
--

DROP TABLE IF EXISTS `<<prefix>>vcard_options`;
CREATE TABLE `<<prefix>>vcard_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vcard_id` int(11) DEFAULT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `option_value` longtext COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `<<prefix>>vcard_view`
--

DROP TABLE IF EXISTS `<<prefix>>vcard_view`;
CREATE TABLE `<<prefix>>vcard_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `vcard_id` int(11) DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;