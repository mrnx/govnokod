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
    <div>
        <table class="colorCode" cellpadding="3" cellspacing="0" border="0">
            <tr>
                <td valign="top" style="width: 20%;">
                    <br />Язык: {$quote->getCategory()->getTitle()|htmlspecialchars}
                    <br />Автор: {$quote->getUsername()}
                    <br />Всего строк: {$quote->getLinesCount()}
                </td>
                <td valign="top" style="width: 80%;">
                    <div id="codeContent{$quote->getId()}" class="codeContent">
                        {$quote->getText()|highlite:$quote->getCategory()->getName()}
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />