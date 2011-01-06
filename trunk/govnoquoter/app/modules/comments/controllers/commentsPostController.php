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
 * commentsPostController: контроллер для метода post модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.2
 */
class commentsPostController extends simpleController
{
    protected function getView()
    {
        $user = $this->toolkit->getUser();

        $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder');
        $commentsMapper = $this->toolkit->getMapper('comments', 'comments');
        $id = $this->request->getRaw('id');

        if ($id instanceof commentsFolder) {
            $commentsFolder = $id;
            $id = $commentsFolder->getId();
        }

        $onlyForm = $this->request->getBoolean('onlyForm');
        if (!isset($commentsFolder)) {
            $commentsFolder = $commentsFolderMapper->searchById($id);
            if (!$commentsFolder) {
                return $this->forward404($commentsFolderMapper);
            }
        }

        $comment = $commentsMapper->create();

        $commentReply = null;
        $replyToId = $this->request->getInteger('replyTo', SC_PATH | SC_GET);
        if ($replyToId > 0) {
            $commentReply = $commentsMapper->searchByFolderAndId($commentsFolder, $replyToId);
            if (!$commentReply) {
                return $this->forward404($commentsMapper);
            }
        }

        $validator = new formValidator();
        $validator->submit('commentSubmit');

        $validator->filter('trim', 'text');

        $validator->rule('required', 'text', 'Введите хоть что-нибудь!');
        $validator->rule('length', 'text', 'Слишком длинный комментарий! Максимум 2000 символов!', array(0, 2000));

        if (!$user->isLoggedIn()) {
            $validator->filter('trim', 'captcha');

            $validator->rule('required', 'captcha', 'Введите проверочный код!');
            $validator->rule('captcha', 'captcha', 'Неверно введен проверочный код!');

            $guest_comments_disabled_until = strtotime('2010-04-27');
            if (!$user->isLoggedIn() && time() < $guest_comments_disabled_until) {
                $validator->setError('text', 'На сайте проводится профилактика, поэтому гостям нельзя писать комментарии до 27 апреля. Говнокод.ру благодарит Вас за понимание!');
            }
        }

        $isAjax = $this->request->getBoolean('ajax', SC_POST);

        if (!$onlyForm && $validator->validate()) {
            $text = $this->request->getString('text', SC_POST);

            $comment->setFolder($commentsFolder);
            $comment->setUser($user);

            if ($commentReply) {
                $comment->setTreeParent($commentReply);
            }

            $ip = $this->request->getServer('REMOTE_ADDR');
            $comment->setAuthorIp($ip);

            $comment->setText(mzz_trim($text));
            $commentsMapper->save($comment);

            if ($user->isLoggedIn()) {
                $commentsLastSeenMapper = $this->toolkit->getMapper('comments', 'commentsLastSeen');
                $commentsLastSeenMapper->saveSeen($user, $commentsFolder, $commentsFolder->getCommentsCount());
            }

            if ($isAjax) {
                $this->view->disableMain();
                $this->view->assign('comment', $comment);
                $this->view->assign('commentsFolder', $commentsFolder);
                return $this->view->render('comments/post_added_ajax.tpl');
            } else {
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
        $url->setAction($this->request->getAction());
        $url->add('id', $commentsFolder->getId());

        if ($commentReply) {
            $url->add('replyTo', $commentReply->getId(), true);
        }

        $this->view->assign('action', $url->get());
        $this->view->assign('user', $user);
        $this->view->assign('validator', $validator);
        $this->view->assign('comment', $comment);
        $this->view->assign('commentReply', $commentReply);
        $this->view->assign('commentsFolder', $commentsFolder);
        $this->view->assign('hideForm', $this->request->getBoolean('hideForm'));
        $this->view->assign('onlyForm', $onlyForm);
        $this->view->assign('showCaptcha', true);

        $this->view->assign('isAjax', $isAjax);
        if ($isAjax) {
            $this->view->disableMain();
            $this->setTemplatePrefix('ajax_');
        }

        $formTitles = array(
            'Я, <b>' . htmlspecialchars($user->getLogin()) . '</b>, находясь в здравом уме и твердой памяти, торжественно заявляю:',
            'Помни, <b>' . htmlspecialchars($user->getLogin()) . '</b>, за тобой могут следить!',
            'Семь раз отмерь — один отрежь, <b>' . htmlspecialchars($user->getLogin()) . '</b>!',
            'Где здесь C++, <b>' . htmlspecialchars($user->getLogin()) . '</b>?!',
        );

        $session = $this->toolkit->getSession();
        if ($onlyForm) {
            $currentTitleIndex = mt_rand(0, sizeof($formTitles) - 1);
            $session->set('comments_form_title_index', $currentTitleIndex);
        } else {
            $currentTitleIndex = $session->get('comments_form_title_index', -1);
            if (!isset($formTitles[$currentTitleIndex])) {
                $currentTitleIndex = mt_rand(0, sizeof($formTitles) - 1);
                $session->set('comments_form_title_index', $currentTitleIndex);
            }
        }

        $this->view->assign('formTitle', $formTitles[$currentTitleIndex]);
        return $this->render('comments/post.tpl');
    }
}
?>