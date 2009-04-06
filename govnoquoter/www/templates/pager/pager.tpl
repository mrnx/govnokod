{strip}
    <ul class="pagination">
        <li>{if !is_null($pager->getPrev())}<a href="{$pager->getPrev()}">&larr; назад</a>{else}&larr; назад{/if}</li>
        <li>{if !is_null($pager->getNext())}<a href="{$pager->getNext()}">вперёд &rarr;</a>{else}вперёд &rarr;{/if}</li>
    </ul>

    <ul class="pagination numbered">
        {foreach from=$pages item=current}
            {if not empty($current.skip)}
            <li>…</li>
            {elseif not empty($current.current)}
            <li><span>{$current.page}</span></li>
            {else}
            <li><a href="{$current.url}">{$current.page}</a></li>
            {/if}
        {/foreach}
    </ul>
{/strip}