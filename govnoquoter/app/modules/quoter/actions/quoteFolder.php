<?php
//quoteFolder actions config

return array (
    'add' => array(
        'controller' => 'save',
        'title' => 'Добавление записи',
        'role' => 'user'
    ),
    'search' => array(
        'controller' => 'search',
        'title' => 'Поиск'
    ),
    'best' => array(
        'controller' => 'best',
        'title' => 'Список лучших',
    ),
    'categories' => array(
        'controller' => 'categories',
        'title' => 'Список категорий',
        'main' => 'deny'
    ),
    'admin' => array(
        'controller' => 'admin',
        'admin' => true,
        'role' => array(
            'moderator'
        )
    ),
    'adminCategories' => array(
        'controller' => 'adminCategories',
        'title' => 'Список категорий',
        'admin' => true,
        'role' => array(
            'admin'
        )
    ),
    'addCategory' => array(
        'controller' => 'saveCategory',
        'title' => 'Добавить категорию',
        'jip' => '1',
        'icon' => 'sprite:mzz-icon/page/add',
        'route_name' => 'default2',
        'role' => array(
            'admin'
        )
    )
);
?>