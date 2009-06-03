{assign var="commentsFolderId" value=$commentsFolder->getId()}
{add file="jquery.js"}{add file="jquery.scrollTo.js"}{add file="govnokod.js"}
<h3><a href="{url route="withId" section="comments" action="post" id=$commentsFolderId}"{if !$hideForm}class="selected" {/if} onclick="moveCommentForm(0, {$commentsFolderId}, this); return false;">Добавить комментарий</a></h3>
<div id="answerForm_{$commentsFolderId}_0">
{if $hideForm}{assign var="formStyle" value="display: none;"}{else}{assign var="formStyle" value=""}{/if}
{form id="commentForm_$commentsFolderId" action=$action method="post" style=$formStyle onsubmit="postCommentsForm($('commentForm_$commentsFolderId')); return false;"}
    {if !$errors->isEmpty()}
    <dl class="errors">
        <dt>Ошибка компиляции комментария:</dt>
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
        <dt>{set name="formTextCaptionLabel"}Я, <strong>{$user->getLogin()|h}</strong>, находясь в здравом уме и твердой памяти, торжественно заявляю:{/set}{form->caption name="text" value=$formTextCaptionLabel onError=""}</dt>
        <dd>{form->textarea name="text" value=$comment->getText() rows="5" cols="5"}</dd>
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
</form>
</div>