{if $isEdit}
{title append="Редактировать говнокод"}
{else}
{title append="Накласть говнокод"}
{/if}
{add file="prototype.js"}
{add file="govnokod.js"}
{add file="add.css"}
    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <h1>{if $isEdit}Редактирование <a href="{url route="quoteView" id=$quote->getId()}">говнокода#{$quote->getId()}</a>{else}Накласть говнокод{/if}</h1>
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
                            <td style="vertical-align: top;">{form->caption name="text" value="Код:"}</td>
                            <td>
                                <div id="codeSaveContainer" class="codeInput">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                        <tr>
                                            <td style="vertical-align: top; width: 5%;">
                                                <div id="nums" class="linenumbers"></div>
                                            </td>
                                            <td style="vertical-align: top; width: 95%;">
                                                {if $quote->getText()}{assign var="text" value=$quote->getText()}{else}{assign var="text" value="\n\n\n\n\n"}{/if}
                                                {form->textarea id="codeArea" name="text" value=$text rows="1" cols="50" class="codeArea" onkeyup="numbering(this);" wrap="off"}
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
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>
    <script type="text/javascript">
        var MAX_LINES = 100;
        var linesCountLast;
        var selectedLines = new Array();
        {foreach from=$lines item="line"}
        selectedLines[{$line}] = true;
        {/foreach}
        numbering($('codeArea'));
    </script>