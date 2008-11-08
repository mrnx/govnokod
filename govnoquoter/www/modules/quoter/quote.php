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

    protected $lines = 0;

    public function getLines()
    {
        if ($this->lines == 0) {
            $text = $this->getText();
            $lines = substr_count($text, "\n");
            $this->lines = $lines < 1 ? 1 : $lines + 1;
        }

        return $this->lines;
    }

    public function generateLines()
    {
        $lines = array();
        $linesCount = $this->getLines();
        $chars = strlen($linesCount);
        for($i = 1; $i <= $linesCount; $i++) {
            $lines[] = sprintf('%0' . $chars . 'd', $i);
        }

        return $lines;
    }
}

?>