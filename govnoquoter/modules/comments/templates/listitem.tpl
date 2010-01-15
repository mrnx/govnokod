            <div class="entry-comment-wrapper{if $lastTimeRead|default:false && $comment->getCreated() > $lastTimeRead} new{/if}">
                <p class="entry-info">
                    <img class="avatar" src="{$comment->getUser()->getAvatarUrl(28)|h}" alt="ava" title="Аватар" />
                    <strong class="entry-author"><a href="{url route="withId" module="user" id=$comment->getUser()->getId() action=""}">{$comment->getUser()->getLogin()|h}</a></strong>
                    <abbr class="published" title="{"c"|date:$comment->getCreated()}">{$comment->getCreated()|date_i18n:'relative_hour'}</abbr>
                    <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$comment->getId()}" name="comment{$comment->getId()}" title="Ссылка на комментарий" class="comment-link">#</a> {$comment->getJip()}
                    <span class="comment-vote">
                        {include file="comments/rating.tpl" comment=$comment}
                    </span>
                </p>
                <div class="entry-comment">{$comment->getText()|h|nl2br|bbcode}</div>
                <a class="answer" href="{url route="withId" module="comments" action="post" id=$commentsFolder->getId()}?replyTo={$comment->getId()}" onclick="comments.moveForm({$comment->getId()}, {$commentsFolder->getId()}, this); return false;">Ответить</a>
            </div>