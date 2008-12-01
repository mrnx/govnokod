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

fileLoader::load('forms/validators/formValidator');

/**
 * commentsFolderPostController: контроллер для метода post модуля comments
 *
 * @package modules
 * @subpackage comments
 * @version 0.1.2
 */

class commentsFolderPostController extends simpleController
{
    protected function getView()
    {
        $commentsMapper = $this->toolkit->getMapper('comments', 'comments', 'comments');
        $commentsFolderMapper = $this->toolkit->getMapper('comments', 'commentsFolder', 'comments');

        $parent_id = $this->request->getInteger('id');

        $validator = new formValidator();
        $validator->add('required', 'text', 'Пустые комментарии нам не нужны');

        $action = $this->request->getAction();
        $isEdit = ($action == 'edit');

        if (!$isEdit) {
            $validator->add('required', 'captcha', 'Укажите код на картинке!');
            $validator->add('captcha', 'captcha', 'Неверно введен проверочный код!');
        }

        $username = $this->request->getString('username', SC_POST);
        $text = $this->request->getString('text', SC_POST);
        $remember = $this->request->getBoolean('remember', SC_POST);

        if (!$validator->validate()) {
            $section = $this->request->getSection();
            $session = $this->toolkit->getSession();
            $sess_name = $section . '_' . 'comments_' . $parent_id;

            if (strtolower($this->request->getMethod()) != 'post') {
                $rememberedUsername = mb_substr($this->request->getString('username', SC_COOKIE), 0, comments::USERNAME_MAX_CHARS);
                $remember = ($rememberedUsername != '') ? true : false;

                $this->smarty->assign('username', $rememberedUsername);
                $this->smarty->assign('remember', $remember);
                $this->smarty->assign('text', '');
                $this->smarty->assign('errors', $validator->getErrors());

                if ($isEdit) {
                    $comment = $commentsMapper->searchById($parent_id);

                    if (!$comment) {
                        return $commentsMapper->get404()->run();
                    }

                    $this->smarty->assign('text', $comment->getText());
                    $this->smarty->assign('username', $comment->getAuthor());
                    $this->smarty->assign('remember', false);
                }

                if ($session->exists($sess_name)) {
                    $arr = $session->get($sess_name);
                    $this->smarty->assign('text', $arr['text']);
                    $this->smarty->assign('username', $arr['username']);
                    $this->smarty->assign('remember', $arr['remember']);
                    $this->smarty->assign('errors', $arr['validator']->getErrors());

                    $this->toolkit->setValidator($arr['validator']);

                    $session->destroy($sess_name);
                }

                $this->smarty->assign('action', $action);
                $this->smarty->assign('isEdit', $isEdit);

                $url = new url('withId');
                $url->setAction($action);
                $url->add('id', $parent_id);

                $this->smarty->assign('action', $url->get());
                $this->smarty->assign('url', $this->request->getServer('REQUEST_URI'));

                return $this->smarty->fetch('comments/post.tpl');
            }

            $text = $this->request->getString('text', SC_POST);
            $username = $this->request->getString('username', SC_POST);
            $remember = $this->request->getBoolean('remember', SC_POST);
            $session->set($sess_name, array('text' => $text, 'username' => $username, 'remember' => $remember, 'validator' => $validator));
        } else {
            $username = mb_substr(trim($username), 0, comments::USERNAME_MAX_CHARS);
            $text = mb_substr(trim($text), 0, comments::TEXT_MAX_CHARS);

            if ($isEdit) {
                $comment = $commentsMapper->searchById($parent_id);

                if (!$comment) {
                    return $commentsMapper->get404()->run();
                }
            } else {
                $commentsFolder = $commentsFolderMapper->searchOneByField('parent_id', $parent_id);

                if (!$commentsFolder) {
                    return $commentsFolderMapper->get404()->run();
                }

                $comment = $commentsMapper->create();
                $comment->setFolder($commentsFolder);

                $ip = $this->request->getServer('REMOTE_ADDR');
                $comment->setAuthorIp($ip);

                if ($remember) {
                    $this->response->setCookie('username', $username, time() + (3600 * 24 * 10));
                } else {
                    $this->response->setCookie('username', '', -1);
                }
            }

            $comment->setText($text);
            $comment->setAuthor($username);

            $commentsMapper->save($comment);

            if ($isEdit) {
                return jipTools::redirect();
            }
        }

        $url = $this->request->getString('url', SC_POST);

        $anchor = '#addcomment';
        if (isset($comment) && $comment) {
            $anchor = '#comment' . $comment->getId();
        }

        $this->response->redirect($url . $anchor);
    }
}

function checkParamLength($param, $max)
{
    return (mb_strlen($param) < $max);
}

?>