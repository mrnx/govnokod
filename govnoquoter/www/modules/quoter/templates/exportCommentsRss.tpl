<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
<channel>
    <title>Govnokod.ru — {if $exportAll}Все комментарии{else}Комментарии Говнокода#{$quote->getId()}{/if}</title>
    <link>{if $exportAll}{url route="rssAllComments"}{else}{url route="rssComments" id=$quote->getId()}{/if}</link>
    <description><![CDATA[Говнокод онлайн]]></description>
    <language>ru</language>
    <managingEditor>govnoed@govnokod.ru (GOVNOkodEDitor)</managingEditor>
    <generator>{$smarty.const.MZZ_NAME} v.{$smarty.const.MZZ_VERSION}-{$smarty.const.MZZ_REVISION}</generator>
    <pubDate>{"D, d M Y H:i:s"|date:$smarty.now} GMT</pubDate>
    <lastBuildDate>{"D, d M Y H:i:s"|date:$lastBuildDate} GMT</lastBuildDate>
    {assign var="curCommentNum" value=$comments|@count}
    {foreach from=$comments item="comment" name="commentsIterator"}
    <item>
        {if !$exportAll}
        <title>Говнокаммент#{$curCommentNum}</title>
        <guid isPermaLink="true">{url route="quoteView" id=$quote->getId()}#comment{$curCommentNum}</guid>
        <link>{url route="quoteView" id=$quote->getId()}#comment{$curCommentNum}</link>
        {assign var="curCommentNum" value=$curCommentNum-1}
        {else}
        <title>Говнокаммент#{$comment->getId()} для Говнокода#{$comment->fakeField('quote_id')}</title>
        <guid isPermaLink="true">{url route="quoteView" id=$comment->fakeField('quote_id')}#comment{$comment->getId()}</guid>
        <link>{url route="quoteView" id=$comment->fakeField('quote_id')}#comment{$comment->getId()}</link>
        {/if}
        <description>
            <![CDATA[
                {if $comment->getAuthor() == ''}<i>Говногость</i>{else}{$comment->getAuthor()|htmlspecialchars}{/if}:<br />
                {$comment->getText()|trim|htmlspecialchars|bbcode|nl2br}
            ]]>
        </description>
        <pubDate>{"D, d M Y H:i:s"|date:$comment->getTime()} GMT</pubDate>
        <author>{if $comment->getAuthor() == ''}Говногость{else}{$comment->getAuthor()|htmlspecialchars}{/if}</author>
        {if !$exportAll}<category>{$quote->getCategory()->getTitle()}</category>{/if}
    </item>
    {/foreach}
</channel>
</rss>