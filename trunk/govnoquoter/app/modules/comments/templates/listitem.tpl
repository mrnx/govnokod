            <div id="comment-<?php echo $comment->getId(); ?>" class="entry-comment-wrapper<?php if (isset($lastTimeRead) && $comment->getCreated() > $lastTimeRead) { ?> new<?php } ?>">
                <p class="entry-info">
                    <img class="avatar" src="<?php echo htmlspecialchars($comment->getUser()->getAvatarUrl(28)); ?>" alt="ava" title="Аватар" />
                    <strong class="entry-author"><a href="<?php echo htmlspecialchars($this->url('user-profile', array('login' => $comment->getUser()->getLogin()))); ?>/"><?php echo htmlspecialchars($comment->getUser()->getLogin()); ?></a></strong>
                    <abbr class="published" title="<?php echo date('c', $comment->getCreated()); ?>"><?php echo htmlspecialchars(i18n::date($comment->getCreated(), 'relative_hour')); ?></abbr>
                    <a href="<?php echo htmlspecialchars($commentsFolder->getDefaultBackUrl()); ?>#comment<?php echo $comment->getId(); ?>" name="comment<?php echo $comment->getId(); ?>" title="Ссылка на комментарий" class="comment-link">#</a>
                    <span class="comment-vote">
                        <?php //echo $this->render('comments/rating.tpl', array('comment' => $comment)); ?>
                    </span>
                </p>
                <div class="entry-comment<?php if ($comment->getRating() <= -5) { ?> entry-comment-hidden<?php } ?>"><?php if ($comment->getRating() <= -5) { ?><span class="hidden-text"><a href="<?php echo htmlspecialchars($commentsFolder->getDefaultBackUrl()); ?>#comment<?php echo $comment->getId(); ?>" class="ajax">показать все, что скрыто</a></span><?php } ?>
                <span class="comment-text"><?php echo $this->bbcode(nl2br(htmlspecialchars($comment->getText()))); ?></span></div>
                <a class="answer" href="<?php echo htmlspecialchars($this->url('withId', array('module' => 'comments', 'action' => 'post', 'id' => $commentsFolder->getId(), '_replyTo' => $comment->getId()))); ?>" onclick="comments.moveForm(<?php echo $comment->getId(); ?>, <?php echo $commentsFolder->getId(); ?>, this); return false;">Ответить</a>
                <?php if ($comment->canRun('edit')) { ?><a class="edit-comment-link" href="<?php echo htmlspecialchars($this->url('withId', array('module' => 'comments', 'action' => 'edit', 'id' => $comment->getId()))); ?>/">Редактировать</a><?php } ?>
            </div>