{add file="jquery.js"}
<div id="userpane">
    <ul class="menu">
        <li><a href="{url route="default2" module="user" action="login"}" onclick="$('#userpane').toggleClass('expanded'); return false;">Привет, {$user->getLogin()|h}!</a></li>
    </ul>

    <div class="pane-content">
        <ul>
            <li><a href="{url route="default2" module="user" action="preferences"}">Настройки</a></li>
            <li>&nbsp;</li>
            <li>{set name="url}{url appendGet=true}{/set}<a href="{url route="default2" section="user" action="exit"}/?url={$url|urlencode}">Выйти</a></li>
        </ul>
    </div>
</div>