<ol class="posts hatom">
    <li class="hentry">
        {if !$commentReply}
        <h2>Добавление комментария для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {else}
        <h2>Ответ на <a href="{url route="quoteView" id=$commentsFolder->getParentId()}#comment{$commentReply->getId()}">комментарий</a> для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {/if}
        <div class="entry-comments">
            {form action=$action method="post"}
                {if !$errors->isEmpty()}
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
    </li>
</ol>