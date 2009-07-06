            <p>
                <img class="avatar" src="{$SITE_PATH}/files/avatars/16.gif" alt="" />
                <strong class="entry-author">{$comment->getUser()->getLogin()|h}</strong>
                <span class="published" title="{$comment->getCreated()|date_i18n}">{$comment->getCreated()|date_i18n:'relative_hour'}</span>
                <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$comment->getId()}" name="comment{$comment->getId()}" title="Ссылка на комментарий">#</a>
                <span class="comment-vote">
                    {include file="comments/rating.tpl" comment=$comment}
                </span>
            </p>
            <div class="entry-comment">
                {$comment->getText()|h|bbcode|nl2br}
            </div>
            <a class="answer" href="{url route="withId" section="comments" action="post" id=$commentsFolder->getId()}?replyTo={$comment->getId()}" onclick="comments.moveForm({$comment->getId()}, {$commentsFolder->getId()}, this); return false;">Ответить</a>