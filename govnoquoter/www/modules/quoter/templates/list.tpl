{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

<div class="rounded-box" style="float: left; width: 60%">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
{if $listAll}
    {title append="Говнокод онлайн"}
        <h1>Говнокод.ру</h1>
        Нашли или выдавили из себя код, который нельзя назвать нормальным, на который без улыбки не взглянешь? Не торопитесь его удалять
        или рефакторить — запостите его на говнокод.ру, посмеемся вместе!
        <p><a href="http://code.google.com/p/govnokod/">http://code.google.com/p/govnokod/</a></p>
{else}
    {if $category->getPage()}
        {assign var="pageTitle" value=$category->getPage()->getTitle()}
        {assign var="pageContent" value=$category->getPage()->getContent()}
    {else}
        {assign var="pageTitle" value=$category->getTitle()}
        {assign var="pageContent" value=""}
    {/if}
    {title append=$pageTitle|htmlspecialchars}
        <h1>{$pageTitle|htmlspecialchars}</h1>
        {if $category->getQuoteCounts() == 0}
        <p>&nbsp;</p>
        <p>Раздел пуст. <a href="{url route="quoteAddFull" name=$category->getName()}">Пометить</a> место первым.</p>
        {/if}
{/if}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

<div class="rounded-box right-box">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <ul>{foreach from=$categories item="category"}<li><a href="{url route="categoryList" name=$category->getName()|htmlspecialchars}">{$category->getTitle()|htmlspecialchars} ({$category->getQuoteCounts()})</a></li>{/foreach}</ul>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
<div style="clear: both;"></div>
{foreach from=$quotes item="quote"}
{assign var="langName" value=$quote->getCategory()->getName()|htmlspecialchars}
{add file="langs/$langName.css"}
<div class="rounded-box" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <span class="rate"><a href="{url route="quoteVote" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> {$quote->getRating()} <a href="{url route="quoteVote" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a></span>
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
                {if $quote->getLinesCount() > 15}{assign var="stripcount" value=17}{/if}
                {$quote->getText($stripcount)|highlite:$langName:$quote->getHighlightedLines()}
            {/strip}
        </div>

        <div class="description">{$quote->getDescription()|htmlspecialchars|nl2br}</div>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/foreach}

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}