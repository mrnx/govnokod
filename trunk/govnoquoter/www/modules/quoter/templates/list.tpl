{strip}
{add file="jquery.js"}
{add file="govnokod.js"}
{if !$listAll}
    {title append=$category->getTitle()}
{/if}
{/strip}

<ol class="posts hatom">
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{/foreach}
</ol>

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}