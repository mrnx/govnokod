{if $isEdit}{title append="Редактировать говнокод"}{else}{title append="Наговнокодить"}{/if}
{add file="jquery.js"}
{add file="jquery.textlimit.js"}
{add file="govnokod.add.js"}

<ol class="posts hatom">
    <li class="hentry add">
        <h2>{if $isEdit}Редактирование <a href="{url route="quoteView" id=$quote->getId()}">говнокода #{$quote->getId()}</a>{else}Наговнокодить{/if}</h2>
        {form action=$formAction method="post"}
            {if $errors->export()}
            <dl class="errors">
                <dt>Ошибка компиляции кода:</dt>
                <dd>
                    <ol>
                    {foreach from=$errors->export() item="error"}
                        <li>{$error}</li>
                    {/foreach}
                    </ol>
                </dd>
            </dl>
            {/if}
            {*<dl>
                <dt>{form->caption name="category_id" value="Язык:"}</dt>
                <dd>{form->select name="category_id" options=$categoriesSelect emptyFirst=true}</dd>
            </dl>
            <dl>
                <dt>{form->caption name="description" value="Описание:"}</dt>
                <dd>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50"}</dd>
            </dl>
            *}
            <dl>
                <dt>{form->caption name="text" value="Код:"} (Максимум 100 строк)</dt>
                <dd>
                    {if $quote->getText()}{assign var="text" value=$quote->getText()}{else}{assign var="text" value="\n\n\n\n\n\n\n\n\n\n"}{/if}
                    {form->textarea class="code" name="text" value=$text rows="10" cols="50"}
                </dd>
            </dl>
            {*
            <dl>
                <dt>{form->caption name="captcha" value="Проверочный код:"}</dt>
                <dd>{form->captcha name="captcha"}</dd>
            </dl>*}
            <p>
                {form->submit class="send" name="submit" value="Накласть"}
            </p>
        </form>
    </li>
</ol>
{*
    <div class="rounded-box" style="width: 100%;">
        <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
        <div class="inner-box">
            <h1>{if $isEdit}Редактирование <a href="{url route="quoteView" id=$quote->getId()}">говнокода #{$quote->getId()}</a>{else}Наговнокодить{/if}</h1>
            {foreach from=$errors->export() item="error" name="errorIterator"}
            {if $smarty.foreach.errorIterator.first}<ul class="errors">{/if}
                <li>{$error}</li>
            {if $smarty.foreach.errorIterator.last}</ul><br />{/if}
            {/foreach}



            {form action=$formAction method="post" jip=false}
                <table width="100%" border="0" cellpadding="5" cellspacing="0">
                    <tr>
                        <td style="vertical-align: top; width: 20%;">{form->caption name="category_id" value="Язык:"}</td>
                        <td style="width: 80%;">{form->select name="category_id" options=$categoriesSelect emptyFirst=true value=$currentCategory}</td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">{form->caption name="description" value="Описание:"}</td>
                        <td>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50"}</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">{form->caption name="text" value="Код:"} (цифры кликабельны)</td>
                        <td>
                            <div id="codeSaveContainer" class="codeInput">
                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                    <tr>
                                        <td style="vertical-align: top; width: 5%;">
                                            <div id="nums" class="linenumbers"></div>
                                        </td>
                                        <td style="vertical-align: top; width: 95%;">
                                            {if $quote->getText()}{assign var="text" value=$quote->getText()}{else}{assign var="text" value="\n\n\n\n\n"}{/if}
                                            {form->textarea id="form_text" name="text" value=$text rows="1" cols="50" class="codeArea" onkeyup="numbering(this);" wrap="off"}
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    {if !$isEdit}<tr>
                        <td>{form->caption name="captcha" value="Защита от жопашников<br /> и социопатов:"}</td>
                        <td>{form->captcha name="captcha"}</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    {/if}
                    <tr>
                        <td id="linesInput">&nbsp;</td>
                        <td>{form->submit name="submit" value="Накласть"}</td>
                    </tr>
                </table>
            </form>
        </div>
        <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
    </div>
    <script type="text/javascript">
        var MAX_LINES = 100;
        var linesCountLast;
        var selectedLines = new Array();
        {foreach from=$lines item="line"}
        selectedLines[{$line}] = true;
        {/foreach}
        numbering($('form_text'));
    </script>
    *}