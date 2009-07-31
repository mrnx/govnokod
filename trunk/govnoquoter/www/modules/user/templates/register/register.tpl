{title append="Регистрация пользователя"}
<ol class="posts">
    <li class="hentry">
        <h2>Регистрация пользователя</h2>

        {form action=$form_action method="post"}
            {if !$form->isValid()}
            <dl class="errors">
                <dt>Ошибка регистрации:</dt>
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
                <dt>{form->caption name="login" value="Логин:"}</dt>
                <dd>{form->text name="login"}</dd>

                <dt>{form->caption name="email" value="E-mail:"}</dt>
                <dd>{form->text name="email"}</dd>

                <dt>{form->caption name="password" value="Пароль:"}</dt>
                <dd>{form->password name="password"}</dd>

                <dt>{form->caption name="repassword" value="Повтор пароля:"}</dt>
                <dd>{form->password name="repassword"}</dd>

                <dt>{form->caption name="timezone" value="Часовой пояс:"}</dt>
                <dd>{form->select name="timezone" options=$timezones emptyFirst=true}</dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Зарегистрировать!"}
            </p>
        </form>
    </li>
</ol>