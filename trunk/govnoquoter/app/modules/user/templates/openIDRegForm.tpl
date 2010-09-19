<?php
$this->title('Вход в говнокод тут');
?>
<ol class="posts">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>

        <p>Если Вы видите этот экран, то это значит, что указанный OpenID идентификатор впервые используется для входа на Говнокод.ру. Для того, чтобы навсегда убрать его, заполните форму ниже:</p>

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
                <dt>Авторизуемся под:</dt>
                <dd><strong><?php echo htmlspecialchars($openIDUrl); ?></strong></dd>

                <dt><?php echo $__form->caption(array('name' => 'login', 'value' => 'Логин:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'login', 'value' => (isset($regData['nickname']) ? $regData['nickname'] : ''))); ?></dd>

                <dt><?php echo $__form->caption(array('name' => 'email', 'value' => 'E-mail:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'email', 'value' => (isset($regData['email']) ? $regData['email'] : ''))); ?></dd>
            </dl>
            <p>
                <?php echo $__form->submit(array('name' => 'openid_reg_cancel', 'value' => 'Отменить', 'nodefault' => true)); ?>
                <?php echo $__form->submit(array('name' => 'openid_reg_submit', 'value' => 'Подтвердить >>', 'class' => 'send')); ?>
            </p>
        </form>
    </li>
</ol>