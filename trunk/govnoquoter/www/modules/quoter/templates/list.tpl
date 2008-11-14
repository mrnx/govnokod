{add file="prototype.js"}
{add file="effects.js"}
{literal}
<style type="text/css">
td.line {
  color: #999;
  background-color: #F7F7F7;
  border-right: 1px solid #E0E0E0;
  width: 20px;
  text-align: right;
}

.colorCode {
  border: 1px solid #E0E0E0;
  width:100%;
  margin-top: 3px;
}
.codeContent {
  padding-left: 5px;
  overflow: auto;
}

pre {
  margin: 0;
  padding: 0;
}
</style>
<script type="text/javascript">
    function toggleFold(quoteId) {
        var codeContent = $('codeContent' + quoteId);
        var codeLines = $('codeLines' + quoteId);

        if (codeContent && codeLines) {
            if (codeContent.style.height == '150px') {
                unFold(codeContent);
                unFold(codeLines);
            } else {
                fold(codeContent);
                fold(codeLines);
            }
        }
    }

    function fold(elem) {
        Effect.BlindUp(elem, {
            duration: 0.4,
            scaleMode: 'contents',
            restoreAfterFinish: false,
            scaleTo: Math.ceil((100 / elem.scrollHeight) * 150),
            afterFinishInternal: function(effect) {
                elem.setStyle({overflow: 'hidden', height: '150px'}).show();
            }
        });
    }

    function unFold(elem) {
        Effect.BlindDown(elem, {
            duration: 0.4,
            scaleMode: 'contents',
            restoreAfterFinish: false,
            scaleFrom: Math.ceil((100 / elem.scrollHeight) * 150)
        });
    }

    var allreadyLoaded = new Array();

    function unfoldCode(codeId)
    {
        $('unfoldCode' + codeId).hide();
        $('foldCode' + codeId).show();
        var codeContent = $('codeContent' + codeId);

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
        $('unfoldCode' + codeId).show();
        $('foldCode' + codeId).hide();

        var codeContent = $('codeContent' + codeId);
        if (codeContent) {
            var foldedHeight = allreadyLoaded[codeId];
            Effect.BlindUp(codeContent, {
                duration: 0.4,
                scaleMode: 'contents',
                restoreAfterFinish: false,
                scaleTo: Math.ceil((100 / codeContent.scrollHeight) * foldedHeight),
                afterFinishInternal: function(effect) {
                    codeContent.setStyle({overflow: 'hidden', height: foldedHeight + 'px'}).show();
                    //codeContent.show();
                }
            });
        }
    }
</script>
{/literal}

<a href="{if $listAll}{url route="default2" action="add"}{else}{url route="withAnyParam" action="add" name=$category->getName()}{/if}">Накласть говнокод</a>
<br /><br />

{foreach from=$quotes item="quote"}
    <div>
        <table class="colorCode" cellpadding="3" cellspacing="0" border="0">
            <tr>
                <td><a href="{url route="withAnyParam" action="list" name=$quote->getCategory()->getName()}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> - <a href="{url route="withId" action="" id=$quote->getId()}">Говнокод#{$quote->getId()}</a></td>
            </tr>
            <tr>
                <td valign="top" style="width: 20%;">
                    <a href="{url route="withId" action="" id=$quote->getId()}" id="unfoldCode{$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" style="border-bottom: 1px dashed; text-decoration: none;">развернуть</a>
                    <a href="{url route="withId" action="" id=$quote->getId()}" id="foldCode{$quote->getId()}" onclick="foldCode({$quote->getId()}); return false;" style="display: none; border-bottom: 1px dashed; text-decoration: none;">свернуть</a>
                    <br />Всего строк: {$quote->getLinesCount()}
                </td>
                <td valign="top" style="width: 80%;">
                    <div id="codeContent{$quote->getId()}" class="codeContent">
                        {$quote->getText(15)|highlite:$quote->getCategory()->getName()}
                    </div>
                </td>
            </tr>
        </table>
    </div>
{/foreach}