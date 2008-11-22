<?php
function smarty_modifier_highlite($source, $language = 'plain', Array $highlight = array(), $cacheKey = null)
{
    if ($cacheKey) {
        fileLoader::load('cache');
        $cache = cache::factory('file');
        if ($code = $cache->get($cacheKey)) {
            return $code;
        }
    }

    fileLoader::load('libs/geshi/geshi');
    switch ($language) {
        case 'plain':
            $geshi = new GeSHi($source, 'text');
            break;

        default:
            fileLoader::load('libs/geshi/geshi');
            $geshi = new GeSHi($source, $language);

            $geshi->set_comments_style(1, 'color: #666666;');
            $geshi->set_comments_style(2, 'color: #666666;');
            $geshi->set_comments_style(3, 'color: #0000cc;');
            $geshi->set_comments_style(4, 'color: #009933;');
            $geshi->set_comments_style('MULTI', 'color: #666666;');

            break;
    }

    if ($highlight) {
        $geshi->highlight_lines_extra($highlight);
    }

    $geshi->set_overall_style('width: 1024px; overflow-x: auto;', true);
    $code = $geshi->parse_code();

    if ($cacheKey && !DEBUG_MODE) {
        $cache->set($cacheKey, $code, 3600 * 24);
    }

    return $code;
}
?>