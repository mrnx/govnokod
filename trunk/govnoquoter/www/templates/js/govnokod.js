var commentsPreloader = new Image();
commentsPreloader.src = SITE_PATH + '/templates/images/commentsload.gif';

var codePreloader = new Image();
codePreloader.src = SITE_PATH + '/templates/images/codeload.gif';

var votePreloader = new Image();
votePreloader.src = SITE_PATH + '/templates/images/govnovote.gif';

var commentVotePreloader = new Image();
commentVotePreloader.src = SITE_PATH + '/templates/images/commentvote.gif';

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
    formElem.action = currentShowTrigger.href;
    formElem.down('textarea').focus();
    Effect.ScrollTo(formElem, {duration: durationValue, offset: offsetValue});
}

function moveCommentForm(commentId, folderId, aElemTrigger)
{
    if (aElemTrigger == currentShowTrigger) {
        return;
    }

    var formElem = $('commentForm_' + folderId);
    var nowHolder = $('answerForm_' + folderId + '_' + commentId);
    if (formElem && nowHolder) {
        var errors = formElem.down('dl.errors');
        if (errors) {
            errors.remove();
        }

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

    var preloader = new Element('img', {src: commentsPreloader.src, 'alt': 'Загрузка…', title: 'Загрузка списка комментариев'});
    commentsHolder.insert(' ').insert(preloader);

    new Ajax.Request(url, {
        method: 'get',
        parameters: {onlyComments: true},
        onSuccess: function(transport) {
            commentsHolder.update(transport.responseText);
        },
        onFailure: function() {
            preloader.remove();
            alert("Ошибка загрузки списка комментариев!\nОбновите страницу и попытайтесь еще раз…");
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

function unfoldCode(codeId)
{
    var trigger = $('trigger_' + codeId);
    if (!trigger) {
        return;
    }

    var entryHolder = trigger.up('.entry-content');

    new Insertion.After(trigger, new Element('img', {className: 'preloader', src: codePreloader.src, 'alt': 'Загрузка…', title: 'Загрузка кода…'}));
    trigger.remove();

    var currentHeight = entryHolder.getHeight();

    new Ajax.Request('/quoter/' + encodeURIComponent(codeId), {
        method: 'get',
        parameters: {format: 'ajax'},
        onSuccess: function(transport) {
            entryHolder.update(transport.responseText);

            Effect.BlindDown(entryHolder, {
                duration: 0.4,
                scaleMode: 'contents',
                restoreAfterFinish: false,
                scaleFrom: Math.ceil((100 / entryHolder.scrollHeight) * currentHeight),
                afterFinishInternal: function(effect) {
                    effect.element.undoClipping();
                    effect.element.setStyle({height: ''});
                }
            });
        },
        onFailure: function() {
            alert('Something went wrong…');
        }
    });
}

function vote(trigger)
{
    var holder = trigger.up('p.vote');
    if (holder) {
        var url = trigger.href;
        holder.update(new Element('img', {className: 'preloader', src: votePreloader.src, 'alt': 'Загрузка…', title: 'Идёт учет голоса…'}));

        new Ajax.Request(url, {
            method: 'get',
            parameters: {format: 'ajax'},
            onSuccess: function(transport) {
                holder.update(transport.responseText);
            },
            onFailure: function() {
                alert('Something went wrong…');
            }
        });
    }
}

function commentvote(trigger)
{
    var holder = trigger.up('span.comment-vote');
    if (holder) {
        var url = trigger.href;
        holder.update(new Element('img', {className: 'preloader', src: commentVotePreloader.src, 'alt': 'Загрузка…', title: 'Идёт учет голоса…'}));

        new Ajax.Request(url, {
            method: 'get',
            parameters: {format: 'ajax'},
            onSuccess: function(transport) {
                holder.update(transport.responseText);
            },
            onFailure: function() {
                alert('Something went wrong…');
            }
        });
    }
}
/*
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