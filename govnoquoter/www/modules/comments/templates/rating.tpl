{if $comment->getCurrentUserRate()}
    <strong{if $comment->getRating() < 0} class="bad"{elseif $comment->getRating() > 0} class="good"{/if}>{if $comment->getRating() > 0}+{/if}{$comment->getRating()}</strong>
    {if $comment->getCurrentUserRate() == -1}<span class="comment-vote-against my-vote" title="Мой голос!"> </span>{else}<span class="comment-vote-against"> </span>{/if}
    {if $comment->getCurrentUserRate() == 1}<span class="comment-vote-on my-vote" title="Мой голос!"> </span>{else}<span class="comment-vote-on"> </span>{/if}
{else}
    <strong{if $comment->getRating() < 0} class="bad"{elseif $comment->getRating() > 0} class="good"{/if}>{if $comment->getRating() > 0}+{/if}{$comment->getRating()}</strong>
    <a rel="nofollow" class="comment-vote-against" href="{url route="rate" alias="comment" param=$comment->getId() vote="against"}" title="-1"> </a>
    <a rel="nofollow" class="comment-vote-on" href="{url route="rate" alias="comment" param=$comment->getId() vote="on"}" title="+1"> </a>
{/if}