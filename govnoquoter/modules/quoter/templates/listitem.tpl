{if $highlight == "geshi"}
{assign var="langName" value=$quote->getCategory()->getGeshiAlias()|h}
{add file="langs/$langName.css"}
{else}
{assign var="langName" value=$quote->getCategory()->getJsAlias()|h}
{/if}
    <li class="hentry">
        <h2><a rel="chapter" href="{url route="categoryList" name=$quote->getCategory()->getName()|h}">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="{url route="quoteView" id=$quote->getId()}">Говнокод #{$quote->getId()}</a> {$quote->getJip()}</h2>
        <p class="vote">
            {include file="quoter/rating.tpl" quote=$quote}
        </p>
        <div class="entry-content">
        {if $quote->isSpecial()}
            {$quote->getText()}
        {else}
        {if $highlight == "geshi" && $quote->getLinesCount() > 30}
            <ol>{foreach from=$quote->generateLines(15) item="line"}<li>{$line}</li>{/foreach}<li>…</li><li>{$quote->getLinesCount()}</li></ol>
            {$quote->getText(15)|highlite:$langName:$quote->getCacheKey('15_')}
            <a class="trigger" href="{url route="quoteView" id=$quote->getId()}" title="показать весь код">показать весь код +</a>
        {else}
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {if $highlight == "geshi"}
            {$quote->getText()|highlite:$langName:$quote->getCacheKey()}
            {else}
            <pre><code class="{$langName|h}">{$quote->getText()|h}</code></pre>
            {/if}
        {/if}
        {/if}
        </div>
        <p class="description">
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        <p class="author">
            Запостил: <a href="{url route="withId" module="user" action="" id=$quote->getUser()->getId()}"><img src="{$quote->getUser()->getAvatarUrl(20)|h}" alt="" class="avatar" /></a> <a href="{url route="withId" module="user" action="" id=$quote->getUser()->getId()}">{$quote->getUser()->getLogin()|h}</a>,
            <abbr title="{"c"|date:$quote->getCreated()}">{$quote->getCreated()|date_i18n:"date2"}</abbr>
        </p>
        <div class="entry-comments">
            <span class="comments-icon{if $toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0} comments-new" title="Есть новые комментарии!{/if}"></span><a href="{url route="quoteView" id=$quote->getId()}" class="entry-comments-load">Комментарии</a> <span class="entry-comments-count">({$quote->getCommentsCount()}{if $toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0}, <span title="Новые комментарии" class="entry-comments-new">+{$quote->getNewCommentsCount()|h}</span>{/if})</span>
        </div>
    </li>