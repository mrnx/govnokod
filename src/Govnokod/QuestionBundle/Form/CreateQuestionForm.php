<?php
use Symfony\Component\Form
use Symfony\Component\Form\TextField
use Symfony\Component\Form\TextareaField

class CreateQuestionForm extends Form
{
    protected function configure()
    {
        $this->add(new TextField('title', array(
            'max_length' => 255,
        )));
        $this->add(new TextareaField('message'));
    }
}