{title append="Моя личная кабинка"}
<ol class="posts">
    <li class="hentry">
        <h2>Моя личная кабинка</h2>
        <p><img src="{$user->getAvatarUrl()|h}" alt="avatar" title="Аватар пользователя {$user->getLogin()|h}" /></p>

        <dl>
            <dt>Предпочитаемые языки:</dt>
            <dd>
                {foreach from=$categories item="category" name="categoryIterator"}
                {$category->getTitle()|h}{if !$smarty.foreach.categoryIterator.last},{/if}
                {/foreach}
            </dd>

            <dt>Подсветка кода:</dt>
            <dd>{$user->getHighlightDriverTitle()|h}</dd>
        </dl>

        <p><a href="{url route="default2" module="user" action="preferences"}">Настройки</a></p>
    </li>
</ol>