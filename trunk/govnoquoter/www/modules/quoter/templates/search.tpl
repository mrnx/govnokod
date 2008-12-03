{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

{if $mode == 'dabest'}
    {title append="Лучший говнокод"}
<div class="rounded-box" style="float: left; width: 60%">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <h1>Десятка лучшего{if $category} <a href="{url route="categoryList" name=$category->getName()}">{$category->getTitle()|htmlspecialchars}</a> {/if} говнокода</h1>
        {if $category}{assign var="categoryName" value=$category->getName()}{else}{assign var="categoryName" value=null}{/if}
        <p>
            <ul>
                <li><a href="{url route="search" mode="dabest" name=$categoryName _time="ever"}">за всё время</a></li>
                <li>за месяц</li>
                <li>за неделю</li>
            </ul>
        </p>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>

<div class="rounded-box right-box">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <ul>{foreach from=$categories item="cat"}<li><a href="{url route="search" mode=$mode name=$cat->getName()|htmlspecialchars}">{$cat->getTitle()|htmlspecialchars}</a></li>{/foreach}</ul>
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