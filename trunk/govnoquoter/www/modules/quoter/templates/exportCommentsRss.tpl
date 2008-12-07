<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
    <title>Govnokod.ru — {if $exportAll}Все комментарии{else}Комментарии Говнокода#{$quote->getId()}{/if}</title>
    <link>{if $exportAll}{else}{url route="rssComments" id=$quote->getId()}{/if}</link>
    <description><![CDATA[Говнокод онлайн]]></description>
    <language>ru</language>
    <managingEditor>govnoed@govnokod.ru (GOVNOkodEDitor)</managingEditor>
    <generator>{$smarty.const.MZZ_NAME} v.{$smarty.const.MZZ_VERSION}-{$smarty.const.MZZ_REVISION}</generator>
    <pubDate>{"D, d M Y H:i:s"|date:$smarty.now} GMT</pubDate>
    <lastBuildDate></lastBuildDate>
    {foreach from=$comments item="comment" name="commentsIterator"}
    <item>
        <title>Говнокаммент#{$smarty.foreach.commentsIterator.iteration}</title>
        {if !$exportAll}<guid isPermaLink="true">{url route="quoteView" id=$comment->getFolder()->getParentId()}#comment{$comment->getId()}</guid>
        <link>{url route="quoteView" id=$comment->getFolder()->getParentId()}#comment{$comment->getId()}</link>{/if}
        <description>
            <![CDATA[
                {if $comment->getAuthor() == ''}<i>Говногость</i>{else}{$comment->getAuthor()|htmlspecialchars}{/if}:<br />
                {$comment->getText()|trim|htmlspecialchars|bbcode|nl2br}
            ]]>
        </description>
        <pubDate>{"D, d M Y H:i:s"|date:$comment->getTime()} GMT</pubDate>
        {if !$exportAll}<category>{$quote->getCategory()->getTitle()}</category>{/if}
    </item>
    {/foreach}
</channel>
</rss>