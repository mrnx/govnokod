{title append="Обычная форма входа"}
<ol class="posts">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>
        {form action=$form_action method="post"}
            {if $errors}
            <dl class="errors">
                <dt>Ошибка авторизации:</dt>
                <dd>
                    <ol>
                    {foreach from=$errors item="error"}
                        <li>{$error}</li>
                    {/foreach}
                    </ol>
                </dd>
            </dl>
            {/if}
            <dl>
                <dt>{form->caption name="login" value="Логин:"}</dt>
                <dd>{form->text name="login"}</dd>

                <dt>{form->caption name="password" value="Пароль:"}</dt>
                <dd>{form->password name="password"}</dd>
            </dl>
            <p>
                {form->hidden name="save" value="true"}
                {form->submit class="send" name="submit" value="Вхожу!"}
            </p>
        </form>
        <p>&nbsp;</p>
        <p><a href="{url route="default2" module="user" action="register"}">Регистрация</a> | Забыли пароль?</p>
    </li>
</ol>