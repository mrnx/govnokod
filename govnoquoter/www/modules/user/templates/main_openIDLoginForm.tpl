<div id="userpane">

    <ul class="menu">
        <li><a href="{url route="default2" module="user" action="openIDLogin"}" onclick="$('#userpane').toggleClass('expanded'); return false;">Войти в говнокод</a></li>
    </ul>

    {form action=$form_action method="post"}
        <ul>
            <li>{form->text id="openid_url" name="openid"}</li>
            <li>{form->submit name="submit" value="вход"}</li>
        </ul>

        <p>что это за хрень?</p>
    </form>
</div>