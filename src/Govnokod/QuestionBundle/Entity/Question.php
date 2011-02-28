<?php

namespace Govnokod\QuestionBundle\Entity;

/**
 * Govnokod\QuestionBundle\Entity\Question
 */
class Question
{
    /**
     * @var integer $id
     */
    private $id;

    /**
     * @var string $title
     */
    private $title;

    /**
     * @var text $body
     */
    private $body;

    /**
     * @var boolean $is_solved
     */
    private $is_solved;

    /**
     * Get id
     *
     * @return integer $id
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set title
     *
     * @param string $title
     */
    public function setTitle($title)
    {
        $this->title = $title;
    }

    /**
     * Get title
     *
     * @return string $title
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set body
     *
     * @param text $body
     */
    public function setBody($body)
    {
        $this->body = $body;
    }

    /**
     * Get body
     *
     * @return text $body
     */
    public function getBody()
    {
        return $this->body;
    }

    /**
     * Set is_solved
     *
     * @param boolean $isSolved
     */
    public function setIsSolved($isSolved)
    {
        $this->is_solved = $isSolved;
    }

    /**
     * Get is_solved
     *
     * @return boolean $isSolved
     */
    public function getIsSolved()
    {
        return $this->is_solved;
    }
    /**
     * @var text $message
     */
    private $message;

    /**
     * Set message
     *
     * @param text $message
     */
    public function setMessage($message)
    {
        $this->message = $message;
    }

    /**
     * Get message
     *
     * @return text $message
     */
    public function getMessage()
    {
        return $this->message;
    }
}