{title append="Вход в говнокод тут"}
<ol class="posts">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>

        <p>Если Вы видите этот экран, то это значит, что указанный openID идентификатор впервые используется для входа на Говнокод.ру. Для того, чтобы навсегда убрать его, заполните форму ниже:</p>

        {form action=$form_action method="post"}
            {if !$form->isValid()}
            <dl class="errors">
                <dt>Ошибка авторизации:</dt>
                <dd>
                    <ol>
                    {foreach from=$form->export() item="error"}
                        <li>{$error}</li>
                    {/foreach}
                    </ol>
                </dd>
            </dl>
            {/if}

            <dl>
                <dt>Авторизуемся под:</dt>
                <dd><strong>{$openIDUrl|h}</strong></dd>

                <dt>{form->caption name="login" value="Логин:"}</dt>
                <dd>{form->text name="login" value=$regData.login}</dd>

                <dt>{form->caption name="email" value="E-mail:"}</dt>
                <dd>{form->text name="email" value=$regData.email}</dd>

                <dt>{form->caption name="timezone" value="Часовой пояс:"}</dt>
                <dd>{form->select name="timezone" options=$timezones emptyFirst=true}</dd>
            </dl>
            <p>
                {form->submit class="send" name="openid_reg_cancel" value="Отменить" nodefault=true}
                {form->submit class="send" name="openid_reg_submit" value="Подтверждаю >>"}
            </p>
        </form>
    </li>
</ol>