<ol class="posts hatom">
{foreach from=$quotes item="quote"}
    <li class="hentry">
        <h2>Комментарий к <a rel="bookmark" class="entry-title" href="{url route="quoteView" id=$quote->getId()}">говнокоду #{$quote->getId()}</a></h2>
        <div class="entry-comments">
            <ul>
                <li class="hcomment">
                    {assign var="comment" value=$quote->getLastComment()}
                    {assign var="commentsFolder" value=$comment->getFolder()}
                    <div class="entry-comment-wrapper">
                        <p class="entry-info">
                            <img class="avatar" src="{$comment->getUser()->getAvatarUrl(28)|h}" alt="ava" title="Аватар" />
                            <strong class="entry-author"><a href="{url route="withId" module="user" id=$comment->getUser()->getId() action=""}">{$comment->getUser()->getLogin()|h}</a></strong>
                            <abbr class="published" title="{"c"|date:$comment->getCreated()}">{$comment->getCreated()|date_i18n:'relative_hour'}</abbr>
                            <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$comment->getId()}" name="comment{$comment->getId()}" title="Ссылка на комментарий" class="comment-link">#</a>
                        </p>
                        <div class="entry-comment">{$comment->getText()|h|nl2br|bbcode}</div>
                        <a class="answer" href="{url route="withId" module="comments" action="post" id=$commentsFolder->getId()}?replyTo={$comment->getId()}">Ответить</a>
                    </div>
                </li>
            </ul>
        </div>
    </li>
{/foreach}
</ol>