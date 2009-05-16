{if $isEdit}
    <div class="jipTitle">Редактирование &quot;{$category->getTitle()|htmlspecialchars}&quot;</div>
{else}
    <div class="jipTitle">Создание новой категории</div>
{/if}

{form action=$form_action method="post" jip=true}
    <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center">
        {if $isEdit}
        <tr>
            <td style="vertical-align: top;">{form->caption name="name" value="Идентификатор:"}</td>
            <td><strong>{$category->getName()|htmlspecialchars}</strong></td>
        </tr>
        {else}
        <tr>
            <td style="vertical-align: top;">{form->caption name="name" value="Идентификатор:"}</td>
            <td>{form->text name="name" value=$category->getName() size="60"} {$errors->get("name")}</td>
        </tr>
        {/if}
        <tr>
            <td style="width: 20%;">{form->caption name="title" value="Заголовок:"}</td>
            <td style="width: 80%;">{form->text name="title" value=$category->getTitle() size="60"} {$errors->get("title")}</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>{form->submit name="submit" value="Сохранить"} {form->reset jip=true name="reset" value="Отмена"}</td>
        </tr>
    </table>
</form>