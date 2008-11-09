{literal}
<style type="text/css">
span, td {
  background-color: white;
}
body {
  padding: 0;
  margin: 0;
  font-family: tahoma, verdana, arial;
}
#content {
  font-family:arial,verdana,helvetica,sans-serif;
  line-height: 130%;
  padding: 30px;
  padding-top: 0px;
}

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
}
</style>
<script type="text/javascript">
    function toggleFold(quoteId) {
        var codeContent = $('codeContent' + quoteId);
        var codeLines = $('codeLines' + quoteId);

        if (codeContent && codeLines) {
            if (codeContent.style.overflow == 'hidden') {
                unFold(codeContent);
                unFold(codeLines);
            } else {
                fold(codeContent);
                fold(codeLines);
            }
        }
    }

    function unFold(elem) {
        //Effect.BlindDown(elem, {scaleMode: 'contents'});
        elem.setStyle({overflow: '', height: '100%'});
    }

    function fold(elem) {
        //Effect.BlindUp(elem, {scaleMode: 'contents'});
        elem.setStyle({overflow: 'hidden', height: '150px'});
    }
</script>
{/literal}
<table>
{foreach from=$quotes item="quote"}
    <tr>
        <td>
            <table class="colorCode" cellpadding="3" cellspacing="0" border="0">
                <tr>
                    <td>{$quote->getUsername()} <a href="#" onclick="toggleFold({$quote->getId()}); return false;">сдвинуть\разодвинуть</a></td>
                </tr>
                <tr>
                    <td class="line" valign="top">
                        <div id="codeLines{$quote->getId()}" class="codeLines" style="height: 150px; overflow: hidden;">
                            <pre>
{foreach from=$quote->generateLines() item="line"}{$line}
{/foreach}
                            </pre>
                        </div>
                    </td>
                    <td valign="top"><div id="codeContent{$quote->getId()}" class="codeContent" style="height: 150px; overflow: hidden;">{$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getId()}</div></td>
                </tr>
            </table>

        </td>
    </tr>
{/foreach}
</table>