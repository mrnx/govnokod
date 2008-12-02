{strip}{add file="prototype.js"}
{add file="govnokod.js"}
{assign var="number" value=$quote->getId()}
{assign var="langName" value=$quote->getCategory()->getName()|htmlspecialchars}
{add file="langs/$langName.css"}
{title append="Говнокод#$number"}
{title append=$quote->getCategory()->getTitle()|htmlspecialchars}
{meta description=$quote->getDescription() reset=true}
{/strip}
<div class="rounded-box" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <span class="rate"><a href="{url route="quoteVote" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> {$quote->getRating()} <a href="{url route="quoteVote" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a></span>
        <h1><a href="{url route="categoryList" name=$langName}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод#{$quote->getId()}</a> {$quote->getJip()}</h1>
        <div class="colorCode" id="colorCode{$quote->getId()}">
            <ol class="linenumbers">{foreach from=$quote->generateLines() item="line" name="lineIterator"}<li>{$line}</li>{/foreach}</ol>
            {$quote->getText()|highlite:$langName:$quote->getHighlightedLines():$quote->getId()}
        </div>

        <div class="description">{$quote->getDescription()|htmlspecialchars|nl2br}</div>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{load module="comments" section="comments" action="list" id=$quote->getObjId()}