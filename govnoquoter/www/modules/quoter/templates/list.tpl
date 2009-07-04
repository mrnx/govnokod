{strip}
{add file="jquery.js"}
{add file="govnokod.js"}
{if $current_user->getHighlightDriver() == 'js'}{add file="jshighlight/govnokod.css"}{add file="jshighlight/highlight.pack.js"}{add file="govnokod.jsh.js"}{/if}
{if !$listAll}
    {title append=$category->getTitle()}
{/if}

<ol class="posts hatom">
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{/foreach}
</ol>

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}
{/strip}