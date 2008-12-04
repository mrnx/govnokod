{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

{if $mode == 'dabest'}
{title append="Лучший говнокод"}
<div class="rounded-box" style="float: left; width: 60%">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <h1>Десятка лучшего{if $category} <a href="{url route="categoryList" name=$category->getName()}">{$category->getTitle()|htmlspecialchars}</a> {/if} говнокода</h1>
        {strip}{capture name="dabestUrl"}{if $category|default:false}{url route="search" mode="dabest" name=$category->getName()}{else}{url route="search" mode="dabest"}{/if}{/capture}
            <ul>
                <li>{if $time != 'ever'}<a href="{$smarty.capture.dabestUrl}?time=ever">за всё время</a>{else}за всё время{/if}</li>
                <li>{if $time != 'month'}<a href="{$smarty.capture.dabestUrl}?time=month">за месяц</a>{else}за месяц{/if}</li>
                <li>{if $time != 'week'}<a href="{$smarty.capture.dabestUrl}?time=week">за неделю</a>{else}за неделю{/if}</li>
            </ul>
        {/strip}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

<div class="rounded-box right-box">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {strip}<ul>
            <li>{if $category|default:false}<a href="{url route="search" mode="dabest"}">Все</a>{else}Все{/if}</li>
            {foreach from=$categories item="cat"}
            {if $category|default:false && $category->getId() == $cat->getId()}{assign var="isActive" value=true}{else}{assign var="isActive" value=false}{/if}
            <li>{if !$isActive}<a href="{url route="search" mode="dabest" name=$cat->getName()|htmlspecialchars}">{/if}{$cat->getTitle()|htmlspecialchars} ({$cat->getQuoteCounts()}){if !$isActive}</a>{/if}</li>
            {/foreach}
        </ul>{/strip}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
<div style="clear: both;"></div>
{else}
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
            <li>{if !$isActive}<a href="{url route="search" name=$cat->getName()|htmlspecialchars}">{/if}{$cat->getTitle()|htmlspecialchars} ({$cat->getQuoteCounts()}){if !$isActive}</a>{/if}</li>
            {/foreach}
        </ul>{/strip}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
<div style="clear: both;"></div>
{/if}

{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{foreachelse}
    <div class="rounded-box" style="width: 100%;">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <h1>Тут пока пусто</h1>
        <p>Поиск не дал результатов</p>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/foreach}

{if $pager|default:false &&  $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}