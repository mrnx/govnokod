<?php
function smarty_modifier_highlite($source, $language = 'plain')
{
    switch ($language) {
        case 'plain':
            return '<pre>' . htmlspecialchars($source) . '</pre>';
            break;

        default:
            fileLoader::load('libs/geshi/geshi');
            $geshi = new GeSHi($source, $language);
            $geshi->enable_line_numbers(GESHI_FANCY_LINE_NUMBERS);
            $code = $geshi->parse_code();
            return $code;
            break;
    }
}
?>