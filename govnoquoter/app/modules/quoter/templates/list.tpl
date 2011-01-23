<?php
$this->add('jquery.js');
$this->add('jquery.scrollTo.js');
$this->add('govnokod.js');

$highlight_driver = $toolkit->getUser()->getHighlightDriver();

switch ($type) {
    case 'category':
        $this->title($list_category->getTitle());
        break;

    case 'paper':
        $this->title('Печатное издание');
        break;

    case 'user':
        $this->title('Говнокод пользователя');
        $this->title('Личная кабинка пользователя ' . $list_user->getLogin());
        break;

    case 'search':
        $this->title('Поиск говнокода');
        break;

    case 'best':
        $this->title('Лучший говнокод');
        break;

    default:
        $this->title('По колено в коде');
        break;
}

?>
<ol class="posts hatom">
<?php if ($type == 'paper' && $pager->getRealPage() == 1) { ?>
    <li class="hentry">
        <h2>Печатное издание Говнокод.ру</h2>
        <p>В данном разделе собраны <b>все</b> говнокоды, когда-либо опубликованные на сайте.</p>
    </li>
<?php } else if ($type == 'user') { ?>
    <li class="hentry">
        <h2><a href="<?php echo htmlspecialchars($this->url('user-profile', array('login' => $list_user->getLogin()))); ?>">Личная кабинка пользователя <strong><?php echo htmlspecialchars($list_user->getLogin()); ?></strong></a> → Список говнокодов</h2>
        <p>Всего: <?php echo $pager->getItemsCount(); ?></p>
    </li>
<?php } else if ($type == 'search') { ?>
    <li class="hentry">
        <h2>Поиск говнокода</h2>
        <p>Этот поиск практически ничего не может найти! Но вы всё-таки попытайтесь, вдруг повезет.</p>
        <form action="<?php echo htmlspecialchars($this->url('search')); ?>/" method="get">
            <dl>
                <dt><?php echo $__form->caption(array('name' => 'keyword', 'value' => 'Поисковая фраза:')); ?></dt>
                <dd><?php echo $__form->text(array('name' => 'keyword', 'maxlength' => 50)); ?></dd>

                <dt><?php echo $__form->caption(array('name' => 'language', 'value' => 'В языке')); ?></dt>
                <dd><?php echo $__form->select(array('name' => 'language', 'options' => $search_categories_select, 'emptyFirst' => 'Во всех')); ?></dd>
            </dl>
            <p>
                <input type="submit" class="send" value="Покопаться!"/>
            </p>
        </form>
<?php if (trim($keyword) != '' && $pager->getItemsCount() > 0): ?>
        <p>Найдено: <?php echo htmlspecialchars($pager->getItemsCount()); ?></p>
<?php endif; ?>
    </li>
<?php } else if ($type == 'best') { ?>
    <li class="hentry">
        <h2>Лучший говнокод за все время</h2>
    </li>
<?php
}

$quotes_count = $quotes->count();
if ($quotes_count) {
    $list_item_file = 'nohl';
    if ($highlight_driver == 'geshi') {
        $list_item_file = 'geshi';
    } else if ($highlight_driver == 'js') {
        $list_item_file = 'js';

        $this->add('jshighlight/highlight.pack.js');
        $this->add('jshighlight/govnokod.css');
    }
    foreach($quotes as $quote) {
        if ($quote->isSpecial()) {
            $list_item_file = 'special';
        }
?>
    <li class="hentry">
        <?php echo $this->render('quoter/items/' . $list_item_file . '.tpl', array('quote' => $quote, 'highlight_driver' => $highlight_driver)); ?>
        <div class="entry-comments">
            <span class="comments-icon<?php if ($toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0) { echo ' comments-new" title="Для вас есть новые комментарии!'; } ?>">&nbsp;</span><a href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/' . $quote->getCategory()->getName() . '/' . $quote->getId()); ?>#comments" class="entry-comments-load">Комментарии</a> <span class="entry-comments-count">(<?php echo $quote->getCommentsCount(); if ($toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0) { ?>, <span title="Новые комментарии" class="entry-comments-new">+<?php echo $quote->getNewCommentsCount(); ?></span><?php } ?>)</span>
        </div>
    </li>
<?php
    }
} else {
    if ($type == 'search') {
?>
    <li class="hentry">
        <h2>Пусто</h2>
    </li>
<?php
    } else {
?>
    <li class="hentry">
        <h2>Пусто</h2>
    </li>
<?php
    }
}
?>
</ol>

<?php
if ($pager->getPagesTotal() > 1) {
    echo $pager->toString();
}
?>