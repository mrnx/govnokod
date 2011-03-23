<?php
$this->title('Редактировать комментарий');
?>
<ol class="posts hatom">
    <li class="hentry">
        <h2>Редактирование комментария</h2>
        <div class="entry-comments">
            <?php echo $__form->open(array('action' => $form_action, 'method' => 'post')); ?>
<?php if (!$validator->isValid()): ?>
                <dl class="errors">
                    <dt>Ошибка редактирования комментария:</dt>
                    <dd>
                        <ol>
<?php foreach ($validator->getErrors() as $error): ?>
                            <li><?php echo $error; ?></li>
<?php endforeach; ?>
                        </ol>
                    </dd>
                </dl>
<?php endif; ?>
                <dl>
                    <dt><?php echo $formTitle; ?></dt>
                    <dd><?php echo $__form->textarea(array('name' => 'text', 'value' => $comment->getText(), 'rows' => 5, 'cols' => 5)); ?></dd>
                </dl>
                <p><?php echo $__form->submit(array('name' => 'commentSubmit', 'class' => 'send', 'value' => 'Отредактировать комментарий')); ?></p>
            </form>
        </div>
    </li>
</ol>