{* main="service/mail/main.tpl" placeholder="content" *}
Hello, <em>{$quoteUser->getLogin()|h}</em>!<br />
<br />
Между прочим, у Вашего <a href="{url route="quoteView" id=$quote->getId()}" title="Перейти к просмотру говнокода">говнокода #{$quote->getId()}</a>
появился <a href="{url route="quoteView" id=$quote->getId()}#comment{$comment->getId()}" title="Перейти к чтению комментария">новый комментарий</a>!