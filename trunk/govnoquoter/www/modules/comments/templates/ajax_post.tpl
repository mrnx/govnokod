{assign var="commentsFolderId" value=$commentsFolder->getId()}
{if $hideForm}{assign var="formStyle" value="display: none;"}{else}{assign var="formStyle" value=""}{/if}
{form id="commentForm_$commentsFolderId" action=$action method="post" style=$formStyle onsubmit="postCommentsForm($('commentForm_$commentsFolderId')); return false;"}
    <dl>
        {if !$errors->isEmpty()}
        <dt>Ошибка компиляции комментария:</dt>
        <dd>
            <ul>
            {foreach from=$errors item="error"}
                <li>{$error}</li>
            {/foreach}
            </ul>
        </dd>
        {/if}
        <dt>{set name="formTextCaptionLabel"}Я, <strong>{$user->getLogin()|h}</strong>, находясь в здравом уме и твердой памяти, торжественно заявляю:{/set}{form->caption name="text" value=$formTextCaptionLabel}</dt>
        <dd>{form->textarea name="text" value=$comment->getText() rows="5" cols="5"}</dd>
    </dl>
    <p>
        {form->hidden name="backUrl" value=$backUrl}
        {form->hidden name="ajax" value=true}
        {form->submit class="send" name="commentSubmit" value="Отправить комментарий"}
    </p>
</form>