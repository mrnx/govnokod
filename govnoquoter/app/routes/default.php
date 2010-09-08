<?php
//$router->enableDebug();
$router->addRoute('default', new requestRoute('', array('module' => 'quoter', 'action' => 'list', 'type' => 'all')));

?>