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
        $user = $this->toolkit->getUser();

        $action = $this->request->getAction();
        $isEdit = ($action == 'edit');

        $quoteMapper = $this->toolkit->getMapper('quoter', 'quote');
        $categoryMapper = $this->toolkit->getMapper('quoter', 'quoteCategory');
        if ($isEdit) {
            $id = $this->request->getInteger('id');
            $quote = $quoteMapper->searchById($id);

            if (!$quote) {
                return $this->forward404($quoteMapper);
            }
        } else {
            $quote = $quoteMapper->create();
        }

        $categories = $categoryMapper->searchAll();
        $categoriesSelect = array();
        foreach ($categories as $category) {
            $categoriesSelect[$category->getId()] = $category->getTitle();
        }

        $lines = $quote->getHighlightedLines();
        $linesPost = $this->request->getArray('lines', SC_POST);
        if ($linesPost) {
            $lines = $linesPost;
        }

        $this->smarty->assign('lines', $lines);

        $validator = new formValidator();
        $validator->add('required', 'category_id', 'Укажите язык');
        $validator->add('in', 'category_id', 'Укажите правильный язык', array_keys($categoriesSelect));
        $validator->add('required', 'text', 'Укажите код');
        $validator->add('callback', 'text', 'Такой длинный код врядли может быть смешным. Пожалуйста, ограничьтесь сотней строк и 4000 символами.', array('checkCodeLength'));
        $validator->add('callback', 'description', 'Описание может быть не более ' . quote::MAX_DESC_CHARS . ' символов', array('checkDescLength'));

        if (!$isEdit) {
            $validator->add('required', 'captcha', 'Произвол не пройдёт!');
            $validator->add('captcha', 'captcha', 'Неверно введен проверочный код!');
        }

        if ($validator->validate()) {
            $categoryId = $this->request->getInteger('category_id', SC_POST);
            $description = mzz_trim($this->request->getString('description', SC_POST));
            $text = mzz_trim($this->request->getString('text', SC_POST));

            $quote->setCategory($categoryId);
            $quote->setDescription($description);
            $quote->setText($text);
            $quoteMapper->save($quote);

            if ($isEdit) {
                $cache = cache::factory(quote::CACHE_NAME);
                $cache->delete($quote->getCacheKey());
            } else {
                $quote->setUser($user);
            }

            $url = new url('quoteView');
            $url->add('id', $quote->getId());

            if ($this->request->isAjax()) {
                return jipTools::redirect();
            } else {
                $this->response->redirect($url->get());
                return;
            }
        }

        if ($isEdit) {
            $url = new url('withId');
            $url->setAction("edit");
            $url->add('id', $id);
        } else {
            $url = new url('quoteAdd');
        }

        $this->smarty->assign('categoriesSelect', $categoriesSelect);
        $this->smarty->assign('isEdit', $isEdit);
        $this->smarty->assign('quote', $quote);
        $this->smarty->assign('formAction', $url->get());

        $tpl = ($isEdit && $this->request->isAjax()) ? 'editajax' : 'save';
        return $this->smarty->fetch('quoter/' . $tpl . '.tpl');
    }
}

function checkCodeLength($text) {
    if (mzz_strlen($text) > 4000) {
        return false;
    }

    $linesCount = mzz_substr_count($text, "\n");
    return ($linesCount < 100);
}

function checkDescLength($desc) {
    return (mb_strlen($desc) < quote::MAX_DESC_CHARS);
}

?>