<ol class="posts">
    <li class="hentry">
        <h2>Настройки</h2>
        {form action=$form_action method="post"}
        <dl>
            <dt>{form->caption name="avatar" value="Юзерпик:" label=false}</dt>
            <dd>
                {form->radio name="avatar" values="0|1" label="Без"}
                {form->radio name="avatar" values="0|2" label="Gravatar"}
            </dd>
        </dl>
        <p>
            {form->submit class="send" name="submit" value="Сохранить"}
        </p>
        </form>
    </li>
</ol>