<?php
//enable debugging
error_reporting(E_ALL);
ini_set('display_errors','on');

//detect domain
require_once(dirname(__FILE__).'/config.php');
$_SERVER['SERVER_NAME'] = parse_url(HTTP_SERVER,PHP_URL_HOST);

if ($argc > 2)
{
    $_GET['route'] = $argv[2];
    
    // Version
    define('VERSION', $argv[1]);
    
    // Startup
    require_once(DIR_SYSTEM . 'startup.php');
    
    // Addist Engine Startup
    //require_once(DIR_SYSTEM.'addist/startup.php');
    
    // Registry
    $registry = new Registry();
    
    // Config
    $config = new Config();
    $registry->set('config', $config);
    
    // Database
    $db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
    $registry->set('db', $db);
    
    // Settings
    $query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");
    
    foreach ($query->rows as $setting) {
    	if (!$setting['serialized']) {
    		$config->set($setting['key'], $setting['value']);
    	} else {
    		$config->set($setting['key'], unserialize($setting['value']));
    	}
    }
    
    // Loader
    $loader = new Loader($registry);
    $registry->set('load', $loader);
    
    // Log
    $log = new Log($config->get('config_error_filename'));
    $registry->set('log', $log);
    
    function error_handler($errno, $errstr, $errfile, $errline) {
    	global $log;
        $config = new Config();
    
    	// error suppressed with @
    	if (error_reporting() === 0) {
    		return false;
    	}
    
    	switch ($errno) {
    		case E_NOTICE:
    		case E_USER_NOTICE:
    			$error = 'Notice';
    			break;
    		case E_WARNING:
    		case E_USER_WARNING:
    			$error = 'Warning';
    			break;
    		case E_ERROR:
    		case E_USER_ERROR:
    			$error = 'Fatal Error';
    			break;
    		default:
    			$error = 'Unknown';
    			break;
    	}
        
    	if ($config->get('config_error_display')) {
    		echo '<b>' . $error . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
    	}
    
    	if ($config->get('config_error_log')) {
    		$log->write('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
    	}
        
        chmod(DIR_LOGS . $config->get('config_error_filename'),0777);
        
    	return true;
    }
    
    // Error Handler
    set_error_handler('error_handler');
    
    // Cache
    $cache = new Cache('file');
    $registry->set('cache', $cache);
    
    // Session
    $session = new Session();
    $session->data['token'] = md5(uniqid());
    $registry->set('session', $session);
    
    // Language
    $languages = array();
    
    $query = $db->query("SELECT * FROM `" . DB_PREFIX . "language`");
    
    foreach ($query->rows as $result) {
    	$languages[$result['code']] = $result;
    }
    
    $config->set('config_language_id', $languages[$config->get('config_admin_language')]['language_id']);
    
    // Language
    $language = new Language($languages[$config->get('config_admin_language')]['directory']);
    $language->load('default');
    $registry->set('language', $language);
    
    // Currency
    $registry->set('currency', new Currency($registry));
    
    // Weight
    $registry->set('weight', new Weight($registry));
    
    // Length
    $registry->set('length', new Length($registry));
    
    // User
    $registry->set('user', new User($registry));
    
    // Front Controller
    $controller = new Front($registry);
    
    // Router
    $action = new Action($_GET['route']);
    
    // Execute
    $action->execute($registry);
}
?>