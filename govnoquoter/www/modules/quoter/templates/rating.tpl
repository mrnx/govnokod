    Рейтинг:
    <a class="vote-against" rel="nofollow" href="{url route="rate" alias="govnokod" param=$quote->getId() vote="against"}" title="Минусну!" onclick="vote(this); return false;">&darr;</a>
    <strong{if $quote->getRating() < 0} class="bad"{/if}>{if $quote->getRating() > 0}+{/if}{$quote->getRating()}</strong>
    <a class="vote-on" rel="nofollow" href="{url route="rate" alias="govnokod" param=$quote->getId() vote="on"}" title="Плюсану!" onclick="vote(this); return false;">&uarr;</a>