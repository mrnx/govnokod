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

fileLoader::load('forms/validators/formValidator');

/**
 * quoterSaveCategoryController: контроллер для метода addCategory модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterSaveCategoryController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();
        $isEdit = ($action == 'editCategory');

        $quoteCategoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');

        if ($isEdit) {
            $name = $this->request->getString('name');
            $category = $quoteCategoryMapper->searchByName($name);
            if (!$category) {
                return $this->forward404($quoteCategoryMapper);
            }
        } else {
            $category = $quoteCategoryMapper->create();
        }

        $validator = new formValidator();
        $validator->add('required', 'title', 'Укажите заголовок');
        $validator->add('required', 'highlite_name', 'Укажите geshi-name');
        $validator->add('callback', 'name', 'Идентификатор должен быть уникален', array('checkCategoryName', $category, $quoteCategoryMapper));
        $validator->add('required', 'name', 'Укажите идентификатор');

        if ($validator->validate()) {
            $title = $this->request->getString('title', SC_POST);
            $name = $this->request->getString('name', SC_POST);
            $highlite_name = $this->request->getString('highlite_name', SC_POST);

            $category->setName($name);
            $category->setHighliteName($highlite_name);
            $category->setTitle($title);
            $quoteCategoryMapper->save($category);
            return jipTools::redirect();
        }

        $url = new url(($isEdit) ? 'withAnyParam' : 'default2');
        if ($isEdit) {
            $url->add('name', $name);
        }
        $url->setAction($action);

        $this->smarty->assign('category', $category);
        $this->smarty->assign('isEdit', $isEdit);
        $this->smarty->assign('form_action', $url->get());
        $this->smarty->assign('errors', $validator->getErrors());
        return $this->smarty->fetch('quoter/saveCategory.tpl');
    }
}

function checkCategoryName($name, $category, $categoryMapper)
{
    if ($name == $category->getName()) {
        return true;
    }

    $criteria = new criteria();
    $criteria->add('name', $name);
    return is_null($categoryMapper->searchOneByCriteria($criteria));
}
?>