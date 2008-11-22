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
 * quoterSaveController: контроллер для метода add модуля quoter
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quoterSaveController extends simpleController
{
    protected function getView()
    {
        $action = $this->request->getAction();
        $isEdit = ($action == 'edit');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
        if ($isEdit) {
            $id = $this->request->getInteger('id');
            $quote = $quoteMapper->searchById($id);

            if (!$quote) {
                return $quoteMapper->get404()->run();
            }
        } else {
            $quote = $quoteMapper->create();
        }

        $currentCategory = (!$isEdit) ? $this->request->getString('name') : '';
        $this->smarty->assign('currentCategory', null);

        $categories = $categoryMapper->searchAll();
        $categoriesSelect = array();
        foreach ($categories as $category) {
            if ($category->getName() == $currentCategory) {
                $this->smarty->assign('currentCategory', $category->getId());
            }
            $categoriesSelect[$category->getId()] = $category->getTitle();
        }

        $validator = new formValidator();
        $validator->add('required', 'text', 'Укажите код');
        $validator->add('callback', 'text', 'Такой большой код врядли может быть смешным', array('checkCodeLength'));
        $validator->add('required', 'category_id', 'Укажите категорию');
        $validator->add('in', 'category_id', 'Укажите правильную категорию', array_keys($categoriesSelect));
        if ($validator->validate()) {
            $categoryId = $this->request->getInteger('category_id', SC_POST);
            $text = $this->request->getString('text', SC_POST);
            $desciption = $this->request->getString('description', SC_POST);

            $lines = $this->request->getArray('lines', SC_POST);
            $linesCount = substr_count($text, "\n");

            $highlightedLines = array();
            foreach ($lines as $line) {
                if ($line > 0 && $line < $linesCount && !in_array($line, $highlightedLines)) {
                    $highlightedLines[] = $line;
                }
            }

            $quote->setCategory($categoryId);
            $quote->setText($text);
            $quote->setDescription($desciption);
            $quote->setHighlitedLines(join(', ', $highlightedLines));
            $quoteMapper->save($quote);

            $url = new url('quoteView');
            $url->add('id', $quote->getId());

            $this->response->redirect($url->get());
        }

        $this->smarty->assign('categoriesSelect', $categoriesSelect);
        $this->smarty->assign('isEdit', $isEdit);
        $this->smarty->assign('quote', $quote);
        $this->smarty->assign('errors', $validator->getErrors());
        return $this->smarty->fetch('quoter/save.tpl');
    }
}

function checkCodeLength($text) {
    $linesCount = substr_count($text, "\n");
    return ($linesCount < 100);
}

?>