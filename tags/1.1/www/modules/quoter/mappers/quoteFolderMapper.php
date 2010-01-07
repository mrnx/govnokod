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
    protected $module = 'quoter';

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
        return $folder;
    }

     public function __construct()
    {
        parent::__construct();
        $this->plugins('acl_simple');
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