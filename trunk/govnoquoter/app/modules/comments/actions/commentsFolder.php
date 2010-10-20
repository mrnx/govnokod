<?php
//commentsFolder actions config

return array(
    'rss' => array(
        'controller' => 'export',
        'title' => 'Экспорт в RSS',
        'main' => 'active.blank.tpl'
    ),
    'userComments' => array(
        'controller' => 'userComments',
        'title' => 'Комментарии пользователя'
    )
);
?>