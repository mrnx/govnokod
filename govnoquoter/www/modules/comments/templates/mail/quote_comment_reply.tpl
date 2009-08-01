<p>Hello, {$you->getLogin()|h}!</p>
<p>Пользователь <a href="{url route="withId" module="user" action="" id=$him->getId()}">{$him->getLogin()|h}</a> ответил на Ваш комментарий к <a href="{url route="quoteView" id=$quote->getId()}">говнокоду #{$quote->getId()}</a>!</p>
<p>&nbsp;</p>
<p>Напомним, Вы <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$yourComment->getId()}">написали</a>:</p>
<p><em>{$yourComment->getText()|trim|h|nl2br|bbcode}</em></p>
<p>На что получили <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$answerComment->getId()}">ответ</a>:</p>
<p><em>{$answerComment->getText()|trim|h|nl2br|bbcode}</em></p>