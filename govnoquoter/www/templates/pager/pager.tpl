{strip}
    <ul class="pagination">
    {if !is_null($pager->getPrev())}<li><a href="{$pager->getPrev()}" title="Предыдущая страница">&lt;</a></li>{/if}
    {foreach from=$pages item=current}
        <li>
        {if not empty($current.skip)}
            <a href="#" onclick="return false;">…</a>
        {elseif not empty($current.current)}
           <a href="{$current.url}" class="active" title="Страница {$current.page}">{$current.page}</a>
        {else}
            <a href="{$current.url}" title="Страница {$current.page}">{$current.page}</a>
        {/if}
        </li>
    {/foreach}
    {if !is_null($pager->getNext())}
        <li><a href="{$pager->getNext()}" title="Слудющая страница">&gt;</a></li>
    {/if}
    </ul>
    <div style="clear: both;"></div>
{/strip}