{literal}<script type="text/javascript">
    function vote(aElem) {
        new Ajax.Request(aElem.href, {
            method: 'get',
            onSuccess: function(transport) {
                aElem.parentNode.update('Голос принят');
            }
        });
    }
</script>{/literal}
{$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getId()}
<br />
{if $quote->getDescription()}Описание:<br /> {$quote->getDescription()|htmlspecialchars|nl2br}{/if}
<br />Рейтинг:
<span id="quote{$quote->getId()}_votemenu">
    <a href="{url route="withId" action="suxx" id=$quote->getId()}" onclick="vote(this); return false;">-</a>
    {$quote->getRating()}
    <a href="{url route="withId" action="cool" id=$quote->getId()}" onclick="vote(this); return false;">+</a>
</span>