var allreadyLoaded = new Array();

function unfoldCode(codeId)
{
    var codeContent = $('colorCode' + codeId);

    var unfolderController = $('unfoldCode' + codeId);
    var folderController = $('foldCode' + codeId);
    if (unfolderController && folderController) {
        unfolderController.hide();
        folderController.show();
    }

    if (codeContent) {
        var currentHeight = codeContent.getHeight();
        if (allreadyLoaded[codeId] > 0) {
            unfoldCodeEffect(codeContent, currentHeight);
        } else {
            codeContent.setStyle('overflow: hidden; height: ' + currentHeight + 'px;');

            var codePreloader = $('codefolder' + codeId);
            if (codePreloader) {
                var preloadImg = new Element('img', {src: SITE_PATH + '/templates/images/codepreloader.gif', alt: '', title: 'Идёт загрузка...'});
                codePreloader.update(preloadImg);
            }
            new Ajax.Request('/quoter/' + encodeURIComponent(codeId), {
                method: 'get',
                parameters: {format: 'ajax'},
                onSuccess: function(transport) {
                    allreadyLoaded[codeId] = currentHeight;
                    codeContent.update(transport.responseText);
                    unfoldCodeEffect(codeContent, currentHeight);
                }
            });
        }
    }
}

function unfoldCodeEffect(codeContent, currentHeight)
{
    Effect.BlindDown(codeContent, {
        duration: 0.4,
        scaleMode: 'contents',
        restoreAfterFinish: false,
        scaleFrom: Math.ceil((100 / codeContent.scrollHeight) * currentHeight)
    });
}

function foldCode(codeId)
{
    var codeContent = $('colorCode' + codeId);

    var unfolderController = $('unfoldCode' + codeId);
    var folderController = $('foldCode' + codeId);
    if (unfolderController && folderController) {
        unfolderController.show();
        folderController.hide();
    }

    if (codeContent && allreadyLoaded[codeId]) {
        var foldedHeight = allreadyLoaded[codeId];
        Effect.BlindUp(codeContent, {
            duration: 0.4,
            scaleMode: 'contents',
            restoreAfterFinish: false,
            scaleTo: Math.ceil((100 / codeContent.scrollHeight) * foldedHeight),
            afterFinishInternal: function(effect) {
                codeContent.setStyle({overflow: 'hidden', height: foldedHeight + 'px'});
            }
        });
    }
}

function ajaxvote(aElem) {
    var holder = aElem.up();
    var preloadImg = new Element('img', {src: SITE_PATH + '/templates/images/votepreloader.gif', alt: '', title: 'Данные отправляются на сервер...'});
    holder.update('');
    holder.appendChild(preloadImg);
    new Ajax.Request(aElem.href, {
        method: 'post',
        parameters: {ajax: true},
        onSuccess: function(transport) {
            var updateText = '';
            switch (transport.responseText) {
                case 'allready':
                    updateText = 'уже голосовали';
                    break;

                default:
                    updateText = parseInt(transport.responseText);
                    break;
            }
            holder.update(updateText);
        }
    });
}

function numbering(textareaObj) {
    var lines = textareaObj.getValue().split("\n");
    var linesCount = lines.length;

    if (linesCount > MAX_LINES) {
        lines = lines.slice(0, MAX_LINES);
        textareaObj.setValue(lines.join("\n"));
        linesCount = MAX_LINES;
    }

    if (linesCountLast != linesCount) {
        linesCountLast = linesCount;

        var numbersHolder = new Element('span');
        for (var i = 1; i <= linesCount; i++) {
            var aElem = new Element('a', {href: '#', title: 'Отметить эту линию'});
            aElem.appendChild(document.createTextNode(i));

            aElem.onclick = selectLine.bind(aElem);

            numbersHolder.appendChild(aElem);
            numbersHolder.appendChild(document.createTextNode('.'));
            numbersHolder.appendChild(new Element('br'));

            if (selectedLines[i]) {
                aElem.onclick();
            }
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
        selectedLines[lineNumber] = true;
    } else {
        selectedLines[lineNumber] = false;
        var input = $(hiddenIdName);
        if (input) {
            input.remove();
        }
    }

    return false;
}