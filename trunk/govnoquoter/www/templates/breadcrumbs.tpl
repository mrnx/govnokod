<div class="breadcrumbs">
 <span class="breadcrumbsTitle">Путь:</span> <span class="breadcrumbsItems">
 {foreach from=$breadCrumbs item="crumb" name="crumb"}
    {if $smarty.foreach.crumb.last}
        <strong>{$crumb->getTitle()}</strong>{$crumb->getJip()}
    {else}
        <a href="{url route='admin' params=$crumb->getPath() section_name=$section module_name=$module}">{$crumb->getTitle()}</a> <img src="{$SITE_PATH}/templates/images/breadcrumb_arrow.gif" alt="" width="10" height="10" /> 
    {/if}
 {/foreach}
 </span>
</div>