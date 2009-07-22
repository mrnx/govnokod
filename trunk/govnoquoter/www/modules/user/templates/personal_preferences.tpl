{title append="Личные настройки"}
{title append="Настройки"}
<ol class="posts">
    <li class="hentry">
        <h2>Настройки</h2>

        <ul>
            <li><a href="{url route="withAnyParam" action="preferences" name="global"}">Настройки сайта</a></li>
            <li>Личные настройки</li>
        </ul>

        {form action=$form_action method="post"}
        <dl>
            <dt>{form->caption name="avatar" value="Юзерпик:" label=false}</dt>
            <dd>
                {form->radio name="avatar" values="0|1" label="Без" style="width: auto;" value=$user->getAvatarType()}
                {form->radio name="avatar" values="0|2" label="Gravatar" style="width: auto;" value=$user->getAvatarType()}
            </dd>
        </dl>
        <p>
            {form->submit class="send" name="submit" value="Сохранить"}
        </p>
        </form>
    </li>
</ol>