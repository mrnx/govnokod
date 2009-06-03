<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2008
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU Lesser General Public License (See /docs/LGPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

fileLoader::load('quoter/quoteFolder');
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

/**
 * quoteFolderMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoteFolderMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'quoteFolder';
    protected $table = '';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        )
    );

    public function getFolder()
    {
        $folder = $this->create();
        $obj_id = systemToolkit::getInstance()->getObjectId($this->class);
        $folder->import(array('obj_id' => $obj_id));
        return $folder;
    }

     public function __construct()
    {
        parent::__construct();
        $this->attach(new acl_simplePlugin(), 'acl');
        $this->plugins('jip');
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        return $this->getFolder();
    }
}

?>