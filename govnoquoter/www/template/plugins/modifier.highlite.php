<?php
function smarty_modifier_highlite($source, $language = 'plain', $sourceId = null)
{
    switch ($language) {
        case 'plain':
            return '<pre>' . htmlspecialchars($source) . '</pre>';
            break;

        default:
            fileLoader::load('cache');
            $cache = cache::factory('file');
            $cacheKey = $sourceId;
            if ($code = $cache->get($cacheKey)) {

            }

            fileLoader::load('libs/geshi/geshi');
            $geshi = new GeSHi($source, $language);
            $geshi->set_comments_style(1, 'color: #666666;');
            $geshi->set_comments_style(2, 'color: #666666;');
            $geshi->set_comments_style(3, 'color: #0000cc;');
            $geshi->set_comments_style(4, 'color: #009933;');
            $geshi->set_comments_style('MULTI', 'color: #666666;');

            //$geshi->highlight_lines_extra(array(1, 3));
            $code = $geshi->parse_code();

            return $code;
            break;
    }
}
?>