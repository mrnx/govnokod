<ol class="posts">
    <li class="hentry">
        <h2>Вход в говнокод тут, part2.</h2>
        {form action=$form_action method="post" id="userLogin"}
            {if $errors|default:false}
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
                <dd>{form->text name="login" value=$regData.login}</dd>
            </dl>
            <dl>
                <dt>{form->caption name="email" value="E-mail:"}</dt>
                <dd>{form->text name="email" value=$regData.email}</dd>
            </dl>
            <p>
                {form->submit class="send" name="openidsubmit" value="Вхожу!"}
            </p>
        </form>
    </li>
</ol>