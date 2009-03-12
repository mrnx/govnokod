{add file="comment.css" join=false}
{assign var="commentsCount" value=0}

<div class="rounded-box comment">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {assign var="commentsCount" value=$comments|@count}
        <h2><a name="comments"></a>Комментарии ({$comments|@count}): <a href="{url route="rssComments" id=$quote->getId()}" title="Подписка на комментарии"><img src="{$SITE_PATH}/templates/images/rss.jpg" alt="RSS 2.0" /></a></h2>
    {foreach from=$comments item="comment" name="commentIterator"}
        <div class="item">
        	<h3>
        	   <span class="rate commentrate">
        	       <a href="{url route="commentVote" action="cool" id=$comment->getId()}?token={$comment->getVoteToken()}" onclick="ajaxvote(this); return false;" title="поддерживаю!">+</a>
        	       <span class="{if $comment->getRating() > 0}rate_plus{elseif $comment->getRating() < 0}rate_minus{/if}">{$comment->getRating()}</span>
        	       <a href="{url route="commentVote" action="suxx" id=$comment->getId()}?token={$comment->getVoteToken()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a>
        	   </span>
        	   <a name="comment{$comment->getId()}"></a><a href="{url}#comment{$smarty.foreach.commentIterator.iteration}" name="comment{$smarty.foreach.commentIterator.iteration}">#{$smarty.foreach.commentIterator.iteration}</a>
        	   {if $comment->getAuthor() == ''}<em>Говногость</em>{else}{$comment->getAuthor()|htmlspecialchars}{/if}
        	   <span class="commentDate">({$comment->getTime()|date_i18n:"relative_hour"}){if $comment->getAcl('edit')}, ip: {$comment->getAuthorIp()|htmlspecialchars}{/if}</span> {$comment->getJip()}
        	</h3>
            <div class="commentText">{$comment->getText()|trim|htmlspecialchars|bbcode|nl2br}</div>
        </div>
    {foreachelse}
        <p>Комментариев еще нет</p>
    {/foreach}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{load module="comments" section="comments" action="post" parent_id=$parent_id}