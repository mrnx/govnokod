<ol class="posts hatom">
    <li class="hentry">
        {if !$commentReply}
        <h2>Добавление комментария для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {else}
        <h2>Ответ на <a href="{url route="quoteView" id=$commentsFolder->getParentId()}#comment{$commentReply->getId()}">комментарий</a> для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {/if}
        <div class="entry-comments">
            {form action=$action method="post"}
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
                    {form->submit class="send" name="commentSubmit" value="Отправить комментарий"}
                </p>
            </form>
        </div>
    </li>
</ol>