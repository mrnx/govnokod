    <div class="jipTitle">Редактирование Говнокода #{$quote->getId()}</div>
    {form action=$formAction method="post" jip=true}
        <table width="100%" border="0" cellpadding="5" cellspacing="0">
            <tr>
                <td style="vertical-align: top; width: 10%;">{form->caption name="category_id" value="Язык:"}</td>
                <td style="width: 90%;">{form->select name="category_id" options=$categoriesSelect emptyFirst=true value=$currentCategory} {$errors->get('category_id')}</td>
            </tr>
            <tr>
                <td style="vertical-align: top;">{form->caption name="description" value="Описание:"}</td>
                <td>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50" style="width: 100%;"} {$errors->get('description')}</td>
            </tr>
            <tr>
                <td style="vertical-align: top;">{form->caption name="text" value="Код:"} {$errors->get('text')}</td>
                <td>
                    {form->textarea id="form_text" name="text" value=$quote->getText() rows="20" cols="50" style="width: 100%;" wrap="off"}
                </td>
            </tr>
            <tr>
                <td>Выделенные строки:</td>
                <td>
                    {foreach from=$lines item="line"}{form->hidden name="lines[]" value=$line}{/foreach}
                    выделять строки можно только по <a href="{url route="withId" action="edit" id=$quote->getId()}">этому</a> адресу
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>{form->submit name="submit" value="Сохранить"} {form->reset jip=true name="reset" value="Отмена"}</td>
            </tr>
        </table>
    </form>