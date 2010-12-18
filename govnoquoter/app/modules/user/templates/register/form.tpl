<?php
    $this->title('Регистрация нового пользователя');
?>

<ol class="posts">
    <li class="hentry">
        <h2>Регистрация нового пользователя</h2>

        <?php echo $__form->open(array('action' => $form_action, 'method' => 'post')); ?>
<?php if (!$validator->isValid()): ?>
            <dl class="errors">
                <dt>Ошибка регистрации:</dt>
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
                <dt><?php echo $__form->caption(array('name' => 'login', 'value' => 'Логин:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'login')); ?></dd>
<?php /*
                <dt>{form->caption name="email" value="E-mail:"}</dt>
                <dd>{form->text name="email"}</dd>
*/ ?>
                <dt><?php echo $__form->caption(array('name' => 'password', 'value' => 'Пароль:')); ?></dt>
                <dd><?php echo $__form->password(array('name' => 'password')); ?></dd>

                <dt><?php echo $__form->caption(array('name' => 'repassword', 'value' => 'Пароль еще раз:')); ?></dt>
                <dd><?php echo $__form->password(array('name' => 'repassword')); ?></dd>

                <dt><?php echo $__form->caption(array('name' => 'captcha', 'value' => 'Проверочный код:')); ?></dt>
                <dd><?php echo $__form->captcha(array('name' => 'captcha')); ?></dd>
            </dl>
            <p>
                <?php echo $__form->submit(array('name' => 'register', 'value' => 'Зарегистрироваться!', 'class' => 'send')); ?>
            </p>
        </form>
    </li>
</ol>