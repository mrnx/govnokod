<?php
$this->add('jquery.js');
$this->add('govnokod.js');
?>
<div id="userpane">
    <ul class="menu" style="background-image: url('<?php echo htmlspecialchars($user->getAvatarUrl(20)); ?>');">
        <li><a id="expand-trigger" href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'login'))); ?>">Привет, <?php echo htmlspecialchars($user->getLogin()); ?>!</a></li>
    </ul>

    <div class="pane-content">
        <ul>
            <li><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'login'))); ?>">Кабинка</a></li>
            <li><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'preferences'))); ?>">Настройки</a></li>
            <li>&nbsp;</li>
            <li><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'exit'))); ?>/?url=<?php echo rawurlencode($this->url(null, array(), true)); ?>">Выйти</a></li>
        </ul>
    </div>
</div>