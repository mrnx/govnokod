<ol class="posts hatom">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>
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
        {form action=$form_action method="post" id="userLogin"}
            <dl>
                <dt>{form->caption name="openidurl" value="OpenID:"}</dt>
                <dd>{form->text name="openidurl" value=$openIDUrl}</dd>
            </dl>
            <p>
                {form->submit class="send" name="openidsubmit" value="Вхожу!"}
            </p>
        </form>
    </li>
</ol>