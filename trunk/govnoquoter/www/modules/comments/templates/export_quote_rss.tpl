<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0">
    <channel>
        <title>Говнокод.ру — Комментарии говнокода #{$commentsFolder->getParentId()}</title>
        <link>{url route="rssComments" id=$commentsFolder->getParentId()}</link>
        <description><![CDATA[Говнокод: по колено в коде]]></description>
        <language>ru</language>
        <managingEditor>govnoed@govnokod.ru</managingEditor>
        <generator>{$smarty.const.MZZ_NAME} v.{$smarty.const.MZZ_VERSION}-{$smarty.const.MZZ_REVISION}</generator>
        <pubDate>{"D, d M Y H:i:s"|date:$smarty.now} GMT</pubDate>
        <lastBuildDate></lastBuildDate>
        <image>
            <link>http://govnokod.ru/</link>
            <url>http://govnokod.ru/templates/images/brand.png</url>
            <title>Говнокод.ру</title>
        </image>
        {assign var="curCommentNum" value=1}
        {foreach from=$comments item="comment" name="commentsIterator"}
        <item>
            <title>Комментарий #{$curCommentNum}</title>
            <guid isPermaLink="true">{url route="quoteView" id=$commentsFolder->getParentId()}#comment{$comment->getId()}</guid>
            <link>{url route="quoteView" id=$commentsFolder->getParentId()}#comment{$comment->getId()}</link>
            {assign var="curCommentNum" value=$curCommentNum+1}
            <description>
                <![CDATA[
                    {$comment->getText()|trim|h|nl2br|bbcode}
                ]]>
            </description>
            <pubDate>{"D, d M Y H:i:s"|date:$comment->getCreated()} GMT</pubDate>
            <author>{$comment->getUser()->getLogin()|h}</author>
        </item>
        {/foreach}
    </channel>
</rss>