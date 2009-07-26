{title append="Личные настройки"}
<ol class="posts">
    <li class="hentry">
        <h2>Личные настройки</h2>

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