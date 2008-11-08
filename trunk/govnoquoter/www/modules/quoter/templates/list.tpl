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
{/literal}
<table>
{foreach from=$quotes item="quote"}
    <tr>
        <td>
            <table class="colorCode" cellpadding="3" cellspacing="0" border="0">
                <tr>
                    <td class="line" valign="top" style="font-family: monospace; width: 20px; text-align: right;">
                        <pre>
{foreach from=$quote->generateLines() item="line"}{$line}
{/foreach}
                        </pre>
                    </td>
                    <td valign="top"><div class="codeContent">{$quote->getText()|highlite:$quote->getCategory()->getName()}</div></td>
                </tr>
            </table>

        </td>
    </tr>
{/foreach}
</table>