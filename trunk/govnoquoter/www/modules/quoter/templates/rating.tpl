{if $quote->getCurrentUserRate()}
    {if $quote->getCurrentUserRate() == -1}<span class="vote-on my-vote" title="Мой голос">{else}<span class="vote-on">{/if}&darr;</a></span>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{/if}{$quote->getRating()}</strong>
    {if $quote->getCurrentUserRate() == 1}<span class="vote-against my-vote" title="Мой голос">{else}<span class="vote-against">{/if}&uarr;</a></span>
{else}
    <a class="vote-against" rel="nofollow" href="{url route="rate" alias="code" param=$quote->getId() vote="against"}" title="Минусну!">&darr;</a>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{/if}{$quote->getRating()}</strong>
    <a class="vote-on" rel="nofollow" href="{url route="rate" alias="code" param=$quote->getId() vote="on"}" title="Плюсану!">&uarr;</a>
{/if}