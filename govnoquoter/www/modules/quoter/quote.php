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
    protected $name = 'quoter';

    protected $linesCount = 0;

    public function getText($linesNum = null)
    {
        $text = parent::__call('getText', array());
        if ($linesNum > 0 && $linesNum < $this->getLinesCount()) {
            $text = implode("\n", array_slice(explode("\n", $text), 0, $linesNum));
        }

        return $text;
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
}

?>