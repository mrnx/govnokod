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
                <dt>{form->caption name="openid_identifier" value="OpenID:"}</dt>
                <dd>{form->text id="openid_url" name="openid_identifier" value=$openIDUrl}</dd>
            </dl>
            <p>
                {form->submit class="send" name="openid_submit" value="Вхожу!"}
            </p>
        </form>
    </li>
</ol>