<form action="{if $isEdit}{url route="withId" action="edit" id=$quote->getId()}{else}{url route="default2" action="add"}{/if}" method="post">
    <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center">
        <tr>
            <td style="vertical-align: top;">{form->caption name="category_id" value="Категория" onError="style=color: red;"}</td>
            <td>{form->select name="category_id" options=$categoriesSelect emptyFirst=true value=$currentCategory}</td>
        </tr>
        <tr>
            <td style="vertical-align: top;">{form->caption name="text" value="Код" onError="style=color: red;"}</td>
            <td>{form->textarea name="text" value=$quote->getText() rows="7" cols="50"}</td>
        </tr>
        <tr>
            <td style='vertical-align: top;'>{form->caption name="description" value="Описание" onError="style=color: red;"}</td>
            <td>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50"}</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>{form->submit name="submit" value="Накласть"}</td>
        </tr>
    </table>
</form>