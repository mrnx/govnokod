{strip}
{add file="jquery.js"}
{add file="jquery.scrollTo.js"}
{add file="govnokod.js"}
{if $current_user->getHighlightDriver() == 'js'}{add file="jshighlight/govnokod.css"}{add file="jshighlight/highlight.pack.js"}{/if}
{if !$listAll}
    {title append=$category->getTitle()}
{else}
    {title append="По колено в коде"}
{/if}

<ol class="posts hatom">
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{foreachelse}
    <li class="hentry">
        <h2>Пусто</h2>
    </li>
{/foreach}
</ol>

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}
{/strip}