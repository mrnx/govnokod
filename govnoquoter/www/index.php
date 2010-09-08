<?php

error_reporting(E_ALL);

require_once '../app/config.php';
require_once systemConfig::$pathToSystem . '/index.php';
require_once '../app/application.php';

$application = new application();
$application->run();

?>