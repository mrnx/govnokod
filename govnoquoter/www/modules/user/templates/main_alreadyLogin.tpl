{add file="jquery.js"}
{add file="govnokod.js"}
<div id="userpane">
    <ul class="menu">
        <li><a id="expand-trigger" href="{url route="default2" module="user" action="login"}">Привет, {$user->getLogin()|h}!</a></li>
    </ul>

    <div class="pane-content">
        <ul>
            <li><a href="{url route="default2" module="user" action="login"}">Кабинка</a></li>
            <li><a href="{url route="withAnyParam" module="user" name="global" action="preferences"}">Настройки сайта</a></li>
            <li><a href="{url route="withAnyParam" module="user" name="personal" action="preferences"}">Личные настройки</a></li>
            <li>&nbsp;</li>
            <li>{set name="url}{url appendGet=true}{/set}<a href="{url route="default2" section="user" action="exit"}/?url={$url|urlencode}">Выйти</a></li>
        </ul>
    </div>
</div>