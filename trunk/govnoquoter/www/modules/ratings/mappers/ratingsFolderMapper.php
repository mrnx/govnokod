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

fileLoader::load('ratings/ratingsFolder');
fileLoader::load('orm/plugins/identityMapPlugin');

/**
 * ratingsFolderMapper: маппер
 *
 * @package modules
 * @subpackage ratings
 * @version 0.3
 */
class ratingsFolderMapper extends mapper
{
    /**
     * Имя класса DataObject
     *
     * @var string
     */
    protected $class = 'ratingsFolder';
    protected $table = 'ratings_ratingsFolder';

    protected $map = array (
        'id' => array (
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array ('pk', 'once')
        ),
        'parent_id' => array (
            'accessor' => 'getParentId',
            'mutator' => 'setParentId',
        ),
        'rating' => array (
            'accessor' => 'getRating',
            'mutator' => 'setRating',
        ),
        'ratings_on' => array (
            'accessor' => 'getRatingsOn',
            'mutator' => 'setRatingsOn',
        ),
        'ratings_against' => array (
            'accessor' => 'getRatingsAgainst',
            'mutator' => 'setRatingsAgainst',
        ),
        'module' => array (
            'type' => 'char',
            'maxlength' => 20,
            'accessor' => 'getModule',
            'mutator' => 'setModule',
        ),
        'class' => array (
            'type' => 'char',
            'maxlength' => 20,
            'accessor' => 'getClass',
            'mutator' => 'setClass',
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->plugins('acl_simple');
        $this->plugins('identityMap');
    }

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function searchByModuleClassAndParent($module, $class, $id)
    {
        $criteria = new criteria;
        $criteria->add('module', $module)->add('class', $class)->add('parent_id', $id);

        $folder = $this->searchOneByCriteria($criteria);

        if (!$folder) {
            try {
                $ratedObjectMapper = systemToolkit::getInstance()->getMapper($module, $class);

                if ($ratedObjectMapper->isAttached('ratings')) {
                    $object = $ratedObjectMapper->searchByKey($id);
                    if ($object) {
                        $folder = $this->create();
                        $folder->setModule($module);
                        $folder->setClass($class);


                        $pkAccessor = $ratedObjectMapper->pk();
                        $map = $ratedObjectMapper->map();
                        $objectId = $object->$map[$pkAccessor]['accessor']();
                        $folder->setParentId($objectId);


                        $this->save($folder);

                        $folder->setObjectMapper($ratedObjectMapper);
                        $folder->setObject($object);
                    }
                }
            } catch (mzzException $ex) {
                $folder = null;
            }
        }

        return $folder;
    }

    public function preInsert(array & $data)
    {
        $data['rating'] = 0;
        $data['ratings_on'] = 0;
        $data['ratings_against'] = 0;
    }

    public function ratingAdded(Array $data)
    {
        $ratingsFolder = $data['ratingsFolder'];
        $ratedObjectMapper = $ratingsFolder->getObjectMapper();

        if ($ratedObjectMapper->plugin('ratings')->getDriver() == 'simple') {
            $ratings = $data['ratings'];

            $value = (int)$ratings->getRateValue();

            switch ($value) {
                case 1:
                    $ratingsFolder->setRatingsOn($ratingsFolder->getRatingsOn() + 1);
                    break;

                case -1:
                    $ratingsFolder->setRatingsAgainst($ratingsFolder->getRatingsAgainst() + 1);
                    break;
            }

            $currentRating = (int)$ratingsFolder->getRating();
            $newRating = $currentRating + $value;
            //echo ' ' . $newRating;

            $ratingsFolder->setRating($newRating);
            $this->save($ratingsFolder);

            //echo ' ' . $ratingsFolder->getRating();

            //Ничего не понимаю... Почему-то из БД берется старое значение рейтинга,
            //поэтому мы его замерджим!
            //@todo: разобраться!
            $ratingsFolder->merge(array('rating' => $newRating));

            $data['ratingsFolder'] = &$ratingsFolder;
            $data['ratedObject'] = $ratingsFolder->getObject();

            $ratedObjectMapper->notify('ratingAdded', $data);
        }
    }

    public function convertArgsToObj($args)
    {
        if (isset($args['module_name']) && isset($args['class_name']) && isset($args['id'])) {
            $do = $this->searchByModuleClassAndParent($args['module_name'], $args['class_name'], $args['id']);

            if ($do) {
                return $do;
            }
        }

        throw new mzzDONotFoundException();
    }
}

?>