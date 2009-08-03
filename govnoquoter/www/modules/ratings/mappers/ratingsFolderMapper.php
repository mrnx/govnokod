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

    protected $map = array(
        'id' => array(
            'accessor' => 'getId',
            'mutator' => 'setId',
            'options' => array('pk', 'once')
         ),
        'alias_id' => array(
            'accessor' => 'getAlias',
            'mutator' => 'setAlias',
            'relation' => 'one',
            'foreign_key' => 'id',
            'mapper' => 'ratings/ratingsAlias',
            'options' => array('once')
        ),
        'parent_id' => array(
            'accessor' => 'getParentId',
            'mutator' => 'setParentId'
        ),
        'rating' => array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        ),
        'ratings_on' => array(
            'accessor' => 'getRatingsOn',
            'mutator' => 'setRatingsOn'
        ),
        'ratings_against' => array(
            'accessor' => 'getRatingsAgainst',
            'mutator' => 'setRatingsAgainst'
        )
    );

    public function searchById($id)
    {
        return $this->searchByKey($id);
    }

    public function searchByAliasAndParentId($aliasId, $parentId)
    {
        $criteria = new criteria;
        $criteria->add('alias_id', $aliasId)->add('parent_id', $parentId);

        return $this->searchOneByCriteria($criteria);
    }

    public function preInsert(array & $data)
    {
        $data['ratings_on'] = 0;
        $data['ratings_against'] = 0;
    }

    public function ratingAdded(Array $data)
    {
        $ratingsFolder = $data['ratingsFolder'];
        $ratingsAlias = $ratingsFolder->getAlias();

        if ($ratingsAlias->getDriver() == 'govnokodOnAgainst') {
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

            $ratingsFolder->setRating($ratingsFolder->getRating() + $value);
            $this->save($ratingsFolder);

            $data['ratingsFolder'] = $ratingsFolder;

            $commentedObjectMapper = $ratingsAlias->getObjectMapper();
            $commentedObjectMapper->notify('ratingAdded', $data);
        }
    }

    public function convertArgsToObj($args)
    {
        /*
        return $this->create();

        if (isset($args['alias'])) {
            $do = $this->searchByAlias($args['alias']);
            if ($do) {
                return $do;
            }
        }

        throw new mzzDONotFoundException();
        */
    }
}

?>