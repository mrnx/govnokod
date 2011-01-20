        <li class="hcomment new">
            <?php echo $this->render('comments/listitem.tpl', array('commentsFolder' => $commentsFolder, 'comment' => $comment, 'lastTimeRead' => 1)); ?>
            <ul>
                <li id="answerForm_<?php echo $commentsFolder->getId() . '_' . $comment->getId(); ?>">
                    <?php echo $this->load('comments', 'post', array('tplPrefix' => 'ajax_', 'hideForm' => true, 'id' => $commentsFolder, 'onlyForm' => true)); ?>
                </li>
            </ul>
        </li>