{title append="Личная кабинка пользователя $user->getLogin()"}
<ol class="posts hatom">
    <li class="hentry">
        <h2>Личная кабинка пользователя <strong>{$user->getLogin()|h}</strong></h2>
        <p><img src="{$user->getAvatarUrl()}" alt="avatar" title="Аватар пользователя {$user->getLogin()|h}" /></p>
    </li>
</ol>