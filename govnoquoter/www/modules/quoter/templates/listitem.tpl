{assign var="langName" value=$quote->getCategory()->getName()|h}
{add file="langs/$langName.css"}
    <li class="hentry">
        <h2><a rel="chapter" href="{url route="categoryList" name=$langName}">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="{url route="quoteView" id=$quote->getId()}">Говнокод #{$quote->getId()}</a> {$quote->getJip()}</h2>
        <p class="vote">
            {load module="ratings" section="ratings" action="view" object=$quote tplPrefix="quote_"}
        </p>
        <div class="entry-content">
        {if $quote->getLinesCount() > 30}
            <ol>{foreach from=$quote->generateLines(15) item="line"}<li>{$line}</li>{/foreach}<li>…</li><li><a href="{url route="quoteView" id=$quote->getId()}" onclick="new Insertion.After(this, this.innerHTML); this.remove(); unfoldCode({$quote->getId()}); return false;" title="показать весь код">{$quote->getLinesCount()}</a></li></ol>
            {$quote->getText(15)|highlite:$langName:$quote->getHighlightedLines()}
            <a id="trigger_{$quote->getId()}" class="trigger" href="{url route="quoteView" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="показать весь код">показать весь код +</a>
        {else}
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {$quote->getText()|highlite:$langName:$quote->getHighlightedLines()}
        {/if}
        </div>
        <p class="description">
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        <div class="entry-comments">
            <a href="{url route="quoteView" id=$quote->getId()}" onclick="loadComments(this); return false;">Комментарии</a> <span class="count">({$quote->getCommentsCount()})</span>
        </div>
    </li>