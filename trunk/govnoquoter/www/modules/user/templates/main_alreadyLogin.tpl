{add file="jquery.js"}
<div id="userpane">
    <ul class="menu">
        <li><a href="{url route="default2" module="user" action="login"}" onclick="$('#userpane').toggleClass('expanded'); return false;">Привет, {$user->getLogin()|h}!</a></li>
    </ul>

    <div class="pane-content">
        {set name="url}{url appendGet=true}{/set}
        <a href="{url route="default2" section="user" action="exit"}/?url={$url|urlencode}">Выйти</a>
    </div>
    {*
    {form action=$form_action method="post"}
        <ul>
            <li>{form->text id="openid_url_small" name="openidurl" value=""}</li>
            <li>{form->submit name="openidsubmit" value="Вхожу!"}</li>
        </ul>
    </form>
    *}
</div>