<ol class="posts hatom">
    <li class="hentry">
        {if !$commentReply}
        <h2>Добавление комментария для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {else}
        <h2>Ответ на <a href="{url route="quoteView" id=$commentsFolder->getParentId()}#comment{$commentReply->getId()}">комментарий</a> для <a href="{url route="quoteView" id=$commentsFolder->getParentId()}">Говнокода #{$commentsFolder->getParentId()}</a></h2>
        {/if}
        <div class="entry-comments">
            {form action=$action method="post"}
                {include file="comments/postForm.tpl"}
            </form>
        </div>
    </li>
</ol>