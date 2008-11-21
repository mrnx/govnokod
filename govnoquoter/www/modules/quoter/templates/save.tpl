{title append="Накласть говнокод"}
{add file="prototype.js"}

<style type="text/css">

</style>

    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <h1><span style="color: #DD8C3E">Накласть говнокод</span></h1>
                <form action="{if $isEdit}{url route="withId" action="edit" id=$quote->getId()}{else}{url route="default2" action="add"}{/if}" method="post">
                    <table width="100%" border="0" cellpadding="5" cellspacing="0">
                        <tr>
                            <td style="vertical-align: top;">{form->caption name="category_id" value="Язык"}</td>
                            <td>{form->select name="category_id" options=$categoriesSelect emptyFirst=true value=$currentCategory}</td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top;">{form->caption name="text" value="Код"}</td>
                            <td>
                                <div id="codeSaveContainer" style="height: 350px; overflow-y: scroll;">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                        <tr>
                                            <td style="vertical-align: top;">
                                                <div id="nums" style="text-align: right; font-family: monospace; font-size: 10pt; line-height: 16px;">1.</div>
                                            </td>
                                            <td style="vertical-align: top;">
                                                {form->textarea name="text" value=$quote->getText() rows="15" cols="50" style="background: #EEEEEE; width: 100%; position: relative; height: 340px; border: 0px; font-family: monospace; font-size: 10pt; line-height: 16px; overflow: hidden;"}
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style='vertical-align: top;'>{form->caption name="description" value="Описание"}</td>
                            <td>{form->textarea name="description" value=$quote->getDescription() rows="4" cols="50"}</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>{form->submit name="submit" value="Накласть"}</td>
                        </tr>
                    </table>
                </form>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/des/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/des/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>