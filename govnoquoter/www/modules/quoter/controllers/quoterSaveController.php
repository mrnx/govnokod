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
        $this->smarty->assign('currentCategory', ($isEdit) ? $quote->getCategory()->getId() : null);

        $categories = $categoryMapper->searchAll();
        $categoriesSelect = array();
        foreach ($categories as $category) {
            if (!$isEdit && $category->getName() == $currentCategory) {
                $this->smarty->assign('currentCategory', $category->getId());
            }
            $categoriesSelect[$category->getId()] = $category->getTitle();
        }

        $lines = $quote->getHighlightedLines();
        $linesPost = $this->request->getArray('lines', SC_POST);
        if ($linesPost) {
            $lines = $linesPost;
        }

        $this->smarty->assign('lines', $lines);

        $validator = new formValidator();
        $validator->add('required', 'text', 'Укажите код');
        $validator->add('callback', 'text', 'Такой длинный код врядли может быть смешным', array('checkCodeLength'));
        $validator->add('callback', 'description', 'Описание может быть не более ' . quote::MAX_DESC_CHARS . ' символов', array('checkDescLength'));
        $validator->add('required', 'category_id', 'Укажите язык');
        $validator->add('in', 'category_id', 'Укажите правильный язык', array_keys($categoriesSelect));

        if (!$isEdit) {
            $validator->add('required', 'captcha', 'Произвол не пройдёт!');
            $validator->add('captcha', 'captcha', 'Неверно введен проверочный код!');
        }

        if ($validator->validate()) {
            $categoryId = $this->request->getInteger('category_id', SC_POST);
            $text = $this->request->getString('text', SC_POST);
            $description = $this->request->getString('description', SC_POST);

            $lines = $this->request->getArray('lines', SC_POST);
            if (!is_array($lines)) {
                $lines = array();
            }
            $linesCount = substr_count($text, "\n") + 1;

            $highlightedLines = array();
            foreach ($lines as $line) {
                echo $line . $linesCount;
                if ($line > 0 && $line <= $linesCount && !in_array($line, $highlightedLines)) {
                    $highlightedLines[] = $line;
                }
            }

            $quote->setCategory($categoryId);
            $quote->setText(trim($text));
            $quote->setDescription($description);
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
    $linesCount = substr_count(trim($text), "\n");
    return ($linesCount < 100);
}

function checkDescLength($desc) {
    return (mb_strlen($desc) < quote::MAX_DESC_CHARS);
}

?>