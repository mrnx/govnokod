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

fileLoader::load('quoter/models/quoteFolder');
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

    protected $map = array();

    public function getFolder()
    {
        $folder = $this->create();
        return $folder;
    }

     public function __construct()
    {
        parent::__construct();
        $this->plugins('jip');
    }
}

?>