{assign var="langName" value=$quote->getCategory()->getHighliteName()|h}
{add file="langs/$langName.css"}
    <li class="hentry">
        <h2><a rel="chapter" href="{url route="categoryList" name=$quote->getCategory()->getName()|h}">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="{url route="quoteView" id=$quote->getId()}">Говнокод #{$quote->getId()}</a></h2>
        <p class="vote">
            {include file="quoter/rating.tpl" quote=$quote}
        </p>
        <div class="entry-content">
        {if $quote->getLinesCount() > 30}
            <ol>{foreach from=$quote->generateLines(15) item="line"}<li>{$line}</li>{/foreach}<li>…</li><li>{$quote->getLinesCount()}</li></ol>
            {$quote->getText(15)|highlite:$langName:$quote->getHighlightedLines()}
            <a class="trigger" href="{url route="quoteView" id=$quote->getId()}" onclick="comments.unfold($(this));" title="показать весь код">показать весь код +</a>
        {else}
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {$quote->getText()|highlite:$langName:$quote->getHighlightedLines()}
        {/if}
        </div>
        <p class="description">
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        <div class="entry-comments">
            <a href="{url route="quoteView" id=$quote->getId()}" onclick="comments.load($(this)); return false;">Комментарии</a> <span class="count">({$quote->getCommentsCount()})</span>
        </div>
    </li>