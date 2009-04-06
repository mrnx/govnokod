{add file="prototype.js"}
<div class="entry-comments">
    <h3>Комментарии <span class="count">({$comments->count()})</span></h3>
    {if !$comments->isEmpty()}
    <ul>
    {foreach from=$comments item="comment" name="commentsIteration"}
        {strip}{if !$smarty.foreach.commentsIteration.first}
            {if $comment->getTreeLevel() < $lastLevel}
                {math equation="x - y + 1" x=$lastLevel y=$comment->getTreeLevel() assign="levelDown"}
                {"</li></ul>"|@str_repeat:$levelDown}
                <ul>
            {elseif $lastLevel == $comment->getTreeLevel()}
                </li>
            {else}
                <ul>
            {/if}
        {/if}{/strip}
        <li class="hcomment">
            <p>
                <img src="http://s3.amazonaws.com/twitter_production/profile_images/121187671/Green_love_monster_bigger.png" alt="" />
                <strong class="entry-author">{$comment->getUser()->getLogin()|h}</strong>
                <a class="published" name="comment{$comment->getId()}" href="{url}#comment{$comment->getId()}">{$comment->getCreated()|date_format:"%e %b %Y, %H:%M"}</a>
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
            <ul>
                <li id="answerForm_{$commentsFolder->getId()}_{$comment->getId()}"></li>
            </ul>
        {assign var="lastLevel" value=$comment->getTreeLevel()}
    {/foreach}
    {math equation="x - y + 1" x=$lastLevel y=1 assign="levelDown"}
    {"</li></ul>"|@str_repeat:$levelDown}
    {load module="comments" section="comments" action="post" tplPrefix="list_" hideForm=true id=$commentsFolder onlyForm=true}
    {else}
    {load module="comments" section="comments" action="post" tplPrefix="list_" hideForm=false id=$commentsFolder onlyForm=true}
    {/if}
</div>