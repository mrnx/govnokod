<div class="pagination">
    {if !is_null($pager->getPrev())}<a href="{$pager->getPrev()}" title="Предыдущая страница">&lt;</a>{/if}
    {foreach from=$pages item=current}
        {if not empty($current.skip)}...{elseif not empty($current.current)}<a href="{$current.url}" class="active" title="Страница {$current.page}">{$current.page}</a>{else}<a href="{$current.url}" title="Страница {$current.page}">{$current.page}</a>{/if}
    {/foreach}
    {if !is_null($pager->getNext())}<a href="{$pager->getNext()}" title="Слудющая страница">&gt;</a>{/if}
</div>
<div style="clear: both;"></div>