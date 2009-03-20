{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

{title append="Поиск говнокода"}
<div class="rounded-box" style="float: left; width: 60%">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <h1>Поиск {if $category} <a href="{url route="categoryList" name=$category->getName()}">{$category->getTitle()|htmlspecialchars}</a> {/if} говнокода</h1>
        {strip}{capture name="searchUrl"}{if $category|default:false}{url route="search" name=$category->getName()}{else}{url route="search"}{/if}{/capture}
        <form action="{$smarty.capture.searchUrl}" method="get">
            {form->text name="search" style="width: 80%;" maxlength=50}
            <input type="submit" value="Покопаться!"/>
        </form>
        {/strip}
        {if $word != '' && $pager->getItemsCount() > 0}
        <p>Найдено: {$pager->getItemsCount()}</p>
        {/if}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

<div class="rounded-box right-box">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {strip}<ul>
            <li>{if $category|default:false}<a href="{url route="search"}">Все</a>{else}Все{/if}</li>
            {foreach from=$categories item="cat"}
            {if $category|default:false && $category->getId() == $cat->getId()}{assign var="isActive" value=true}{else}{assign var="isActive" value=false}{/if}
            <li>{if !$isActive}<a href="{url route="search" name=$cat->getName()|htmlspecialchars}">{/if}{$cat->getTitle()|htmlspecialchars}{if !$isActive}</a>{/if}</li>
            {/foreach}
        </ul>{/strip}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
<div style="clear: both;"></div>

{if $word != ''}
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{foreachelse}
<div class="rounded-box" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <h1>Пусто</h1>
        <p>Поиск не дал результатов</p>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/foreach}

{if $pager|default:false &&  $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}
{/if}