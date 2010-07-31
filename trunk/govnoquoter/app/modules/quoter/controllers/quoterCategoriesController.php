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

/**
 * quoterCategoriesController: контроллер для метода categories модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.2
 */
class quoterCategoriesController extends simpleController
{
    const CACHE_TTL = 3600;

    protected function getView()
    {
        $cache = cache::factory('memcache');

        $cacheKey = 'main_categoriesList';
        $result = $cache->get($cacheKey, $html);
        if (!$result) {
            $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

            $categories = $categoryMapper->searchAllWithQuotes();
            
            $this->view->assign('categories', $categories);
            $html = $this->view->render('quoter/main_categories.tpl', 'native');
            $cache->set($cacheKey, $html, array(), self::CACHE_TTL);
        }

        return $html;
    }
}
?>