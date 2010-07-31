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
 * @version 0.3
 */
class quote extends entity
{
    const VOTE_TIMEOUT = 7200;
    const MAX_DESC_CHARS = 2000;
    const SESSION_VOTE_TOKEN_PREFIX = 'votetoken_';

    protected $linesCount = 0;
    protected $vote_token = null;

    protected $category = null;

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

    public function getVoteToken()
    {
        if (is_null($this->vote_token)) {
            $session = systemToolkit::getInstance()->getSession();
            $token = md5(microtime(true) . $this->getId());
            $session->set($this->getTokenName(), $token);
            $this->vote_token = $token;
        }

        return $this->vote_token;
    }

    public function getTokenName()
    {
        return self::SESSION_VOTE_TOKEN_PREFIX . $this->getId();
    }

    public function getNewCommentsCount()
    {
        return $this->getCommentsCount() - (int)$this->getSeenCommentsCount();
    }

    public function isSpecial()
    {
        return $this->getId() == 2222;
    }

    public function getCategoryId()
    {
        if ($this->state() == entity::STATE_NEW) {
            return null;
        }

        return $this->data['category_id'];
    }

    public function getCategory($refresh = false)
    {
        if (is_null($this->category) || $refresh === true) {
            if ($this->state() == entity::STATE_NEW) {
                return parent::__call('getCategory', array());
            }

            $cache_key = 'category_' . $this->getCategoryId();
            $cache = cache::factory('memcache');

            $result = $cache->get($cache_key, $category);
            if (!$result) {
                $category = parent::__call('getCategory', array());
                if ($category) {
                    $cache->set($cache_key, $category, array(), 86400);
                }
            }

            $this->category = $category;
        }

        return $this->category;
    }
    
    public function getGeshiText($lines_count = null)
    {
        $cache = cache::factory('memcache');
        $cache_key = 'quote_geshi_' . $this->getId();
        if (!is_null($lines_count) && is_int($lines_count)) {
            $cache_key .= '_' . $lines_count;
        }
        
        $result = $cache->get($cache_key, $code);
        if (!$result) {
            $source = $this->getText($lines_count);
            $language = $this->getCategory()->getGeshiAlias();
            
            fileLoader::load('libs/geshi/geshi');
            $geshi = new GeSHi($source, $language);
            
            //если такой язык подсветки не найден, то принуждаем использовать простой текст
            if ($geshi->error() !== false) {
                $geshi->set_language('text');
            } else {
                $css = systemConfig::$pathToWebRoot . DIRECTORY_SEPARATOR . 'css' . DIRECTORY_SEPARATOR . 'langs' . DIRECTORY_SEPARATOR . $language . '.css';
                if (!file_exists($css)) {
                    @file_put_contents($css, $geshi->get_stylesheet(false));
                }
            }
        
            $geshi->set_comments_style(1, 'color: #666666;');
            $geshi->set_comments_style(2, 'color: #666666;');
            $geshi->set_comments_style(3, 'color: #0000cc;');
            $geshi->set_comments_style(4, 'color: #009933;');
            $geshi->set_comments_style('MULTI', 'color: #666666;');
        
            //$geshi->set_header_type(GESHI_HEADER_NONE);
            //$geshi->enable_line_numbers(GESHI_NORMAL_LINE_NUMBERS);
            $geshi->enable_classes();
            $code = $geshi->parse_code();
            
            $cache->set($cache_key, $code, array(), 86400);
        }
        
        return $code;
    }
}
?>