<ol class="posts hatom">
    <li class="hentry">
        <h2>Вход в говнокод тут</h2>
        {form action=$form_action method="post" id="userLogin"}
            <dl>
                <dt>{form->caption name="openidurl" value="OpenID:"}</dt>
                <dd>{form->text name="openidurl" value="http://claimid.com/striker"}</dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Вхожу!"}
            </p>
        </form>
    </li>
</ol>