{assign var="highlight" value=$current_user->getHighlightDriver()}
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
        </div>
        <p class="description">
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        <p class="author">
            Наговнокодил: <a style="background-image: url('{$quote->getUser()->getAvatarUrl(20)|h}');" href="{url route="withId" module="user" action="" id=$quote->getUser()->getId()}">{$quote->getUser()->getLogin()|h}</a>
        </p>
        <div class="entry-comments">
            <a href="{url route="quoteView" id=$quote->getId()}" class="entry-comments-load">Комментарии</a> <span class="count">({$quote->getCommentsCount()})</span>
        </div>
    </li>