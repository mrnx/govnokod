{assign var="commentsFolderId" value=$commentsFolder->getId()}
{add file="prototype.js"}{add file="effects.js"}{add file="govnokod.js"}
<h3><a href="{url route="withId" section="comments" action="post" id=$commentsFolderId}"{if !$hideForm}class="selected" {/if} onclick="moveCommentForm(0, {$commentsFolderId}, this); return false;">Добавить комментарий</a></h3>
<div id="answerForm_{$commentsFolderId}_0">
{if $hideForm}{assign var="formStyle" value="display: none;"}{else}{assign var="formStyle" value=""}{/if}
{form id="commentForm_$commentsFolderId" action=$action method="post" style=$formStyle onsubmit="postCommentsForm($('commentForm_$commentsFolderId')); return false;"}
    <dl class="errors">
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
        {form->submit class="send" name="commentSubmit" value="Отправить комментарий"}
    </p>
</form>
</div>