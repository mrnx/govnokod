<?php
$this->title('Обычная форма входа');
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
                <dt><?php echo $__form->caption(array('name' => 'login', 'value' => 'Логин или email:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'login')); ?></dd>
            </dl>
            <dl>
                <dt><?php echo $__form->caption(array('name' => 'password', 'value' => 'Пароль:')); ?></dt>
                <dd><?php echo $__form->password(array('name' => 'password')); ?></dd>
            </dl>
            <p>
                <?php echo $__form->submit(array('name' => 'submit', 'value' => 'Вхожу!', 'class' => 'send')); ?>
            </p>
        </form>
        <p>&nbsp;</p>
        <p><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'register'))); ?>">Регистрация</a> | <a href="<?php echo htmlspecialchars($this->url('user-recover-pass')); ?>">Забыли пароль?</a> | <a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'injustice'))); ?>">Не пришло письмо подтверждения регистрации?</a> | <a href="<?php echo htmlspecialchars($this->url('openIDLogin')); ?>">Вход через OpenID</a></p>
    </li>
</ol>