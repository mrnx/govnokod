<ol class="posts">
    <li class="hentry">
        <h2>Настройки</h2>
        {form action=$form_action method="post"}
            <dl>
                <dt>{form->caption name="hdriver" value="Способ подсветки кода:"}</dt>
                <dd>{form->select name="hdriver" options=$drivers value=$user->getHighlightDriver()}</dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Сохранить"}
            </p>
        </form>
    </li>
</ol>