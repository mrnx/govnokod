<?php
$this->add('jquery.js');
$this->add('govnokod.js');
?>
<h3><a href="<?php echo htmlspecialchars($this->url('withId', array('module' => 'comments', 'action' => 'post', 'id' => $commentsFolder->getId()))); ?>" <?php if (!$hideForm) { ?>class="selected" <?php } ?> onclick="comments.moveForm(0, <?php echo $commentsFolder->getId(); ?>, this); return false;">Добавить комментарий</a></h3>
<div id="answerForm_<?php echo $commentsFolder->getId(); ?>_0">
    <?php echo $__form->open(array('id' => 'commentForm_' . $commentsFolder->getId(), 'action' => $action, 'method' => 'post', 'style' => $hideForm ? 'display: none' : '', 'onsubmit' => 'comments.postForm(this); return false;', 'onkeypress' => 'comments.handleCtrEnter(event, this);')); ?>
        <?php echo $this->render('comments/postForm.tpl'); ?>
    </form>
</div>