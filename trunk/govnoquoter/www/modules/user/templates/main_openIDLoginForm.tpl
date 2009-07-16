<div id="userpane">
    <ul class="menu">
        <li><a href="{url route="openIDLogin"}" onclick="$('#userpane').toggleClass('expanded'); return false;">Войти в говнокод</a></li>
    </ul>

    {form action=$form_action method="post" class="pane-content"}
        <ul>
            <li>{form->text id="openid_url_small" name="openid_identifier" value=""}</li>
            <li>{form->submit name="openid_submit" value="Вхожу!"}</li>
        </ul>

        {*<p>что это за хрень?</p>*}
    </form>
</div>