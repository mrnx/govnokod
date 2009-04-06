        <li class="hcomment new">
            <p>
                <img src="http://s3.amazonaws.com/twitter_production/profile_images/121187671/Green_love_monster_bigger.png" alt="" />
                <strong class="entry-author">{$comment->getUser()->getLogin()|h}</strong>
                <a class="published" name="comment{$comment->getId()}" href="{url}#comment{$comment->getId()}">{$comment->getCreated()|date_format:"%e %b %Y, %H:%M"}</a>
                <span class="comment-vote">
                    <strong>0</strong>
                    <a class="comment-vote-on" href="#"> </a>
                    <a class="comment-vote-against" href="#"> </a>
                </span>
            </p>
            <div class="entry-comment">
                {$comment->getText()|h|nl2br}
            </div>
            <a class="answer" href="{url route="withId" section="comments" action="post" id=$commentsFolder->getId()}?replyTo={$comment->getId()}" onclick="moveCommentForm({$comment->getId()}, {$commentsFolder->getId()}, this); return false;">Ответить</a>
            <ul>
                <li id="answerForm_{$commentsFolder->getId()}_{$comment->getId()}">
                    {load module="comments" section="comments" action="post" tplPrefix="ajax_" hideForm=true id=$commentsFolder onlyForm=true}
                </li>
            </ul>
        </li>