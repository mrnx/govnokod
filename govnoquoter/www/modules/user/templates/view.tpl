{title append="Личная кабинка пользователя `$viewuser->getLogin()`"}
<ol class="posts">
    <li class="hentry">
        <h2>Личная кабинка пользователя <strong>{$viewuser->getLogin()|h}</strong></h2>
        <p><img src="{$viewuser->getAvatarUrl()|h}" alt="avatar" title="Аватар пользователя {$viewuser->getLogin()|h}" /></p>
    </li>
</ol>