{title append="Настройки сайта"}
{set name="helpPageUrl"}{url route="pageActions" name="preferences"}{/set}
<ol class="posts">
    <li class="hentry">
        <h2>Настройки сайта</h2>
        {form action=$form_action method="post"}
            {if !$form->isValid()}
            <dl class="errors">
                <dt>Ошибка сохранения настроек:</dt>
                <dd>
                    <ol>
                    {foreach from=$form->export() item="error"}
                        <li>{$error}</li>
                    {/foreach}
                    </ol>
                </dd>
            </dl>
            {/if}
            <dl>
                {set name="helpLabel"}Юзерпик (<a href="{$helpPageUrl}#userpic">подробнее</a>):{/set}
                <dt>{form->caption name="avatar" value=$helpLabel label=false}</dt>
                <dd>
                    {form->radio name="avatar" values="0|1" label="Без" style="width: auto;" value=$user->getAvatarType()}
                    {form->radio name="avatar" values="0|2" label="Gravatar" style="width: auto;" value=$user->getAvatarType()}
                </dd>

                {set name="helpLabel"}Интересующие языки (<a href="{$helpPageUrl}#langs">подробнее</a>):{/set}
                <dt>{form->caption name="lang" value=$helpLabel label=false}</dt>
                <dd>
                    <ul>
                    {foreach from=$categories item="category" key="id"}
                        <li>{form->checkbox name="lang[$id]" values="0|1" text=$category->getTitle() style="width: auto;" value=$user->isPreferredLang($id) nodefault=true}</li>
                    {/foreach}
                    </ul>
                </dd>

                {set name="helpLabel"}Способ подсветки кода (<a href="{$helpPageUrl}#langs">что выбрать?</a>):{/set}
                <dt>{form->caption name="hdriver" value=$helpLabel}</dt>
                <dd>
                    {form->select name="hdriver" options=$drivers value=$user->getHighlightDriver()}
                </dd>

                <dt>{form->caption name="timezone" value="Часовой пояс:"}</dt>
                <dd>{form->select name="timezone" options=$timezones emptyFirst=true value=$user->getTimezone()}</dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Сохранить"}
            </p>
        </form>
    </li>
</ol>