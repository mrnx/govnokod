{strip}
{add file="jquery.js"}
{add file="jquery.scrollTo.js"}
{add file="govnokod.js"}
{if $current_user->getHighlightDriver() == 'js'}{add file="jshighlight/govnokod.css"}{add file="jshighlight/highlight.pack.js"}{/if}
{title append="Список говнокодов пользователя `$user->getLogin()`"}
<ol class="posts hatom">
    <li class="hentry">
        <h2>Список говнокодов пользователя <a href="{url route="withId" module="user" action="" id=$user->getId()}">{$user->getLogin()|h}</a></h2>
        <p>Всего: {$pager->getItemsCount()|h}</p>
    </li>
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{foreachelse}
    <li class="hentry">
        <h2>Пусто</h2>
        <p>Пользователь еще не успел наговнокодить</p>
    </li>
{/foreach}
</ol>

{if $pager->getPagesTotal() > 1}
    {$pager->toString()}
{/if}
{/strip}