{* main="header.tpl" placeholder="content" *}
    <div class="header">
        <a href="#">
            <img src="{$SITE_PATH}/templates/des/logo.png" alt="Логотип портала Говнокод.Ру" title="Да, это говно" />
            Govnokod.ru
        </a>
    </div>
    <ul class="menu">
        <li><a href="#">Говнобин</a></li>
        <li class="active"><a href="#">Говнобаш</a></li>
        {*<li><a href="#">Говноблог</a></li>*}
    </ul>

    {$content}
    {*
    <div class="block">
        <div class="top">&nbsp;</div>
        <div class="content">
            <h1><a href="#">Пацанчики на пати!</a></h1>
            Вы все говно!
        </div>
        <div class="bottom"></div>
    </div>

    <div class="block">
        <div class="top">&nbsp;</div>
        <div class="content">
            <h1><a href="#">Пацанчики на пати!</a></h1>
            Вы все говно!
        </div>
        <div class="bottom"></div>
    </div>
    *}