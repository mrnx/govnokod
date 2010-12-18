<?php
    $this->title('Личная кабинка пользователя ' . $viewuser->getLogin());
?>
<ol class="posts">
    <li class="hentry">
        <h2>Личная кабинка пользователя <strong><?php echo htmlspecialchars($viewuser->getLogin()); ?></strong></h2>
        <p><img src="<?php echo htmlspecialchars($viewuser->getAvatarUrl()); ?>" alt="avatar" title="Аватар пользователя <?php echo htmlspecialchars($viewuser->getLogin()); ?>" /></p>

        <dl>
            <dt>Предпочитаемые языки:</dt>
            <dd>
<?php if ($viewuser->getPreferredLangs() === false): ?>
                <strong>Все</strong
<?php
    else:
        $preferredCategories = $viewuser->getPreferredLangsCategories();
        $preferred_categories_count = $preferredCategories->count();
        $preferred_categories_iteration = $preferredCategories->count();
        foreach ($viewuser->getPreferredLangsCategories() as $category):
            $preferred_categories_iteration++;
?>
                <a href="<?php echo htmlspecialchars($this->url('quoter-category-list', array('name' => $category->getName()))); ?>"><?php echo htmlspecialchars($category->getTitle()); ?></a><?php if ($preferred_categories_iteration != $preferred_categories_count) echo ', '; ?>
<?php
        endforeach;
    endif;
?>
            </dd>

            <dt>Подсветка кода:</dt>
            <dd><?php echo htmlspecialchars($viewuser->getHighlightDriverTitle()); ?></dd>
        </dl>

        <ul>
            <li><a href="<?php echo htmlspecialchars($this->url('user-quotes', array('login' => $viewuser->getLogin()))); ?>/">Мои говнокоды (<?php echo $viewuser->getQuotesCount(); ?>)</a></li>
        </ul>
    </li>
</ol>