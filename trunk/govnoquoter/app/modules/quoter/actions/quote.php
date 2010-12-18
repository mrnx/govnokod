<?php
return array(
    'view' => array(
        'controller' => 'view',
        'title' => 'Просмотр записи'
    ),
    'edit' => array(
        'controller' => 'save',
        'title' => 'Редактировать',
        'jip' => 1,
        'icon' => 'sprite:mzz-icon/page-text/edit',
        'role' => array('admin')
    ),
    'delete' => array(
        'controller' => 'delete',
        'title' => 'Удалить',
        'jip' => 1,
        'icon' => 'sprite:mzz-icon/page-text/del',
        'confirm' => 'Вы уверены, что хотите удалить данный элемент?',
        'role' => array('admin')
    )
);
?>