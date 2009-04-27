    <h3>Комментарии <span class="count">({$comments->count()})</span></h3>
    <ul id="comments_{$commentsFolder->getId()}">
    {foreach from=$comments item="comment" name="commentsIteration"}
        {strip}{if !$smarty.foreach.commentsIteration.first}
            {if $comment->getTreeLevel() < $lastLevel}
                {math equation="x - y" x=$lastLevel y=$comment->getTreeLevel() assign="levelDown"}
                {"</li></ul>"|@str_repeat:$levelDown}</li>
            {elseif $lastLevel == $comment->getTreeLevel()}
                </li>
            {else}
                <ul>
            {/if}
        {/if}{/strip}
        <li class="hcomment">
            <p>
                <img src="{$SITE_PATH}/files/avatars/16.gif" alt="" />
                <strong class="entry-author">{$comment->getUser()->getLogin()|h}</strong>
                <a class="published" name="comment{$comment->getId()}" href="{url}#comment{$comment->getId()}" title="{$comment->getCreated()|date_i18n}">{$comment->getCreated()|date_i18n:'relative_hour'}</a>
                <span class="comment-vote">
                    <strong>0</strong>
                    <a class="comment-vote-on" href="#"> </a>
                    <a class="comment-vote-against" href="#"> </a>
                </span>
            </p>
            <div class="entry-comment">
                {$comment->getText()|h|nl2br}
            </div>
            <a class="answer" href="{url route="withId" section="comments" action="post" id=$commentsFolder->getId()}?replyTo={$comment->getId()}" onclick="moveCommentForm({$comment->getId()}, {$commentsFolder->getId()}, this); return false;">Ответить</a>
            <ul><li id="answerForm_{$commentsFolder->getId()}_{$comment->getId()}"></li></ul>
        {strip}{assign var="lastLevel" value=$comment->getTreeLevel()}
        {if $smarty.foreach.commentsIteration.last}
        </li>
            {math equation="x - y" x=$lastLevel y=1 assign="levelDown"}
            {"</li></ul>"|@str_repeat:$levelDown}
        {/if}{/strip}
    {foreachelse}
        <li></li>
    {/foreach}
    </ul>
    {if $comments->isEmpty()}{assign var="hideForm" value=false}{else}{assign var="hideForm" value=true}{/if}
    {load module="comments" section="comments" action="post" tplPrefix="list_" hideForm=$hideForm id=$commentsFolder onlyForm=true}