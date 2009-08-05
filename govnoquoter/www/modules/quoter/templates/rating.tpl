{$quote->getCurrentUserRate()|@var_dump}
{if $current_user->isLoggedIn()}
{if $quote->getCurrentUserRate()}
    {if $quote->getCurrentUserRate() == -1}<span class="vote-on my-vote" title="Мой голос">{else}<span class="vote-on">{/if}&darr;</span>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{elseif $quote->getRating() < 0}&minus;{/if}{$quote->getRating()|@abs}</strong>
    {if $quote->getCurrentUserRate() == 1}<span class="vote-against my-vote" title="Мой голос">{else}<span class="vote-against">{/if}&uarr;</span>
{else}
    <a class="vote-against" rel="nofollow" href="{url route="rateForCode" id=$quote->getId() vote="against"}" title="Минусну!">&darr;</a>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{elseif $quote->getRating() < 0}&minus;{/if}{$quote->getRating()|@abs}</strong>
    <a class="vote-on" rel="nofollow" href="{url route="rateForCode" id=$quote->getId() vote="on"}" title="Плюсану!">&uarr;</a>
{/if}
{else}
    <span class="vote-on" title="Гости не могут голосовать, пожалуйста, авторизуйтесь">&darr;</span>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{elseif $quote->getRating() < 0}&minus;{/if}{$quote->getRating()|@abs}</strong>
    <span class="vote-against" title="Гости не могут голосовать, пожалуйста, авторизуйтесь">&uarr;</span>
{/if}