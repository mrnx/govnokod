{$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getId()}
<br />
{if $quote->getDescription()}Описание:<br /> {$quote->getDescription()|htmlspecialchars|nl2br}{/if}
<br />Рейтинг: {$quote->getRating()}