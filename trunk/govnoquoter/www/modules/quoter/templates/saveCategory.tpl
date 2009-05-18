{if $isEdit}
    <div class="jipTitle">Редактирование &quot;{$category->getTitle()|htmlspecialchars}&quot;</div>
{else}
    <div class="jipTitle">Создание новой категории</div>
{/if}

{form action=$form_action method="post" jip=true}
    <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center">
        <tr>
            <td style="width: 20%;">{form->caption name="name" value="Идентификатор:"}</td>
            <td style="width: 80%;">{form->text name="name" value=$category->getName() size="60"} {$errors->get("name")}</td>
        </tr>
        <tr>
            <td>{form->caption name="title" value="Заголовок:"}</td>
            <td>{form->text name="title" value=$category->getTitle() size="60"} {$errors->get("title")}</td>
        </tr>
        <tr>
            <td>{form->caption name="highlite_name" value="Geshi-name:"}</td>
            <td>{form->text name="highlite_name" value=$category->getHighliteName() size="60"} {$errors->get("highlite_name")}</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>{form->submit name="submit" value="Сохранить"} {form->reset jip=true name="reset" value="Отмена"}</td>
        </tr>
    </table>
</form>