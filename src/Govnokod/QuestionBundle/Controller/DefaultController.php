<?php

namespace Govnokod\QuestionBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Govnokod\QuestionBundle\Form\CreateQuestionForm;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('QuestionBundle:Default:index.html.twig');
    }

    public function askAction()
    {
        $form = CreateQuestionForm::create($this->get('form.context'), 'question');

        $DO = new deleteMeJustForTest();

        $form->bind($this->get('request'), $DO);

        if ($form->isValid()) {
            return $this->render('QuestionBundle:Default:askSuccess.html.twig', array(
                'DO' => $DO
            ));
        }

        return $this->render('QuestionBundle:Default:ask.html.twig', array(
            'form' => $form
        ));
    }
}


class deleteMeJustForTest
{
    /**
     * @validation:MaxLength(100)
     * @validation:NotBlank
     */
    protected $title;

    /**
     * @validation:NotBlank
     */
    protected $message;

    public function setTitle($title)
    {
        $this->title = $title;
    }

    public function getTitle()
    {
        return $this->title;
    }

    public function setMessage($message)
    {
        $this->message = $message;
    }

    public function getMessage()
    {
        return $this->message;
    }
}