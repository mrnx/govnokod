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

/**
 * quoteMapper: маппер
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoteMapper extends simpleMapper
{
    /**
     * Имя модуля
     *
     * @var string
     */
    protected $name = 'quoter';

    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $className = 'quote';

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
        /*
        $db = DB::factory();
        $sql = 'UPDATE `' . $categoryMapper->getTable() . '` SET `quote_counts` = `quote_counts` + 1 WHERE `id` = :id';
        $stmt = $db->prepare($sql);
        $stmt->bindParam(':id', $fields['category_id']->getId());
        $stmt->execute();
        */
    }

    public function delete(quote $do)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory', $this->section);
        $category = $do->getCategory();
        $category->setQuoteCounts($category->getQuoteCounts() - 1);
        $categoryMapper->save($category);

        parent::delete($do);
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