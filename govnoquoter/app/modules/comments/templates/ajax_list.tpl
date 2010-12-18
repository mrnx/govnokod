    <h3>Комментарии <span class="enrty-comments-count">(<?php echo $commentsFolder->getCommentsCount(); ?>)</span> <span class="rss"><a href="<?php echo htmlspecialchars($this->url('withId', array('module' => 'comments', 'action' => 'rss', 'id' => $commentsFolder->getId()))); ?>/" rel="alternative">RSS</a></span></h3>
    <ul id="comments_<?php echo $commentsFolder->getId(); ?>">
<?php
$comments_count = $comments->count();
if ($comments_count > 0) {
    $hide_form = true;
    $comments_iteration = 0;
    foreach ($comments as $comment):
        $comments_iteration++;

        $comment_tree_level = $comment->getTreeLevel();
        if ($comments_iteration != 1):
            if ($comment_tree_level < $last_level):
                $level_down = $last_level - $comment_tree_level;
                echo str_repeat('</li></ul>', $level_down) . '</li>';
            elseif ($comment_tree_level == $last_level):
                echo '</li>';
            else:
                echo '<ul>';
            endif;
        endif;
?>
        <li class="hcomment">
            <?php echo $this->render('comments/listitem.tpl', array('commentsFolder' => $commentsFolder, 'comment' => $comment)); ?>

            <ul><li id="answerForm_<?php echo $commentsFolder->getId(); ?>_<?php echo $comment->getId(); ?>"></li></ul>
<?php
        $last_level = $comment_tree_level;
        if ($comments_iteration == $comments_count):
            $level_down = $last_level - 1;
            echo '</li>' . str_repeat('</li></ul>', $level_down);
        endif;
    endforeach;
} else {
    $hide_form = false;
    echo '<li></li>';
}
?>
    </ul>

    <?php echo $this->load('comments', 'post', array('tplPrefix' => 'list_', 'hideForm' => $hide_form, 'id' => $commentsFolder, 'onlyForm' => true)); ?>