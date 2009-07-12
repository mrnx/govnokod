{if $isEdit}{title append="Редактировать говнокод"}{else}{title append="Наговнокодить"}{/if}
{add file="jquery.js"}
{add file="govnokod.add.js"}

<ol class="posts hatom">
    <li class="hentry add">
        <h2>{if $isEdit}Редактирование <a href="{url route="quoteView" id=$quote->getId()}">говнокода #{$quote->getId()}</a>{else}Наговнокодить{/if}</h2>
        {form action=$formAction method="post"}
            {if !$form->isValid()}
            <dl class="errors">
                <dt>Ошибка компиляции кода:</dt>
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
                <dt>{form->caption name="category_id" value="Язык:"}</dt>
                <dd>{form->select name="category_id" options=$categoriesSelect emptyFirst=true}</dd>

                <dt>{form->caption name="description" value="Описание:"}</dt>
                <dd>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50"}</dd>

                <dt>{form->caption name="text" value="Код:"} (Максимум 100 строк)</dt>
                <dd>
                    {if $quote->getText()}{assign var="text" value=$quote->getText()}{else}{assign var="text" value="\n\n\n\n\n\n\n\n\n\n"}{/if}
                    {form->textarea class="code" name="text" value=$text rows="10" cols="50" style="width: 90%;"}
                </dd>

                <dt>{form->caption name="captcha" value="Проверочный код:"}</dt>
                <dd>{form->captcha name="captcha"}</dd>
            </dl>
            <p>
                {form->submit class="send" name="submit" value="Накласть"}
            </p>
        </form>
    </li>
</ol>