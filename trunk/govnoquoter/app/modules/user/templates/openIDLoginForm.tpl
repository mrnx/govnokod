<?php
$this->title('Вход в говнокод тут');
?>
<ol class="posts">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>
        <?php echo $__form->open(array('action' => $form_action, 'method' => 'post')); ?>
<?php if (!$validator->isValid()) { ?>
            <dl class="errors">
                <dt>Ошибка авторизации:</dt>
                <dd>
                    <ol>
<?php foreach ($validator->getErrors() as $error) { ?>
                        <li><?php echo $error; ?></li>
<?php } ?>
                    </ol>
                </dd>
            </dl>
<?php } ?>
            <dl>
                <dt><?php echo $__form->caption(array('name' => 'openid_identifier', 'value' => 'OpenID:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'openid_identifier')); ?></dd>
            </dl>
            <p>
                <?php echo $__form->submit(array('name' => 'openid_submit', 'value' => 'Вхожу!', 'class' => 'send')); ?>
            </p>
        </form>
        <p>&nbsp;</p>
        <p><a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'whatisopenid'))); ?>">Что это?</a> | <a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'login'))); ?>">Обычная форма входа</a></p>
    </li>
</ol>