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
 * quoteCategory: класс для работы c данными
 *
 * @package modules
 * @subpackage quoter
 * @version 0.2.1
 */
class quoteCategory extends entity
{
    public function isTrash()
    {
        return $this->getId() == quoteCategoryMapper::TRASH_CATEGORY_ID;
    }
}
?>