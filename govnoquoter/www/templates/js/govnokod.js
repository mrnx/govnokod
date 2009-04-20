var commentsPreloader = new Image();
commentsPreloader.src = SITE_PATH + '/templates/images/commentsload.gif';

var currentShowTrigger;
function showCommentForm(formElem, aElemTrigger, durationValue, offsetValue)
{
    if (currentShowTrigger) {
        currentShowTrigger.removeClassName('selected');
    }
    currentShowTrigger = aElemTrigger;
    currentShowTrigger.addClassName('selected');

    durationValue = durationValue || 0.4;
    offsetValue = offsetValue || 0;

    formElem.show();
    formElem.action = aElemTrigger.href;
    formElem.down('textarea').focus();
    Effect.ScrollTo(formElem, {duration: durationValue, offset: offsetValue});
}

function moveCommentForm(commentId, folderId, aElemTrigger)
{
    var formElem = $('commentForm_' + folderId);
    var nowHolder = $('answerForm_' + folderId + '_' + commentId);
    if (formElem && nowHolder) {
        formElem.remove();
        nowHolder.update(formElem);
        showCommentForm(formElem, aElemTrigger, 0.7, -100);
    }
}

function loadComments(aElemTrigger)
{
    var commentsHolder = aElemTrigger.up();
    var url = aElemTrigger.href;
    new Insertion.After(aElemTrigger, aElemTrigger.innerHTML);
    aElemTrigger.remove();

    commentsHolder.insert(' ').insert(new Element('img', {src: commentsPreloader.src, 'alt': 'Загрузка…', title: 'Загрузка списка комментариев'}));

    new Ajax.Request(url, {
        method: 'get',
        parameters: {onlyComments: true},
        onSuccess: function(transport) {
            commentsHolder.update(transport.responseText);
        },
        onFailure: function() {
            alert('Something went wrong…');
        }
    });
}

function postCommentsForm(formElem)
{
    var formParent = formElem.up();

    var reg = /^answerForm_(\d+)_(\d+)$/;
    var matches = formParent.id.match(reg);
    if (matches) {
        var url = formElem.action;
        var data = formElem.serialize(true);
        data.ajax = true;

        formElem.disable();

        var folderId = matches[1];
        var replyTo = matches[2];

        var baseHolder = (replyTo == 0) ? $('comments_' + folderId) : formElem.up('.hcomment');

        new Ajax.Request(url, {
            method: 'post',
            parameters: data,
            onSuccess: function(transport) {
                if (baseHolder) {
                    formParent.update(transport.responseText);
                    var newComment = null;
                    if (newComment = formParent.down('.new')) {
                        newComment.remove();

                        if (replyTo != 0) {
                            var ulForNewComment = new Element('ul');
                            ulForNewComment.insert(newComment);
                            newComment = ulForNewComment;
                        }

                        baseHolder.insert(newComment);
                        Effect.ScrollTo(newComment, {duration: 0.7, offset: -100});
                    }
                }
            },
            onFailure: function() {
                alert('Something went wrong…');
            }
        });
    }
}

var allreadyLoaded = new Array();

function unfoldCode(codeId, trigger)
{
    var entryHolder = trigger.up('.entry-content');

    var currentHeight = entryHolder.getHeight();

    entryHolder.setStyle({overflow: 'hidden', height: currentHeight + 'px;'});

        new Ajax.Request('/quoter/' + encodeURIComponent(codeId), {
                method: 'get',
                parameters: {format: 'ajax'},
                onSuccess: function(transport) {
                    allreadyLoaded[codeId] = currentHeight;
                    entryHolder.update(transport.responseText);

                    Effect.BlindDown(entryHolder, {
                        duration: 0.4,
                        scaleMode: 'contents',
                        restoreAfterFinish: false,
                        scaleFrom: Math.ceil((100 / entryHolder.scrollHeight) * currentHeight)
                    });

                }
            });

    /*
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
                var preloadImg = new Element('img', {src: loadingImage.src, alt: '', title: 'Идёт загрузка...'});
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
    */
}

/*
var loadingImage = new Image();
loadingImage.src = SITE_PATH + '/templates/images/codepreloader.gif';

var votePreloaderImage = new Image();
votePreloaderImage.src = SITE_PATH + '/templates/images/votepreloader.gif';

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
                var preloadImg = new Element('img', {src: loadingImage.src, alt: '', title: 'Идёт загрузка...'});
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
    var preloadImg = new Element('img', {src: votePreloaderImage.src, alt: '', title: 'Данные отправляются на сервер...'});
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
                    var newRating = parseInt(transport.responseText);
                    updateText = new Element('span', {className: ((newRating > 0) ? 'rate_plus' : 'rate_minus')});
                    updateText.insert(newRating);
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
*/