{strip}{add file="jquery.js"}
{add file="govnokod.js"}
{assign var="number" value=$quote->getId()}
{title append="Говнокод #$number"}
{title append=$quote->getCategory()->getTitle()|h}
{meta description=$quote->getDescription() reset=true}

{assign var="highlight" value=$current_user->getHighlightDriver()}
{if $highlight == "geshi"}
{assign var="langName" value=$quote->getCategory()->getGeshiAlias()|h}
{add file="langs/$langName.css"}
{else}
{add file="jshighlight/govnokod.css"}{add file="jshighlight/highlight.pack.js"}{add file="govnokod.jsh.js"}
{assign var="langName" value=$quote->getCategory()->getJsAlias()|h}
{/if}

{/strip}
<ol class="posts hatom">
    <li class="hentry">
        <h2><a rel="chapter" href="{url route="categoryList" name=$quote->getCategory()->getName()|h}">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="{url route="quoteView" id=$quote->getId()}">Говнокод #{$quote->getId()}</a></h2>
        <p class="vote">
            {include file="quoter/rating.tpl" quote=$quote}
        </p>
        <div class="entry-content">
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {if $highlight == "geshi"}
            {$quote->getText()|highlite:$langName:$quote->getCacheKey()}
            {else}
            <pre><code class="{$langName|h}">{$quote->getText()|h}</code></pre>
            {/if}
        </div>
        <p class="description">
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>
        {load module="comments" action="list" object=$quote}
    </li>
</ol>