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
fileLoader::load('orm/plugins/acl_simplePlugin');
fileLoader::load('modules/comments/plugins/commentsPlugin');
fileLoader::load('modules/ratings/plugins/ratingsPlugin');
fileLoader::load('modules/jip/plugins/jipPlugin');

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
        'user_id' => array(
            'accessor' => 'getUser',
            'mutator' => 'setUser',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'user/userMapper'
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
        'active' => array(
            'accessor' => 'getIsActive',
            'mutator' => 'setIsActive'
        ),
        'comments_count' => array(
            'accessor' => 'getCommentsCount',
            'mutator' => 'setCommentsCount'
        )
    );

    public function __construct()
    {
        $this->attach(new ratingsPlugin(array('rating_count_field' => 'rating_count', 'join_current_user_rate' => true)));
        parent::__construct();
        $this->plugins('acl_simple');
        $this->plugins('jip');
        $this->plugins('comments');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function preInsert(array & $data)
    {
        $data['created'] = new sqlFunction('UNIX_TIMESTAMP');
        $data['rating'] = 0;
        $data['active'] = 1;
    }

    public function postInsert(entity $object)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() + 1);
        $categoryMapper->save($category);
    }

    public function preDelete(entity $object)
    {
        $categoryMapper = systemToolkit::getInstance()->getMapper('quote', 'quoteCategory');
        $category = $object->getCategory();

        $category->setQuoteCounts($category->getQuoteCounts() - 1);
        $categoryMapper->save($category);
    }

    public function commentPostInsert(Array $data)
    {
        list($quote, $comment, $commentFolder) = $data;

        $quote->setCommentsCount($quote->getCommentsCount() + 1);
        $this->save($quote);
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