<?php
$this->wrap('header.tpl', 'content');
$this->add('style.css');
?>
<div id="page">
    <div id="header">
        <h1><a rel="homepage" href="/">Говнокод: по колено в коде.</a></h1>

        <?php echo $this->load('user', 'openIDLogin', array('onlyForm' => true, 'tplPrefix' => 'main_')); ?>

        <ul id="navigation">
            <li><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/">Все</a></li>
            <li><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/paper/">Газетка</a></li>
            <li><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/best/">Лучший</a></li>
            <li><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/search/">Глупый поиск</a></li>
            <li class="add"><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/add/">Наговнокодить!</a></li>
        </ul>

        <p id="entrance">
            Нашли или выдавили из себя код, который нельзя назвать нормальным,
            на который без улыбки не взглянешь?
            Не торопитесь его удалять или рефакторить, &mdash; запостите его на
            говнокод.ру, посмеёмся вместе!
        </p>

        <?php echo $this->load('quoter', 'categories'); ?>
    </div>

    <div id="content">
        <?php echo $content; ?>
    </div>

    <div id="footer">
        <address>
            <span>&copy; 2008-2010 &laquo;Говнокод.ру&raquo; <?php if (DEBUG_MODE) echo $timer->toString(); ?></span>
            <span><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/page/feedback">Обратная связь</a> | Работает на <a href="http://mzz.ru" title="opensource php5 framework">mzz</a></span>
        </address>
    </div>
</div>
<?php
$this->wrap();
?>