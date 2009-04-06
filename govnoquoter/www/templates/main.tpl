{* main="header.tpl" placeholder="content" *}
<div id="page">
    <div id="header">
        <h1><a rel="homepage" href="/">Говнокод: по колено в коде.</a></h1>

        <div id="userpane">
            <ul>
                <li><a href="#">Вход</a> |</li>
                <li><a href="#">Регистрация</a></li>
            </ul>
        </div>

        <ul id="navigation">
            <li><a href="#">Все</a></li>
            <li><a href="#">Лучшие</a></li>
            <li><a href="#">Поиск</a></li>
            <li class="add"><a href="#">Наговнокодить!</a></li>
        </ul>

        <p id="entrance">
            Нашли или выдавили из себя код, который нельзя назвать нормальным,
            на который без улыбки не взглянешь?
            Не торопитесь его удалять или рефакторить, &mdash; запостите его на
            говнокод.ру, посмеёмся вместе!
        </p>

        <ol id="language">
            <li><a href="#">Brainfuck</a> <span>(320)</span></li>
            <li><a href="#">PHP</a> <span>(20)</span></li>
            <li><a href="#">Java</a> <span>(11)</span></li>
            <li><a href="#">Ruby</a> <span>(10)</span></li>
            <li><a href="#">C#</a> <span>(8)</span></li>
            <li><a href="#">Assembler</a> <span>(5)</span></li>
            <li><a href="#">Perl</a> <span>(3)</span></li>
            <li><a href="#">C++</a> <span>(1)</span></li>
        </ol>
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

{*
<div class="header">
        <a href="/">
            <img src="{$SITE_PATH}/templates/images/logo.png" alt="Говнокод.Ру" title="Да, это говно!" />
            Govnokod.ru
        </a>
    </div>
    <div class="add-govno">
        <a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}" title="Наговнокодить!"><img src="{$SITE_PATH}/templates/images/icon-plus.png" alt="" /></a>
        <a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}" title="По просьбе трудящихся">Наговнокодить!</a>
    </div>
    <ul class="menu">
        <li class="active"><a href="{url route="default"}">Говнокод</a></li>
        <li><a href="http://bin.govnokod.ru/">Говнобин</a></li>
    </ul>
    <div style="clear:both"></div>
    <ul class="sub-menu">
        <li class="left">&nbsp;</li>
        <li><a href="{url route="best"}">Лучший</a></li>
        <li><a href="{url route="search"}">Поиск</a></li>
        <li class="right">&nbsp;</li>
    </ul>

    <div style="clear: both;"></div>

    {$content}

    <div class="footer">
        {if $smarty.const.DEBUG_MODE}{$timer->toString()}<br />{/if}
        © говнокод.ру
        <a href="http://ru.wikipedia.org/wiki/Мистер_Хэнки,_рождественская_какашка" title="Мистер Хэнки, рождественская какашка"><img src="{$SITE_PATH}/templates/images/mrHankey.png" alt="Мистер Хэнки" /></a>
    </div>
    *}