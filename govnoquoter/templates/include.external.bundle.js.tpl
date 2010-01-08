{if isset($media.js) }
{strip}
    {assign var="external" value=""}
    {foreach from=$media.js item="jsitem" key="file" name="jsFiles"}
    {if $jsitem.join}
        {assign var="currentFile" value=$file}
        {assign var="external" value=$external$currentFile,}
    {else}
        {include file=$jsitem.tpl filename=$file}
    {/if}
    {/foreach}
    {if $external}
        <script type="text/javascript" src="{$SITE_PATH}/templates/media/{$external|substr:0:-1|@md5}.js?files={$external|substr:0:-1}"></script>
    {/if}
{/strip}
{/if}