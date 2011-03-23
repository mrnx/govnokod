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
 * commentsEditController: контроллер для метода edit модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.0.1
 */
class commentsEditController extends simpleController
{
    protected function getView()
    {
        $user = $this->toolkit->getUser();

        $commentsMapper = $this->toolkit->getMapper('comments', 'comments');
        $id = $this->request->getInteger('id');

        $comment = $commentsMapper->searchByKey($id);
        if (!$comment) {
            return $this->forward404($commentsMapper);
        }

        $validator = new formValidator();
        $validator->submit('commentSubmit');

        $validator->filter('trim', 'text');

        $validator->rule('required', 'text', 'Введите хоть что-нибудь!');
        $validator->rule('length', 'text', 'Слишком длинный комментарий! Максимум 2000 символов!', array(0, 2000));

        $is_ajax = $this->request->getBoolean('ajax', SC_REQUEST);

        if ($is_ajax) {
            $this->view->disableMain();
        }

        if ($validator->validate()) {
            $text = $this->request->getString('text', SC_POST);

            $comment->setEditTimes($comment->getEditTimes() + 1);
            $comment->setEdited(time());
            $comment->setText($text);
            $commentsMapper->save($comment);

            if ($is_ajax) {
                $this->view->assign('comment', $comment);
                return $this->render('comments/ajax_edit_done.tpl');
            } else {
                $commentsFolder = $comment->getFolder();
                $back_url = $commentsFolder->getDefaultBackUrl();
                if (!$back_url) {
                    $url = new url('default');
                    $back_url = $url->get();
                }

                $this->redirect($back_url . '#comment' . $comment->getId());
                return;
            }
        }

        $url = new url('withId');
        $url->setAction('edit');
        $url->add('id', $comment->getId());

        $this->view->assign('comment', $comment);
        $this->view->assign('validator', $validator);
        $this->view->assign('form_action', $url->get());
        $this->view->assign('user', $user);

        if ($is_ajax) {
            $this->setTemplatePrefix('ajax_');
        }

        $formTitles = array(
            'Надеюсь, что тебе стыдно за это, <b>' . htmlspecialchars($user->getLogin()) . '</b>',
            'Давай быстрее, <b>' . htmlspecialchars($user->getLogin()) . '</b>, пока нас не заметили!',
            'Не палимся, <b>' . htmlspecialchars($user->getLogin()) . '</b>!',
        );

        $session = $this->toolkit->getSession();
        if (strtolower($this->request->getMethod()) != 'post') {
            $currentTitleIndex = mt_rand(0, sizeof($formTitles) - 1);
            $session->set('comments_form_edit_title_index', $currentTitleIndex);
        } else {
            $currentTitleIndex = $session->get('comments_form_edit_title_index', -1);
            if (!isset($formTitles[$currentTitleIndex])) {
                $currentTitleIndex = mt_rand(0, sizeof($formTitles) - 1);
                $session->set('comments_form_edit_title_index', $currentTitleIndex);
            }
        }

        $this->view->assign('formTitle', $formTitles[$currentTitleIndex]);
        return $this->render('comments/edit.tpl');
    }
}
?>