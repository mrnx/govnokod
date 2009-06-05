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
        <dt>{set name="formTextCaptionLabel"}Я, <strong>{$user->getLogin()|h}</strong>, находясь в здравом уме и твердой памяти, торжественно заявляю:{/set}{form->caption name="text" value=$formTextCaptionLabel onError=""}</dt>
        <dd>{form->textarea name="text" value=$comment->getText() rows="5" cols="5" useDefault=$onlyForm}</dd>
    </dl>
    {if !$user->isLoggedIn()}
    <dl>
        <dt>{form->caption name="captcha" value="Проверочный код:" onError=""}</dt>
        <dd>{form->captcha name="captcha"}</dd>
    </dl>
    {/if}
    <p>
        {form->hidden name="backUrl" value=$backUrl}
        {form->submit class="send" name="commentSubmit" value="Отправить комментарий"}
    </p>