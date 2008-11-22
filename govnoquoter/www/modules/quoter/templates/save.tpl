{title append="Накласть говнокод"}
{add file="prototype.js"}
{add file="add.css"}
{literal}
    <script type="text/javascript">
        var linesCountLast;
        function numbering(textareaObj) {
            var lines = textareaObj.getValue().split("\n");
            var linesCount = lines.length;

            if (linesCount > 100) {
                lines = lines.slice(0, 100);
                textareaObj.setValue(lines.join("\n"));
                linesCount = 100;
            }

            if (linesCountLast != linesCount) {
                linesCountLast = linesCount;

                var numbersHolder = new Element('span');
                for (var i = 1; i <= linesCount; i++) {
                    var aElem = new Element('a', {href: '#', title: 'Отметить эту линию', onclick: 'return false;'});
                    aElem.appendChild(document.createTextNode(i));

                    aElem.observe('click', selectLine);

                    numbersHolder.appendChild(aElem);
                    numbersHolder.appendChild(document.createTextNode('.'));
                    numbersHolder.appendChild(new Element('br'));
                }

                textareaObj.style.height = linesCount * 16 + 'px';
                $('codeSaveContainer').style.height = textareaObj.style.height;
                $('nums').update(numbersHolder);
            }
        }

        function selectLine(event) {
            var lineNumber = parseInt(this.innerHTML);
            this.toggleClassName('active');

            var hiddenIdName = 'linenumber' + lineNumber;

            if (this.hasClassName('active')) {
                var input = new Element('input', {name: 'lines[]', id: hiddenIdName, type: 'hidden', value: lineNumber});
                $('linesInput').appendChild(input);
            } else {
                var input = $(hiddenIdName);
                if (input) {
                    input.remove();
                }
            }
        }
    </script>
{/literal}

    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
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
                                <div id="codeSaveContainer" class="codeInput">
                                    <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                        <tr>
                                            <td style="vertical-align: top; width: 5%;">
                                                <div id="nums" class="linenumbers">1.</div>
                                            </td>
                                            <td style="vertical-align: top; width: 95%;">
                                                {form->textarea name="text" value=$quote->getText() rows="15" cols="50" class="codeArea" onkeyup="numbering(this);" wrap="off"}
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