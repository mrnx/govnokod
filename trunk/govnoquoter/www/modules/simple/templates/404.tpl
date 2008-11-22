{* main="main.tpl" placeholder="content" *}
{title append="404 Page not found!"}
<div style="clear:both"></div>
<div style="float:left">
    <div class="block">
        <div class="top">&nbsp;</div>
        <div class="content">
            <h1>404 Page not found!</h1>
            Вы запросили несуществующую страницу
        </div>
        <div class="bottom">&nbsp;</div>
    </div>
</div>

<div class="right-block">
    <div class="block">
        <div class="top">&nbsp;</div>
            <div class="content">
                Можно:
                <ul>
                    <li><a href="#" onclick="history.go(-1); return false;">вернуться назад</a></li>
                    <li><a href="{url route="default"}">на главную</a></li>
                    <li><a href="http://google.com/">в гугл</a></li>
                </ul>
            </div>
        <div class="bottom">&nbsp;</div>
    </div>
</div>