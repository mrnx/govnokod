{strip}
{add file="jquery.js"}
{add file="govnokod.js"}
{if !$listAll}
    {title append=$category->getTitle()}
{/if}

{if $current_user->getHighlightDriver() == 'js'}
{add file="jshighlight/govnokod.css"}
{add file="highlight/highlight.pack.js"}
<script type="text/javascript">
    hljs.initHighlightingOnLoad();
</script>
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