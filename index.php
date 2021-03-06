<?php
define('ROOT', dirname(__FILE__).'/');//A remplacer par $_SERVER['SCRIPT_NAME'] en cas de problème
define('WEBROOT', '/blog/');

$action = 'view';
$controller = 'Index';
$get = null;

/* Récupération des paramètres de l'URL */
if(isset($_GET['p']) && !empty($_GET['p'])){
	$param = explode('/', $_GET['p']); 
	if (count($param)>1) {		
		$action = $param[1];
		$controller = $param[0];
		if(isset($param[2]) && !empty($param[2])){
			$get = $param[2];
		}		
	}
}


require_once(ROOT.'core/model.php');
require_once(ROOT.'core/controller.php');
require_once(ROOT.'core/helper.php');
require_once(ROOT.'controllers/'.$controller.'.php');

$instance = new $controller();
if(method_exists($controller, $action)){
	if($get == null)
		$instance->$action();
	else
		$instance->$action($get);
}
else
	require_once(ROOT.'404.html');


?>