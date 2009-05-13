<ol id="language">
{foreach from=$categories item="category"}
    <li><a href="{url route="categoryList" name=$category->getName()|h}">{$category->getTitle()|h}</a> <span>({$category->getQuoteCounts()})</span></li>
{/foreach}
</ol>