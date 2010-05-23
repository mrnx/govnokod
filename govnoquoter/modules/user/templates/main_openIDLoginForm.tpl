<?php
if (!$isValidated) {
    $this->add('jquery.js');
    $this->add('govnokod.js');
?>
<div id="userpane">
    <ul class="menu">
        <li><a id="expand-trigger" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/user/openid/login'); ?>">Войти в говнокод</a></li>
    </ul>
    
    <?php echo $__form->open(array('action' => $form_action, 'method' => 'post', 'class' => 'pane-content')); ?>
        <ul>
            <li><?php echo $__form->text(array('id' => 'openid_identifier_small', 'name' => 'openid_identifier', 'value' => '')); ?></li>
            <li class="submit-holder"><?php echo $__form->hidden(array('name' => 'url', 'value' => $this->url(null, array(), true))); echo $__form->submit(array('id' => 'openid_submit_small', 'name' => 'openid_submit', 'value' => 'Вхожу!', 'nodefault' => true)); ?></li>
        </ul>

        <p><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/page/whatisopenid'); ?>">Что это?</a> | <a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/user/login'); ?>">Обычная форма входа</a></p>
    </form>
</div>
<?php } else { ?>
<div id="userpane">
    <ul class="menu">
        <li><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/user/openid/login'); ?>"><?php if ($this->toolkit->getRequestedModule() == 'user' && $this->toolkit->getRequestedAction() == 'openIDLogin') { ?>Войти в говнокод<?php } else { ?>Заполни данные, %username%!<?php } ?></a></li>
    </ul>
</div>
<?php } ?>