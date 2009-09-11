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
 * @version 0.2
 */

class quote extends entity
{
    const VOTE_TIMEOUT = 7200;
    const MAX_DESC_CHARS = 2000;
    const CACHE_PREFIX = 'quote_';

    protected $linesCount = 0;

    public function getText($linesNum = null)
    {
        $text = parent::__call('getText', array());
        if ($linesNum > 0 && $linesNum < $this->getLinesCount()) {
            $lines = explode("\n", $text);

            $text = implode("\n", array_slice($lines, 0, $linesNum));

            $lastString = array_pop($lines);
            $text .= "…\n" . $lastString;
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

    public function setDescription($description)
    {
        $description = mzz_substr($description, 0, self::MAX_DESC_CHARS);
        parent::__call('setDescription', array($description));
    }

    public function getCacheKey($localPrefix = '')
    {
        return self::CACHE_PREFIX . $localPrefix . $this->getId();
    }

    /*
    public function getNewCommentsCount()
    {
        $user = systemToolkit::getInstance()->getUser();
        if (!$user->isLoggedIn()) {
            return 0;
        }

        return $this->getCommentsCount() - (int)$this->getSeenCommentsCount();
    }
    */

    public function getAcl($name = null)
    {
        $user = systemToolkit::getInstance()->getUser();

        if (!$user->isLoggedIn()) {
            switch ($name) {
                case 'edit':
                case 'delete':
                    return false;
                    break;
            }
        }

        if ($name == 'rate') {
            return $this->getIsActive() && $this->getUser()->getId() != $user->getId();
        }

        return parent::__call('getAcl', array($name));
    }
}
?>