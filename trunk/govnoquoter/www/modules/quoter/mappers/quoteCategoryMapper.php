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

fileLoader::load('quoter/quoteCategory');
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

/**
 * quoteCategoryMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.2
 */

class quoteCategoryMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'quoteCategory';
    protected $table = 'quoter_quoteCategory';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        ),
        'name' => array(
            'accessor' => 'getName',
            'mutator' => 'setName'
        ),
        'highlite_name' => array(
            'accessor' => 'getHighliteName',
            'mutator' => 'setHighliteName'
        ),
        'title' => array(
            'accessor' => 'getTitle',
            'mutator' => 'setTitle',
        ),
        'quote_counts' => array(
            'accessor' => 'getQuoteCounts',
            'mutator' => 'setQuoteCounts'
        ),
    );

    public function __construct()
    {
        parent::__construct();
        $this->attach(new acl_simplePlugin(), 'acl');
        $this->plugins('jip');
    }

    public function searchByName($name)
    {
        return $this->searchOneByField('name', $name);
    }

    public function searchAllWithQuotes()
    {
        $criteria = new criteria;
        $criteria->add('quote_counts', 0, criteria::GREATER)->setOrderByFieldDesc('quote_counts');

        return $this->searchAllByCriteria($criteria);
    }

    public function getPage(quoteCategory $category)
    {
        $pageMapper = systemToolkit::getInstance()->getMapper('page', 'page', 'page');

        $criteria = new criteria;
        $criteria->add('name', $category->getName());

        //@todo: убрать хардкод
        $criteria->add('folder_id', 2);
        return $pageMapper->searchOneByCriteria($criteria);
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        if (isset($args['name'])) {
            $do = $this->searchByName($args['name']);
            if ($do) {
                return $do;
            }
        }
        throw new mzzDONotFoundException();
    }
}

?>