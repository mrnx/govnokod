{if $listAll}{title append="информационный портал нового поколения"}{else}{/if}

{add file="prototype.js"}
{add file="effects.js"}
{literal}
<script type="text/javascript">
    var allreadyLoaded = new Array();

    function unfoldCode(codeId)
    {
        //$('unfoldCode' + codeId).hide();
        //$('foldCode' + codeId).show();
        var codeContent = $('colorCode' + codeId);

        if (codeContent) {
            if (allreadyLoaded[codeId] > 0) {
                var currentHeight = codeContent.getHeight();
                Effect.BlindDown(codeContent, {
                    duration: 0.4,
                    scaleMode: 'contents',
                    restoreAfterFinish: false,
                    scaleFrom: Math.ceil((100 / codeContent.scrollHeight) * currentHeight)
                });
            } else {
                var currentHeight = codeContent.getHeight();
                codeContent.setStyle('overflow: hidden; height: ' + currentHeight + 'px;');
                new Ajax.Request('/quoter/' + encodeURIComponent(codeId), {
                    method: 'get',
                    parameters: {format: 'ajax'},
                    onSuccess: function(transport) {
                        allreadyLoaded[codeId] = currentHeight;
                        codeContent.update(transport.responseText);
                        Effect.BlindDown(codeContent, {
                            duration: 0.4,
                            scaleMode: 'contents',
                            restoreAfterFinish: false,
                            scaleFrom: Math.ceil((100 / codeContent.scrollHeight) * currentHeight)
                        });
                    }
                });
            }
        }
    }

    function foldCode(codeId)
    {
        //$('unfoldCode' + codeId).show();
        //$('foldCode' + codeId).hide();

        var codeContent = $('colorCode' + codeId);
        if (codeContent) {
            var foldedHeight = allreadyLoaded[codeId];
            Effect.BlindUp(codeContent, {
                duration: 0.4,
                scaleMode: 'contents',
                restoreAfterFinish: false,
                scaleTo: Math.ceil((100 / codeContent.scrollHeight) * foldedHeight),
                afterFinishInternal: function(effect) {
                    codeContent.setStyle({overflow: 'hidden', height: foldedHeight + 'px'}).show();
                }
            });
        }
    }
</script>
{/literal}
{foreach from=$quotes item="quote"}
    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <p class="rate">[ <a href="#" onclick="alert('coming soon'); return false;">+</a> 32 <a href="#" onclick="alert('coming soon'); return false;">-</a> ]</p>
                <h2><a href="{url route="withAnyParam" action="list" name=$quote->getCategory()->getName()}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="withId" action="" id=$quote->getId()}">Говнокод#{$quote->getId()}</a></h2>
                {*
                <a href="{url route="withId" action="" id=$quote->getId()}" id="unfoldCode{$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" style="border-bottom: 1px dashed; text-decoration: none;">+показать код</a>
                <a href="{url route="withId" action="" id=$quote->getId()}" id="foldCode{$quote->getId()}" onclick="foldCode({$quote->getId()}); return false;" style="display: none; border-bottom: 1px dashed; text-decoration: none;">-свернуть</a>
                <br /><br />*}
                <div class="colorCode" id="colorCode{$quote->getId()}">
                    <div class="numbers">
                        {foreach from=$quote->generateLines(15) item="line" name="lineIterator"}{$line}{if !$smarty.foreach.lineIterator.last}<br />{/if}{/foreach}
                        {if $quote->getLinesCount() > 15}
                            <br />…<br />
                            <a href="#" onclick="unfoldCode({$quote->getId()}); return false;">{$quote->getLinesCount()}</a>
                        {/if}
                    </div>
                    <div class="code">
                        {$quote->getText(15)|highlite:$quote->getCategory()->getName()}
                        {if $quote->getLinesCount() > 15}
                            <a href="#" onclick="unfoldCode({$quote->getId()}); return false;">...</a>
                        {/if}
                    </div>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/des/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/des/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>
{/foreach}
{*
<div class="right-block">
	<div class="block">
    	<div class="top">&nbsp;</div>
            <div class="content">
              <ul>
                <li><a href="#">php</a></li>
                <li><a href="#">java</a></li>
                <li><a href="#">css</a></li>
              </ul>
            </div>
    	<div class="bottom">&nbsp;</div>
    </div>
</div>*}