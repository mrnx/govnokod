{title append=$page->getTitle()}
{meta keywords=$page->getKeywords() reset=$page->isKeywordsReset()}
{meta description=$page->getDescription() reset=$page->isDescriptionReset()}

<ol class="posts">
    <li class="hentry">
        <h2>{$page->getTitle()|h} {$page->getJip()}</h2>
        {if $page->getCompiled()}{eval var=$page->getContent()}{else}{$page->getContent()}{/if}
    </li>
</ol>