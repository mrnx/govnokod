<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
        <title>Говнокод.ру{if $action == 'userrss'} — лента пользователя {$user->getLogin()|h}{/if}{if $withCategory} — {$category->getTitle()|h}{/if}</title>
        <link>{if !$withCategory}{url route="rss"}{else}{url route="rssFull" name=$category->getName()}{/if}</link>
        <description><![CDATA[Говнокод: по колено в коде]]></description>
        <language>ru</language>
        <managingEditor>govnoed@govnokod.ru</managingEditor>
        <generator>{$smarty.const.MZZ_NAME} v.100500-{$smarty.const.MZZ_REVISION}</generator>
        <pubDate>{"D, d M Y H:i:s O"|date:$smarty.now}</pubDate>
        <lastBuildDate></lastBuildDate>
        <image>
            <link>http://govnokod.ru/</link>
            <url>http://govnokod.ru/templates/images/brand.png</url>
            <title>Говнокод.ру</title>
        </image>
{foreach from=$quotes item="quote"}
        <item>
            <title>{$quote->getCategory()->getTitle()|h} / Говнокод #{$quote->getId()}</title>
            <guid isPermaLink="true">{url route="quoteView" id=$quote->getId()}</guid>
            <link>{url route="quoteView" id=$quote->getId()}</link>
            <description>
                <![CDATA[
                    {if $quote->getDescription() != ''}<p>{$quote->getDescription()|trim|h|bbcode|nl2br}</p>{/if}
                    {if $quote->isSpecial()}
                    {$quote->getText()}
                    {else}
                    <pre><code class="{$quote->getCategory()->getJsAlias()|h}">{$quote->getText()|h}</code></pre>
                    {/if}
                ]]>
            </description>
            <pubDate>{"D, d M Y H:i:s O"|date:$quote->getCreated()}</pubDate>
            <category>{$quote->getCategory()->getTitle()|h}</category>
            <author>{$quote->getUser()->getLogin()|h}</author>
        </item>
{/foreach}
    </channel>
</rss>