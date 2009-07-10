{* main="header.tpl" placeholder="content" *}
<div id="page">
    <div id="header">
        <h1><a rel="homepage" href="/">Говнокод: по колено в коде.</a></h1>

        <div id="userpane">
            <ul class="menu">
                <li><a href="#">Войти в говнокод</a></li>
                {*<li><a href="#">Регистрация</a></li>*}
            </ul>

            <ul>
                <li>{form->text id="openid_url" name="openid"}</li>
            </ul>
        </div>

        <ul id="navigation">
            <li><a href="/">Все</a></li>
            <li><a href="{url route="best"}">Лучший</a></li>
            <li><a href="#">Поиск</a></li>
            <li class="add"><a href="#">Наговнокодить!</a></li>
        </ul>

        <p id="entrance">
            Нашли или выдавили из себя код, который нельзя назвать нормальным,
            на который без улыбки не взглянешь?
            Не торопитесь его удалять или рефакторить, &mdash; запостите его на
            говнокод.ру, посмеёмся вместе!
        </p>

        {load module="quoter" action="listCategories"}
    </div>

    <div id="content">
        {$content}
    </div>

    <div id="footer">
        <address>
            <span>&copy; 2008-2009 &laquo;Говнокод.ру&raquo; {$timer->toString()}</span>
            <span><a href="#">Обратная связь</a></span>
        </address>
    </div>
</div>