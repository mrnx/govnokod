{assign var="langName" value=$quote->getCategory()->getName()|htmlspecialchars}
{add file="langs/$langName.css"}
<div class="rounded-box" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <span class="rate"><a href="{url route="quoteVote" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> <span class="{if $quote->getRating() > 0}rate_plus{elseif $quote->getRating() < 0}rate_minus{/if}">{$quote->getRating()}</span> <a href="{url route="quoteVote" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a></span>
        <h1><a href="{url route="categoryList" name=$langName}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод#{$quote->getId()}</a> {$quote->getJip()}</h1>
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
                {if $quote->getLinesCount() > 15}{assign var="stripcount" value=17}{assign var="cacheKey" value=null}{else}{assign var="cacheKey" value=$quote->getId()}{/if}
                {$quote->getText($stripcount)|highlite:$langName:$quote->getHighlightedLines():$cacheKey}
            {/strip}
        </div>

        <span class="codeInfo"><a href="{url route="quoteView" id=$quote->getId()}#comments" title="перейти к списку комментариев">Комментарии ({$quote->getCommentsCount()})</a></span>

        <div class="description">{$quote->getDescription()|htmlspecialchars|nl2br}</div>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>