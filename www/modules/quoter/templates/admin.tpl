<div class="pageTitle">Список категорий {$folder->getJip()}</div>

<div class="pageContent">
    <table cellspacing="0" cellpadding="3" class="tableList">
        <thead class="tableListHead">
            <tr>
                <td style="width: 30px;">&nbsp;</td>
                <td style="width: 260px; text-align: left;">Название</td>
                <td style="text-align: left;">Идентификатор</td>
                <td style="text-align: left;">Кол-во элементов</td>
                <td style="width: 30px;">JIP</td>
            </tr>
        </thead>
        {foreach from=$categories item="category"}
        <tr>
            <td><img src="{$SITE_PATH}/templates/images/page/page.gif" alt="" /></td>
            <td>{$category->getTitle()|htmlspecialchars}</td>
            <td>{$category->getName()|htmlspecialchars}</td>
            <td>{$category->getQuoteCounts()}</td>
            <td>{$category->getJip()}</td>
        </tr>
        {/foreach}
    </table>
</div>