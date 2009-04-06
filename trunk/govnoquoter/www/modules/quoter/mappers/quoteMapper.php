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

fileLoader::load('quoter/quote');
fileLoader::load('orm/plugins/acl_extPlugin');

/**
 * quoteMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.2
 */

class quoteMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'quote';
    protected $table = 'quoter_quote';

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
        ),
        'category_id' => array(
            'accessor' => 'getCategory',
            'mutator' => 'setCategory',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'quoter/quoteCategoryMapper'
        ),
        'created' => array(
            'accessor' => 'getCreated',
            'mutator' => 'setCreated',
            'options' => array('once',)
        ),
        'deleted' => array(
            'accessor' => 'getDeleted',
            'mutator' => 'setDeleted'
        ),
        'text' => array(
            'accessor' => 'getText',
            'mutator' => 'setText'
        ),
        'description' => array(
            'accessor' => 'getDescription',
            'mutator' => 'setDescription'
        ),
        'rating' => array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        ),
        'highlited_lines' => array(
            'accessor' => 'getHighlitedLines',
            'mutator' => 'setHighlitedLines'
        ),
        'active' => array(
            'accessor' => 'getIsActive',
            'mutator' => 'setIsActive'
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->attach(new acl_extPlugin(), 'acl');
        $this->plugins('jip');
        $this->plugins('comments');
    }

    public function searchById($id)
    {
        return $this->searchOneByField('id', $id);
    }

    /**
     * Выполнение операций с массивом $fields перед вставкой в БД
     *
     * @param array $fields
     */
    protected function insertDataModify(&$fields)
    {
        $fields['created'] = new sqlFunction('UNIX_TIMESTAMP');
        $fields['rating'] = 0;
        $fields['active'] = 1;
    }

    /**
     * Хук, вызываемый сразу же после добавления объекта в БД
     *
     * @param array $fields
     */
    protected function afterInsert(&$fields)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory', $this->section);
        $fields['category_id']->setQuoteCounts($fields['category_id']->getQuoteCounts() + 1);
        $categoryMapper->save($fields['category_id']);
    }

    public function delete(quote $do)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory', $this->section);
        $category = $do->getCategory();
        $category->setQuoteCounts($category->getQuoteCounts() - 1);
        $categoryMapper->save($category);

        parent::delete($do);
    }

    public function clearSuxx()
    {
        /*
        $needClear = (rand(1, 4) === 1);
        if ($needClear) {
            $query = 'UPDATE ' . $this->table() . ' SET `active` = 0 WHERE `rating` < 0 AND `deleted` <= ' . time();
            $this->db()->query($query);
        }
        */
    }

    /**
     * Возвращает доменный объект по аргументам
     *
     * @return simple
     */
    public function convertArgsToObj($args)
    {
        if (isset($args['id'])) {
            $do = $this->searchById($args['id']);
            if ($do) {
                return $do;
            }
        }
        throw new mzzDONotFoundException();
    }
}

?>