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
    const VOTE_TOKEN_PREFIX = 'votetoken_';
    const CACHE_PREFIX = 'quote_';
    const CACHE_NAME = 'geshi_code';

    protected $linesCount = 0;
    protected $token = null;

    public function getJip()
    {
        return '';
    }

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

    public function getTimeToDie()
    {
        $deleteAt = $this->getDeleted() - time();

        if ($deleteAt >= 0) {
            $daysToEnd = floor($deleteAt / 86400);
            $hoursToEnd = floor(($deleteAt - ($daysToEnd * 86400)) / 3600);
            $minutesToEnd = floor((($deleteAt - ($daysToEnd * 86400)) - ($hoursToEnd * 3600)) / 60);
            $secondsToEnd = floor((($deleteAt - ($daysToEnd * 86400)) - ($hoursToEnd * 3600)) - ($minutesToEnd * 60));

            $result = '';
            if ($daysToEnd > 0) {
                $result .= i18n::getMessage('endTime.days', $this->name, 'ru', $daysToEnd) . ' ';
            }

            if ($daysToEnd > 0 || $hoursToEnd > 0) {
                $result .= i18n::getMessage('endTime.hours', $this->name, 'ru', $hoursToEnd) . ' ';
            }

            if (($hoursToEnd > 0 || $minutesToEnd > 0) && $daysToEnd < 1) {
                $result .= i18n::getMessage('endTime.minutes', $this->name, 'ru', $minutesToEnd) . ' ';
            }

            if (($minutesToEnd > 0 || $secondsToEnd > 0) && $hoursToEnd < 1) {
                $result .= i18n::getMessage('endTime.seconds', $this->name, 'ru', $secondsToEnd) . ' ';
            }

            return $result;
        }

        return i18n::getMessage('endTime.seconds', 'quoter', 'ru', 0) . ' ';
    }

    public function getVoteToken()
    {
        if (is_null($this->token)) {
            $session = systemToolkit::getInstance()->getSession();
            $token = md5(microtime(true) . $this->getId());
            $session->set($this->getTokenName(), $token);
            $this->token = $token;
        }
        return $this->token;
    }

    public function getTokenName()
    {
        return self::VOTE_TOKEN_PREFIX . $this->getId();
    }

    public function getCacheKey()
    {
        return self::CACHE_PREFIX . $this->getId();
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