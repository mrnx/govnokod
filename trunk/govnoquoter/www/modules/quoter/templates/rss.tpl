<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
    <title>Govnokod.ru</title>
    <link>{if !$withCategory}{url route="rss"}{else}{url route="rssFull" name=$category->getName()}{/if}</link>
    <description><![CDATA[]]></description>
    <language>ru</language>
    <managingEditor>govno@govnokod.ru</managingEditor>
    <generator>{$smarty.const.MZZ_NAME} v.{$smarty.const.MZZ_VERSION}-{$smarty.const.MZZ_REVISION}</generator>
    <pubDate>Fri, 21 Nov 2008 16:36:39 GMT</pubDate>
    <lastBuildDate/>
    {*<image>
        <link>http://habrahabr.ru/</link>
        <url>http://habrahabr.ru/i/logo.gif</url>
        <title>Хабрахабр</title>
    </image>*}
    {foreach from=$quotes item="quote"}
    <item>
        <title>
            <![CDATA[{$quote->getCategory()->getTitle()|htmlspecialchars} / Говнокод#{$quote->getId()}]]>
        </title>
        <guid isPermaLink="true">{url route="quoteView" id=$quote->getId()}</guid>
        <link>{url route="quoteView" id=$quote->getId()}</link>
        <description>
            <![CDATA
                {$quote->getText(30)|highlite:$quote->getCategory()->getName()}
            ]]>
        </description>
        <pubDate>{$quote->getCreated()|date_format:"%a, %d %b %G %H:%M:%S GMT"}</pubDate>
        <author>gnomeby</author>
        <category>{$quote->getCategory()->getName()}</category>
    </item>
    {/foreach}
    </channel>
</rss>