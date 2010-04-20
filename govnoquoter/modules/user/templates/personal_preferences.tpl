{title append="Личные настройки"}
{assign var="helpPageUrl" value={url route="pageActions" name="preferences"}}
<ol class="posts">
    <li class="hentry">
        <h2><a href="{url route="default2" module="user" action="login"}">Моя личная кабинка</a> → <a href="{url route="default2" module="user" action="preferences"}">Настройки</a> → Персональные</h2>

        {form action=$form_action method="post"}
            <dl>
                <dt>{form->caption name="avatar" value="Юзерпик (<a href='{$helpPageUrl}#userpic'>подробнее</a>):" label=false}</dt>
                <dd>
                    {form->radio name="avatar" values="0|1" label="Без" style="width: auto;" value=$user->getAvatarType()}
                    {form->radio name="avatar" values="0|2" label="Gravatar" style="width: auto;" value=$user->getAvatarType()}
                </dd>

                <dt>{form->caption name="avatar" value="Мои OpenID идентификаторы:" label=false}</dt>
                <dd>
                    <ul>
{assign var="openid_identifiers" value=$user->getOpenIDIdentifiers()}
{if !$openid_identifiers->isEmpty()}
{foreach from=$user->getOpenIDIdentifiers() item="openid_id"}
                        <li>{$openid_id->getUrl()|h}</li>
{/foreach}
                        <li><a href="{url route="default2" module="user" action="addOpenID"}">+ Добавить еще один!</a></li>
{else}
                        <li>Удивительно, ни одного OpenID идентификатора! <a href="{url route="default2" module="user" action="addOpenID"}">Добавить его сейчас!</a></li>
{/if}
                    </ul>
                </dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Сохранить"}
            </p>
        </form>
    </li>
</ol>