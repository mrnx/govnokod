<?php
$this->title('Моя личная кабинка');
?>
<ol class="posts">
    <li class="hentry">
        <h2>Моя личная кабинка</h2>
        <p><img src="<?php echo htmlspecialchars($user->getAvatarUrl()); ?>" alt="avatar" title="Аватар пользователя <?php echo htmlspecialchars($user->getLogin()); ?>" /></p>

        <dl>
            <dt>Предпочитаемые языки:</dt>
            <dd>
<?php
$preferredLangs = $user->getPreferredLangs();
if ($preferredLangs === false) {
?>
                <strong>Все</strong>
<?php
} else {

    $preferred_langs_count = sizeof($preferredLangs);
    $preferred_langs_iteration = 0;
    foreach ($preferredLangs as $category) {
        $preferred_langs_iteration++;
?>
                <a href="<?php echo htmlspecialchars($this->url('categoryList', array('name' => $category->getName()))); ?>"><?php echo htmlspecialchars($category->getTitle()); ?></a><?php if ($preferred_langs_iteration != $preferred_langs_count) echo ', '; ?>
<?php
    }
}
?>
            </dd>

            <dt>Подсветка кода:</dt>
            <dd><?php echo htmlspecialchars($user->getHighlightDriverTitle()); ?></dd>
        </dl>

        <ul>
            <li><a href="<?php echo htmlspecialchars($this->url('userCodes', array('id' => $user->getId()))); ?>/">Мои говнокоды (<?php echo htmlspecialchars($user->getQuotesCount()); ?>)</a></li>
            <li><a href="<?php echo htmlspecialchars($this->url('user-comments', array('id' => $user->getId()))); ?>/">Мои комментарии (0)</a></li>
            <li><a href="<?php echo htmlspecialchars($this->url('userCodesRss', array('id' => $user->getId()))); ?>/" title="Лента RSS, собранная на основе предпочитаемых языков">Моя RSS лента</a></li>
            <li><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'preferences'))); ?>/">Настройки</a></li>
            <li style="list-style: none;">&nbsp;</li>
            <li><a href="<?php echo htmlspecialchars($this->url('default2', array('module' => 'user', 'action' => 'exit'))); ?>/?url=<?php echo rawurlencode($this->url(null, array(), true)); ?>">Выйти</a></li>
        </ul>
    </li>
</ol>