{add file="comment.css" join=false}
{assign var="commentsCount" value=0}
{if !empty($comments)}
<div class="rounded-box comment">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {assign var="commentsCount" value=$comments|@count}
        <h2><a name="comments"></a>Комментарии ({$comments|@count}):</h2>
    {foreach from=$comments item="comment" name="commentIterator"}
        <div class="item">
        	<h3>
        	   <span class="rate"><a name="comment{$comment->getId()}">&nbsp;</a><a href="{url}#comment{$smarty.foreach.commentIterator.iteration}" name="comment{$smarty.foreach.commentIterator.iteration}">#{$smarty.foreach.commentIterator.iteration}</a></span>
        	   {if $comment->getAuthor() == ''}<em>Говногость</em>{else}{$comment->getAuthor()|htmlspecialchars}{/if} <span class="commentDate">({$comment->getTime()|date_i18n:"relative_hour"})</span>{if $comment->getAcl('edit')}, ip: {$comment->getAuthorIp()|htmlspecialchars}{/if} {$comment->getJip()}
        	</h3>
            {$comment->getText()|trim|htmlspecialchars|nl2br|bbcode}
        </div>
    {/foreach}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/if}

{load module="comments" section="comments" action="post" parent_id=$parent_id}