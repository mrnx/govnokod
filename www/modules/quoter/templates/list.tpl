{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

<div class="rounded-box" style="float: left; width: 60%">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
{if $listAll}
    {title append="Говнокод онлайн"}
        <h1>Говнокод.ру</h1>
        <p>Нашли или выдавили из себя код, который нельзя назвать нормальным, на который без улыбки не взглянешь? Не торопитесь его удалять
        или рефакторить — запостите его на говнокод.ру, посмеемся вместе!</p>
        <p>&nbsp;</p>
        <p><a href="http://code.google.com/p/govnokod/">http://code.google.com/p/govnokod/</a></p>
{else}
    {if $category->getPage()}
        {assign var="pageTitle" value=$category->getPage()->getTitle()}
        {assign var="pageContent" value=$category->getPage()->getContent()}
    {else}
        {assign var="pageTitle" value=$category->getTitle()}
        {assign var="pageContent" value=""}
    {/if}
    {title append=$pageTitle|htmlspecialchars}
        <h1>{$pageTitle|htmlspecialchars}</h1>
        {if $category->getQuoteCounts() == 0}
        <p>&nbsp;</p>
        <p>Раздел пуст. <a href="{url route="quoteAddFull" name=$category->getName()}">Пометить</a> место первым.</p>
        {else}
        {$pageContent}
        {/if}
{/if}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

<div class="rounded-box right-box">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        {strip}<ul>
            <li>{if $category|default:false}<a href="/">Все</a>{else}Все{/if}</li>
            {foreach from=$categories item="cat"}
            {if $category|default:false && $category->getId() == $cat->getId()}{assign var="isActive" value=true}{else}{assign var="isActive" value=false}{/if}
            <li>{if !$isActive}<a href="{url route="categoryList" name=$cat->getName()|htmlspecialchars}">{/if}{$cat->getTitle()|htmlspecialchars} ({$cat->getQuoteCounts()}){if !$isActive}</a>{/if}</li>
            {/foreach}
        </ul>{/strip}
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
<div style="clear: both;"></div>
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{/foreach}

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}
