{add file="comment.css" join=false}
{if !empty($comments)}
<div class="rounded-box comment">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {assign var="commentsCount" value=$comments|@count}
        <h2>{if $quote|default:false && $quote->getCommentsCount() != $commentsCount}{$quote->setCommentsCountAndSave($commentsCount)}{/if}<a name="comments"></a>Комментарии ({$comments|@count}):</h2>
    {foreach from=$comments item="comment" name="commentIterator"}
        <div class="item">
        	<h3>
        	   <span class="rate"><a name="comment{$comment->getId()}"></a><a href="{url}#comment{$smarty.foreach.commentIterator.iteration}" name="comment{$smarty.foreach.commentIterator.iteration}">#{$smarty.foreach.commentIterator.iteration}</a></span>
        	   {$comment->getAuthor()|htmlspecialchars} <span class="commentDate">({$comment->getTime()|date_i18n:"relative_hour"})</span>{if $comment->getAcl('edit')}, ip: {$comment->getAuthorIp()|htmlspecialchars}{/if} {$comment->getJip()}
        	</h3>
            <p>{$comment->getText()|htmlspecialchars|nl2br}</p>
        </div>
    {/foreach}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/if}

{load module="comments" section="comments" action="post" parent_id=$parent_id}