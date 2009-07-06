    {if $errors->export()}
    <dl class="errors">
        <dt>Ошибка компиляции комментария:</dt>
        <dd>
            <ol>
            {foreach from=$errors->export() item="error"}
                <li>{$error}</li>
            {/foreach}
            </ol>
        </dd>
    </dl>
    {/if}
    <dl>
        <dt>Я, <strong>{$user->getLogin()|h}</strong>, находясь в здравом уме и твердой памяти, торжественно заявляю:</dt>
        <dd>{form->textarea name="text" value=$comment->getText() rows="5" cols="5" useDefault=$onlyForm}</dd>
    {if !$user->isLoggedIn()}
        <dt>{form->caption name="captcha" value="Проверочный код:" onError=""}</dt>
        <dd>{form->captcha name="captcha"}</dd>
    {/if}
    </dl>

    <p>
        {form->hidden name="backUrl" value=$backUrl}
        {form->submit class="send" name="commentSubmit" value="Отправить комментарий"}
    </p>