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
                var preloadImg = new Element('img', {src: SITE_PATH + '/templates/des/codepreloader.gif', alt: '', title: 'Идёт загрузка...'});
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