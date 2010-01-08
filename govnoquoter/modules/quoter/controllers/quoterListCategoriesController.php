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
 * quoterListCategoriesController: контроллер для метода listCategories модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */
class quoterListCategoriesController extends simpleController
{
    const CACHE_TTL = 3600;

    protected function getView()
    {
        fileLoader::load('cache');
        $cache = cache::factory();

        $cacheKey = 'govnokod_main_categoriesList';
        $html = $cache->get($cacheKey);
        if (!$html) {
            $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

            $categories = $categoryMapper->searchAllWithQuotes();

            $this->smarty->assign('categories', $categories);
            $html = $this->fetch('quoter/listCategories.tpl');
            $cache->set($cacheKey, $html, array(), self::CACHE_TTL);
        }

        return $html;
    }
}
?>