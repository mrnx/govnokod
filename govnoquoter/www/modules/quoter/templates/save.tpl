{if $isEdit}
{title append="Редактировать говнокод"}
{else}
{title append="Наговнокодить"}
{/if}
{add file="prototype.js"}
{add file="govnokod.js"}
{add file="add.css" join=false}

    <div class="rounded-box" style="width: 100%;">
        <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
        <div class="inner-box">
            <h1>{if $isEdit}Редактирование <a href="{url route="quoteView" id=$quote->getId()}">говнокода#{$quote->getId()}</a>{else}Наговнокодить{/if}</h1>
            {foreach from=$errors->export() item="error" name="errorIterator"}
            {if $smarty.foreach.errorIterator.first}<ul clas="errors">{/if}
                <li>{$error}</li>
            {if $smarty.foreach.errorIterator.last}</ul><br />{/if}
            {/foreach}
            <form action="{if $isEdit}{url route="withId" action="edit" id=$quote->getId()}{else}{url route="quoteAdd"}{/if}" method="post">
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