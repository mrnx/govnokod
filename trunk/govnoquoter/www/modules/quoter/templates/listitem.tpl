{assign var="langName" value=$quote->getCategory()->getName()|h}
{add file="langs/$langName.css"}

    <li class="hentry">
        <h2><a rel="chapter" href="#">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="#">Говнокод #{$quote->getId()}</a></h2>
        <p class="vote">
            Говносила:
            <a class="vote-on" href="#">&uarr;</a>
            <strong>15</strong>
            <a class="vote-against" href="#">&darr;</a>
        </p>
        <div class="entry-content">
        {if $quote->getLinesCount()-15 > 20}
            <ol>{foreach from=$quote->generateLines(15) item="line"}<li>{$line}</li>{/foreach}<li>…</li><li>{$quote->getLinesCount()}</li></ol>
            {$quote->getText(15)|highlite:$langName:$quote->getHighlightedLines()}
        {else}
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {$quote->getText()|highlite:$langName:$quote->getHighlightedLines()}
        {/if}
            <a class="trigger" href="#">показать весь код +</a>
        </div>
        <p>
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        <div class="entry-comments">
            <a href="{url route="quoteView" id=$quote->getId()}" onclick="loadComments(this); return false;">Комментарии</a> <span class="count">({$quote->getCommentsCount()})</span>
        </div>
    </li>


    {*
<div class="rounded-box{if $quote->getRating() < 0} suxx-box{/if}" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <span class="rate"><a href="{url route="quoteVote" action="cool" id=$quote->getId()}?token={$quote->getVoteToken()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> <span class="{if $quote->getRating() > 0}rate_plus{elseif $quote->getRating() < 0}rate_minus{/if}">{$quote->getRating()}</span> <a href="{url route="quoteVote" action="suxx" id=$quote->getId()}?token={$quote->getVoteToken()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a></span>
        <h1><a href="{url route="categoryList" name=$langName}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод #{$quote->getId()}</a> {$quote->getJip()}</h1>
        <div class="colorCode" id="colorCode{$quote->getId()}">
            {strip}
                <ol class="linenumbers">
                {foreach from=$quote->generateLines(15) item="line" name="lineIterator"}
                    <li>{if $smarty.foreach.lineIterator.first && $quote->getLinesCount() > 15}
                        <span id="codefolder{$quote->getId()}" class="folder">
                            <a href="{url route="quoteView" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="Развернуть">
                                <img src="{$SITE_PATH}/templates/images/nolines_plus.gif" alt="" />
                            </a>
                        </span>{/if}
                    {$line}</li>
                {/foreach}
                {if $quote->getLinesCount() > 15}
                    <li>…</li>
                    <li><a href="{url route="quoteView" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="Развернуть">{$quote->getLinesCount()}</a></li>
                 {/if}
                </ol>
                {assign var="stripcount" value=15}
                {if $quote->getLinesCount() > 15}{assign var="stripcount" value=17}{assign var="cacheKey" value=null}{else}{assign var="cacheKey" value=$quote->getCacheKey()}{/if}
                {$quote->getText($stripcount)|highlite:$langName:$quote->getHighlightedLines():$cacheKey}
            {/strip}
        </div>
        <span class="codeInfo"><a href="{url route="quoteView" id=$quote->getId()}#comments" title="перейти к списку комментариев">Комментарии ({$quote->getCommentsCount()})</a></span>
        {if $quote->getRating() < 0}<div class="util">{$quote->getTimeToDie()}</div>{/if}

        <div class="description">{$quote->getDescription()|trim|htmlspecialchars|bbcode|nl2br}</div>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

*}