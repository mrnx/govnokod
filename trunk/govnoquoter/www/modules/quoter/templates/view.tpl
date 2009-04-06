{strip}{add file="prototype.js"}
{add file="govnokod.js"}
{assign var="number" value=$quote->getId()}
{assign var="langName" value=$quote->getCategory()->getName()|h}
{add file="langs/$langName.css"}
{title append="Говнокод #$number"}
{title append=$quote->getCategory()->getTitle()|htmlspecialchars}
{meta description=$quote->getDescription() reset=true}
{/strip}
<ol class="posts hatom">
    <li class="hentry">
        <h2><a rel="chapter" href="#">{$quote->getCategory()->getTitle()|h}</a> / <a rel="bookmark" class="entry-title" href="#">Говнокод #{$quote->getId()}</a></h2>
        <p class="vote">
            Говносила:
            <a class="vote-on" href="#">&uarr;</a>
            <strong>15</strong>
            <a class="vote-against" href="#">&darr;</a>
        </p>
        <div class="entry-content">
            <ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
            {$quote->getText()|highlite:$langName:$quote->getHighlightedLines()}
            <a class="trigger" href="#">показать весь код +</a>
        </div>
        <p>
            {$quote->getDescription()|trim|h|bbcode|nl2br}
        </p>

        {load module="comments" action="list" object=$quote byField="id"}
    </li>
</ol>