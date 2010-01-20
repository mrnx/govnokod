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
 * commentsRawEditController: контроллер для метода edit модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1.2
 */
class commentsRawEditController extends simpleController
{
    protected function getView()
    {
        $commentsMapper = $this->toolkit->getMapper('comments', 'comments');
        $id = $this->request->getInteger('id');

        $comment = $commentsMapper->searchByKey($id);
        if (!$comment) {
            return $this->forward404($commentsMapper);
        }

        $validator = new formValidator();

        $validator->filter('trim', 'text');

        $validator->rule('required', 'text', 'Введите комментарий');
        $validator->rule('required', 'rating', 'Укажите рейтинг');
        $validator->rule('numeric', 'rating', 'Укажите рейтинг');

        if ($validator->validate()) {
            $text = $this->request->getString('text', SC_POST);
            $rating = $this->request->getNumeric('rating', SC_POST);

            $comment->setText($text);
            $comment->setRating($rating);
            $commentsMapper->save($comment);

            return jipTools::redirect();
        }

        $url = new url('withId');
        $url->setAction('rawedit');
        $url->add('id', $comment->getId());

        $this->smarty->assign('comment', $comment);
        $this->smarty->assign('validator', $validator);
        $this->smarty->assign('form_action', $url->get());

        return $this->smarty->fetch('comments/rawedit.tpl');
    }
}
?>