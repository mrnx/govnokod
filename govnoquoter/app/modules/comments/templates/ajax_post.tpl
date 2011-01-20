<?php echo $__form->open(array('id' => 'commentForm_' . $commentsFolder->getId(), 'action' => $action, 'method' => 'post', 'style' => $hideForm ? 'display: none' : '', 'onsubmit' => 'comments.postForm(this); return false;', 'onkeypress' => 'comments.handleCtrEnter(event, this);')); ?>
    <?php echo $this->render('comments/postForm.tpl'); ?>
</form>