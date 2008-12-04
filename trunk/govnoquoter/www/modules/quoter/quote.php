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

/**
 * quote: класс для работы c данными
 *
 * @package modules
 * @subpackage quoter
 * @version 0.1
 */

class quote extends simple
{
    const MAX_DESC_CHARS = 2000;

    protected $name = 'quoter';
    protected $linesCount = 0;

    public function getText($linesNum = null)
    {
        $text = parent::__call('getText', array());
        if ($linesNum > 0 && $linesNum < $this->getLinesCount()) {
            $text = implode("\n", array_slice(explode("\n", $text), 0, $linesNum));
        }

        return trim($text);
    }

    public function getLinesCount()
    {
        if ($this->linesCount == 0) {
            $text = $this->getText();
            $lines = substr_count($text, "\n");
            $this->linesCount = $lines < 1 ? 1 : $lines + 1;

        }

        return $this->linesCount;
    }

    public function generateLines($num = null)
    {
        $lines = array();
        $linesCount = $this->getLinesCount();

        $chars = strlen($linesCount);

        if (!is_null($num) && $num < $linesCount) {
            $linesCount = $num;
        }

        for ($i = 1; $i <= $linesCount; $i++) {
            $lines[] = sprintf('%0' . $chars . 'd', $i);
        }

        return $lines;
    }

    public function getHighlightedLines()
    {
        $lines = parent::__call('getHighlitedLines', array());
        if (!$lines) {
            $linesArray = array();
        } else {
            $linesArray = explode(', ', $lines);
        }

        return array_map('intval', $linesArray);
    }

    public function setDescription($description)
    {
        $description = mb_substr($description, 0, self::MAX_DESC_CHARS, 'utf-8');
        parent::__call('setDescription', array($description));
    }

    //@todo: убрать это!!!
    public function setCommentsCountAndSave($count)
    {
        $this->setCommentsCount($count);
        $this->mapper->save($this);
    }

    //@todo: идентификатор группы moderators(4) убрать
    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        $groups = $user->getGroupsList();

        switch ($name) {
            case 'edit':
                return in_array(MZZ_ROOT_GID, $groups);
                break;

            case 'delete':
                return (in_array(4, $groups) || in_array(MZZ_ROOT_GID, $groups));
                break;
        }

        return false;
    }
}

?>