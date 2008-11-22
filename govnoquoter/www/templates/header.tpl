<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Govnokod.ru {title separator=" — " start=" — "}</title>
    <link rel="stylesheet" type="text/css" href="{$SITE_PATH}/templates/css/style.css" />
    {*if $listAll|default:true}
    <link title="rss govnokod.ru" type="application/rss+xml" rel="alternate" href="{url route="rss"}"/>
    {else}
    <link title="rss govnokod.ru" type="application/rss+xml" rel="alternate" href="{url route="rssFull" name=$category->getName()}"/>
    {/if*}
    {include file='include.css.tpl'}
    <script type="text/javascript">
    <!--
    var SITE_PATH = '{$SITE_PATH}';
    //-->
    </script>
    {include file='include.external.js.tpl'}
</head>
<body>
{$content}
</body>
</html>