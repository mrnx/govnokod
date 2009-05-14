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
    protected $options = array(
        'rating_field' => 'rating',
        'rating_count_field' => null
    );

    protected function updateMap(& $map)
    {
        $map[$this->options['rating_field']] = array(
            'accessor' => 'getRating',
            'mutator' => 'setRating'
        );

        if ($this->isWithRatingCountField()) {
            $map[$this->options['rating_count_field']] = array(
                'accessor' => 'getRatingCount',
                'mutator' => 'setRatingCount'
            );
        }
    }

    public function isWithRatingCountField()
    {
        return !is_null($this->options['rating_count_field']);
    }

    /*
    public function postDelete(entity $object)
    {
        $toolkit = systemToolkit::getInstance();
        $commentsFolderMapper = $toolkit->getMapper('comments', 'commentsFolder');

        $objectType = get_class($object);

        $map = $this->mapper->map();

        $objectId = $object->$map[$this->getByField()]['accessor']();
        $commentsFolder = $commentsFolderMapper->searchFolder($objectType, $objectId);
        if ($commentsFolder) {
            $commentsFolderMapper->delete($commentsFolder);
        }
    }
    */
}
?>