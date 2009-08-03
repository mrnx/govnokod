<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2006
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
*/

/**
 * ratingsPlugin: плагин для рейтингуемых модулей.
 *
 * @package orm
 * @subpackage plugins
 * @version 0.0.1
 */
class ratingsPlugin extends observer
{

    /*
    protected function updateMap(& $map)
    {

        $map[$this->options['rating_field']] = array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        );

        if ($this->isWithJoinCurrentUserRate()) {
            $map['current_user_rate'] = array(
                'accessor' => 'getCurrentUserRate',
                'options' => array('fake', 'ro')
            );
        }

    }
    */

    public function preSqlSelect(criteria $criteria)
    {
        if ($this->isWithJoinCurrentUserRate()) {
            $toolkit = systemToolkit::getInstance();
            $user = $toolkit->getUser();

            $ratingsMapper = $toolkit->getMapper('ratings', 'ratings');
            $ratingsFolderMapper = $toolkit->getMapper('ratings', 'ratings');

            $criterion = new criterion('ratings.parent_id', $this->mapper->table(false) . '.id', criteria::EQUAL, true);
            $criterion->addAnd(new criterion('ratings.user_id', $user->getId()));

            $criteria->addJoin($ratingsMapper->table(), $criterion, 'ratings');

            $criteria->addSelectField('ratings.ratevalue', $this->mapper->table() . mapper::TABLE_KEY_DELIMITER . 'current_user_rate');
        }
    }

    public function isWithJoinCurrentUserRate()
    {
        return (bool)$this->options['join_current_user_rate'];
    }

}
?>