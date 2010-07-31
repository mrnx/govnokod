<div class="jipTitle">{if $isEdit}Редактирование пользователя{else}Создание пользователя{/if}</div>
{form action=$form_action method="post" jip=true}
    <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center">
        {if $isEdit}
            <tr>
                <td>Идентификатор:</td>
                <td><strong>{$user->getId()}</strong></td>
            </tr>
        {/if}
        <tr>
            <td style="width: 30%;">{form->caption name="user[login]" value="Логин"}</td>
            <td style="width: 70%;">
                {form->text name="user[login]" value=$user->getLogin() size="40"}
                {if $validator->isFieldError('user[login]')}<div class="error">{$validator->getFieldError('user[login]')}</div>{/if}
            </td>
        </tr>
        <tr>
            <td>{form->caption name="user[email]" value="Email"}</td>
            <td>
                {form->text name="user[email]" value=$user->getEmail() size="40"}
                {if $validator->isFieldError('user[email]')}<div class="error">{$validator->getFieldError('user[email]')}</div>{/if}
            </td>
        </tr>
        <tr>
            <td>{form->caption name="user[password]" value="Пароль"}</td>
            <td>
                {form->password name="user[password]" size="40"}
                {if $validator->isFieldError('user[password]')}<div class="error">{$validator->getFieldError('user[password]')}</div>{/if}
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>{form->submit name="submit" value="Сохранить"} {form->reset jip=true name="reset" value="Отмена"}</td>
        </tr>
    </table>
</form>
