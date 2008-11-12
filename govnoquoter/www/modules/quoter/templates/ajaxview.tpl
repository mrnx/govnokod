{$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getId()}
<br />
{if $quote->getDescription()}Описание:<br /> {$quote->getDescription()|htmlspecialchars|nl2br}{/if}
<br />Рейтинг: {$quote->getRating()}
<br />Комментариев: !!2!!
<br />Комментарий:<br />
<form action="{url route="withId" action="comment" id=$quote->getId()}" method="post" onsubmit="alert(this.serialize()); return false;">
<textarea name="commentText" cols="0" rows="5" style="width: 90%;"></textarea>
<br />
<input type="submit" value="Накласть" />
</form>