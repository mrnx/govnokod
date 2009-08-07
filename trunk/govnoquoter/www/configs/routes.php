<?php
//$router->enableDebug();
$router->addRoute('withAnyParam', new requestRoute(':section/:name/:action', array('name' => 'root', 'action' => 'view'), array('name' => '.+?')));
$router->addRoute('default2', new requestRoute(':section/:action'));
$router->addRoute('adminDefault', new requestRoute('admin', array('section' => 'admin', 'action' => 'admin')));

$router->addRoute('fmFolder', new requestRoute('fileManager/:name/:action', array('section' => 'fileManager', 'name' => 'root', 'action' => 'get'), array('name' => '.+?', 'action' => '(?:list|upload|edit|delete|get|editFolder|createFolder|deleteFolder|move|moveFolder)')));
$router->addRoute('fmFolderRoot', new requestRoute('fileManager/:action', array('section' => 'fileManager', 'name' => 'root', 'action' => 'list'), array('name' => '.+?', 'action' => '(?:list|upload)')));

$router->addRoute('pageActions', new requestRoute('content/:name/:action', array('section' => 'content', 'action' => 'view'), array('name' => '.+?', 'action' => '(?:view|edit|list|create|delete|createFolder|editFolder|moveFolder|deleteFolder|move)')));
//$router->addRoute('pageDefault', new requestRoute('page', array('section' => 'page', 'action' => 'view', 'name' => 'main')));

$router->addRoute('aclActions', new requestRoute('access/:id/:user_id/:action', array('section' => 'access'), array('id' => '\d+', 'user_id' => '\d+', 'action' => '(?:editUser|editGroup|deleteGroup|deleteUser)')));
//$router->addRoute('aclDefaults', new requestRoute('access/:class_name/:action', array('section' => 'access'), array('action' => '')));
$router->addRoute('aclDefaultsEdit', new requestRoute('access/:class_name/:id/:action', array('section' => 'access'), array('action' => '(?:editGroupDefault|deleteGroupDefault|editUserDefault|deleteUserDefault)', 'id' => '\d+')));
$router->addRoute('aclDefaultsAdd', new requestRoute('access/:class_name/:action', array('section' => 'access'), array('action' => '(?:editDefault|addGroupDefault|addUserDefault|editOwner)')));
$router->addRoute('aclDefaultAction', new requestRoute('access/:id', array('section' => 'access', 'action' => 'edit'), array('id' => '\d+')));

$router->addRoute('categoryList', new requestRoute(':name', array('section' => 'quoter', 'action' => 'list')));
$router->addRoute('quoteView', new requestRoute(':id', array('section' => 'quoter', 'action' => 'view'), array('id' => '\d+')));
//$router->addRoute('commentVote', new requestRoute('comments/:id/:action', array('section' => 'comments', 'action' => '(?:cool|suxx)'), array('id' => '\d+')));
$router->addRoute('quoteAdd', new requestRoute('add', array('section' => 'quoter', 'action' => 'add')));
$router->addRoute('search', new requestRoute('search', array('section' => 'quoter', 'action' => 'search')));
$router->addRoute('best', new requestRoute('best/:nomination/:name', array('section' => 'quoter', 'action' => 'best', 'nomination' => 'rating', 'name' => '')));

$router->addRoute('rateForCode', new requestRoute('ratings/code/:id/:vote', array('section' => 'ratings', 'action' => 'rate', 'module_name' => 'quoter', 'class_name' => 'quote'), array('id' => '\d+')));
$router->addRoute('rateForComment', new requestRoute('ratings/comment/:id/:vote', array('section' => 'ratings', 'action' => 'rate', 'module_name' => 'comments', 'class_name' => 'comments'), array('id' => '\d+')));
$router->addRoute('rate', new requestRoute('ratings/:module_name/:class_name/:id/:vote', array('section' => 'ratings', 'action' => 'rate'), array('param' => '\d+')));

$router->addRoute('rss', new requestRoute('rss', array('section' => 'quoter', 'action' => 'rss')));
$router->addRoute('rssFull', new requestRoute(':name/rss', array('section' => 'quoter', 'action' => 'rss')));

$router->addRoute('captcha', new requestRoute('captcha', array('section' => 'captcha', 'action' => 'view')));

$router->addRoute('admin', new requestRoute('admin/:module_name/:params/:action_name', array('section' => 'admin', 'action' => 'admin', 'params' => ''), array('params' => '.*?')));
$router->addRoute('adminTranslate', new requestRoute('admin/:module_name/:language/translate', array('section' => 'admin', 'action' => 'translate')));
//$router->addRoute('adminCfgEdit', new requestRoute('admin/:id/:name/:action', array('section' => 'admin', 'action' => 'editCfg'), array('id' => '\d+')));
$router->addRoute('adminAction', new requestRoute('admin/:id/:action_name/:action', array('section' => 'admin'), array('id' => '\d+', 'action' => '(?:editAction|deleteAction)')));
$router->addRoute('adminSimpleActions', new requestRoute('admin/:action', array('section' => 'admin')));

$router->addRoute('withId', new requestRoute(':section/:id/:action', array('action' => 'view'), array('id' => '\d+')));
$router->addRoute('default', new requestRoute('', array('section' => 'quoter', 'action' => 'listAll')));

$router->addRoute('tags', new requestRoute(':section/tag/:tag', array('action' => 'searchByTag'), array('tag' => '.+?')));

$router->addRoute('rssUser', new requestRoute('user/:id/rss', array('section' => 'quoter', 'action' => 'userrss')));
$router->addRoute('rssComments', new requestRoute('comments/:id/rss', array('section' => 'comments', 'action' => 'rss')));
//$router->addRoute('rssAllComments', new requestRoute('comments/all/export', array('section' => 'quoter', 'action' => 'exportAllComments')));

$router->addRoute('openIDLogin', new requestRoute('user/openid/login', array('section' => 'user', 'action' => 'openIDLogin')));

?>