{if $isEdit}
    <div class="jipTitle">Редактирование комментария</div>
    {form action=$action method="post" jip=true}
    <div class="addCommentForm">
        {form->hidden name="url" value=$url}
        <span>{form->caption name="username" value="Имя пользователя:"} {form->text name="username" value=$username maxlength="25"}</span>
        {if $errors->has('text')}<span style="color: red; font-weight: bold;">{$errors->get('text')}</span><br />{/if}
        {form->textarea name="text" style="width: 99%;" value=$text rows="6" cols="20"}
        {form->submit name="submit" value="_ send" style="font-size: 90%; width: auto; overflow:visible;"} {form->reset jip=true name="reset" value="_ simple/cancel" style="font-size: 90%;"}
    </div>
    </form>
{else}
<div class="rounded-box comment">
    <b class="r10"></b><b class="r7"></b><b class="r5"></b><b class="r4"></b><b class="r3"></b><b class="r2"></b><b class="r2"></b><b class="r1"></b><b class="r1"></b><b class="r1"></b>
    <div class="inner-box">
        <table>
            <tr>
                <td style="vertical-align: top;">
                    <h2 class="addCommentTitle"><a name="addcomment"></a>Добавить комментарий</h2>
                    <form action="{$action}" method="post">
                    <table class="addcomment">
                        <tr>
                            <td>{form->caption name="username" value="Представьтесь:"}</td>
                            <td>{if $errors->has('username')}<span class="fielderror">{$errors->get('username')}</span><br />{/if}{form->text name="username" value=$username maxlength="50" size="25" style="font-size:18px;"} {form->checkbox name="remember" label="запомнить" value=$remember}</td>
                        </tr>
                        <tr>
                            <td>{form->caption name="text" value="Наберите:"}</td>
                            <td>{if $errors->has('text')}<span class="fielderror">{$errors->get('text')}</span><br />{/if}{form->textarea name="text" style="font-size:18px;width:100%" value=$text rows="8" cols="45"}</td>
                        </tr>
                        <tr>
                            <td>{form->caption name="captcha" value="Повторите:"}</td>
                            <td class="captcha">
                            {if $errors->has('text')}<span class="fielderror">{$errors->get('captcha')}</span><br />{/if}
                            {form->captcha name="captcha"}
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>{form->submit name="submit" value="Готово!" style="font-size: 24px;" onclick="this.disable();"}</td>
                        </tr>
                    </table>
                    {form->hidden name="url" value=$url}
                    </form>
                </td>
                <td style="vertical-align: top;">
                    <h3>Поддерживаются bbcode:</h3>
                    {assign var="quoteSample" value="[quote=Говногость]Цитата[/quote]"}
                    <p>{$quoteSample}</p>
                    {$quoteSample|bbcode}
                    <p>&nbsp;</p>
                    {assign var="codeSample" value="[code=php]&lt;?php echo 'test'; ?&gt;[/code]"}
                    <p>{$codeSample}</p>
                    {$codeSample|bbcode}
                    <p>&nbsp;</p>
                    {assign var="styleSample" value="[b]жирный[/b] [i]курсив[/i] [u]подчеркнутый[/u] [s]перечеркнутый[/s]"}
                    <p>{$styleSample}</p>
                    {$styleSample|bbcode}
                    <p>&nbsp;</p>
                    <p>and more…</p>
                </td>
            </tr>
        </table>
    </div>
    <b class="r1"></b><b class="r1"></b><b class="r1"></b><b class="r2"></b><b class="r2"></b><b class="r3"></b><b class="r4"></b><b class="r5"></b><b class="r7"></b><b class="r10"></b>
</div>
{/if}