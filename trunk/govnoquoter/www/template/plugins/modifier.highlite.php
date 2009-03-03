<?php
function smarty_modifier_highlite($source, $language = 'text', Array $highlight = array(), $cacheKey = null)
{
    if ($cacheKey) {
        fileLoader::load('cache');
        $cache = cache::factory('file');
        if ($code = $cache->get($cacheKey)) {
            return $code;
        }
    }

    fileLoader::load('libs/geshi/geshi');
    $geshi = new GeSHi($source, $language);

    //если такой язык подсветки не найден, то принуждаем использовать простой текст
    if ($geshi->error() !== false) {
        $geshi->set_language('text');
    }

    $geshi->set_comments_style(1, 'color: #666666;');
    $geshi->set_comments_style(2, 'color: #666666;');
    $geshi->set_comments_style(3, 'color: #0000cc;');
    $geshi->set_comments_style(4, 'color: #009933;');
    $geshi->set_comments_style('MULTI', 'color: #666666;');

    if ($highlight) {
        $geshi->highlight_lines_extra($highlight);
    }

    $css = systemConfig::$pathToApplication . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . 'css' . DIRECTORY_SEPARATOR . 'langs' . DIRECTORY_SEPARATOR . $language . '.css';
    if (!file_exists($css)) {
        file_put_contents($css, $geshi->get_stylesheet(false));
    }

    $geshi->enable_classes();
    $code = $geshi->parse_code();

    if ($cacheKey) {
        $cache->set($cacheKey, $code, 3600 * 24);
    }

    return $code;
}
?>