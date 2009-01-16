<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
    <title>Govnokod.ru{if $withCategory} — {$category->getTitle()|htmlspecialchars}{/if}</title>
    <link>{if !$withCategory}{url route="rss"}{else}{url route="rssFull" name=$category->getName()}{/if}</link>
    <description><![CDATA[Говнокод онлайн]]></description>
    <language>ru</language>
    <managingEditor>govnoed@govnokod.ru (GOVNOkodEDitor)</managingEditor>
    <generator>{$smarty.const.MZZ_NAME} v.{$smarty.const.MZZ_VERSION}-{$smarty.const.MZZ_REVISION}</generator>
    <pubDate>{"D, d M Y H:i:s"|date:$smarty.now} GMT</pubDate>
    <lastBuildDate></lastBuildDate>
    {*<image>
        <link>http://govnokod.ru/</link>
        <url>http://govnokod.ru/logo.gif</url>
        <title>Govnokod.ru</title>
    </image>*}
    {foreach from=$quotes item="quote"}
    <item>
        <title>{$quote->getCategory()->getTitle()|htmlspecialchars} / Говнокод#{$quote->getId()}</title>
        <guid isPermaLink="true">{url route="quoteView" id=$quote->getId()}</guid>
        <link>{url route="quoteView" id=$quote->getId()}</link>
        <description>
            <![CDATA[
                {if $quote->getDescription() != ''}{$quote->getDescription()|trim|htmlspecialchars|bbcode|nl2br}<br /><br />{/if}
                {$quote->getText()|highlite:'text'}
            ]]>
        </description>
        <pubDate>{"D, d M Y H:i:s"|date:$quote->getCreated()} GMT</pubDate>
        <category>{$quote->getCategory()->getTitle()}</category>
    </item>
    {/foreach}
</channel>
</rss>