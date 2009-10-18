var commentsPreloader = new Image();
commentsPreloader.src = SITE_PATH + '/templates/images/commentsload.gif';

var codePreloader = new Image();
codePreloader.src = SITE_PATH + '/templates/images/codeload.gif';

var votePreloader = new Image();
votePreloader.src = SITE_PATH + '/templates/images/govnovote.gif';

var commentVotePreloader = new Image();
commentVotePreloader.src = SITE_PATH + '/templates/images/commentvote.gif';

var comments;
var code;
(function($) {
    comments = {
        load: function (aElemTrigger) {
            var commentsLoadUrl = aElemTrigger.attr('href');

            var commentsHolder = aElemTrigger.parent();
            aElemTrigger.replaceWith(aElemTrigger.text());

            var preloader = $('<img src="' + commentsPreloader.src + '" alt="Загрузка" title="Загрузка списка комментариев…" />');
            commentsHolder.append(preloader);

            $.ajax({
                url: commentsLoadUrl,
                data: {onlyComments: true},
                success: function(msg){
                    commentsHolder.fadeOut(0);
                    commentsHolder.html(msg);
                    commentsHolder.fadeIn(300);

                    //Если подключен jshighlight, то ищем все [code] теги в комментариях и пробуем их подсветить
                    if (typeof(hljs) == 'object') {
                        commentsHolder.find('pre code').each(function() {
                            hljs.highlightBlock(this);
                        });
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    preloader.remove();
                    alert("Ошибка загрузки списка комментариев!\nОбновите страницу и попытайтесь еще раз");
                }
            });
        },

        moveForm: function(commentId, folderId, aElemTrigger) {
            if ($(aElemTrigger).hasClass('selected')) {
                return false;
            }

            var formElem = $('#commentForm_' + folderId);
            var nowHolder = $('#answerForm_' + folderId + '_' + commentId);

            if (formElem && nowHolder) {
                var errors = formElem.find('dl.errors');
                if (errors) {
                    errors.remove();
                }

                nowHolder.append(formElem);

                $(aElemTrigger).closest('div.entry-comments').find('a.selected').removeClass('selected');

                $(aElemTrigger).addClass('selected');

                formElem.show();
                formElem.attr('action', aElemTrigger.href);
                formElem.find('textarea').focus();

                $.scrollTo(formElem, 500, {offset: -200});
                //$("html:not(:animated),body:not(:animated)").animate({scrollTop: formElem.offset().top - 200}, 500);
            }
        },

        postForm: function(formElem) {
            formElem = $(formElem);
            var formParent = formElem.parent();
            var reg = /^answerForm_(\d+)_(\d+)$/;
            var matches = formParent.attr('id').match(reg);
            if (matches) {
                var formUrl = formElem.attr('action');
                var formData = formElem.serialize();

                formElem.find('input, textarea, select').attr('disabled', 'disabled');
                var folderId = matches[1];
                var replyTo = matches[2];

                var baseHolder = (replyTo == 0) ? $('#comments_' + folderId) : formElem.closest('.hcomment');
                $.ajax({
                    url: formUrl,
                    type: "POST",
                    data: formData + '&ajax=true',
                    success: function(msg) {
                        if (baseHolder) {
                            formParent.empty();
                            if (msg.match(/<li class="hcomment new">/)) {
                                baseHolder.closest('div.entry-comments').find('a.selected').removeClass('selected');

                                if (replyTo != 0) {
                                    baseHolder.append($('<ul/>').append(msg));
                                } else {
                                    baseHolder.append(msg);
                                }

                                var newComment = baseHolder.find('li.new');
                                if (newComment) {
                                    newComment.removeClass('new');
                                    $.scrollTo(newComment, 500, {offset: -100});
                                    //$("html:not(:animated),body:not(:animated)").animate({scrollTop: newComment.offset().top - 100}, 500);
                                }
                            } else {
                                formParent.html(msg);
                            }
                        }
                    }
                });
            }
        },

        vote: function(aElemTrigger) {
            var holder = aElemTrigger.closest('span.comment-vote');
            if (holder) {
                var voteUrl = aElemTrigger.attr('href');
                var preloader = $('<img src="' + commentVotePreloader.src + '" class="preloader" alt="Загрузка" title="Идёт учет голоса…" />');
                holder.html(preloader);

                $.ajax({
                    url: voteUrl,
                    data: {format: 'ajax'},
                    success: function(msg) {
                        holder.html(msg);
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        preloader.remove();
                        alert("Ошибка учета голоса!\nОбновите страницу и попытайтесь еще раз");
                    }
                });
            }
        },

        toggleBBCodeBlock: function(aElemTrigger) {
            $(aElemTrigger).parent().find('.bbcodes').toggle();
        }
    }

    code = {
        unfold: function(aElemTrigger) {
            var codeLoadUrl = aElemTrigger.attr('href');
            var entryHolder = aElemTrigger.parent('.entry-content');
            if (entryHolder) {
                var preloader = $('<img src="' + codePreloader.src + '" class="preloader" alt="Загрузка" title="Загрузка кода…" />');
                aElemTrigger.replaceWith(preloader);

                $.ajax({
                    url: codeLoadUrl,
                    data: {format: 'ajax'},
                    success: function(msg) {
                        var currentHeight = entryHolder.height();
                        entryHolder.html(msg);
                        var nowHeight = entryHolder.height();
                        entryHolder.css({overflow: 'hidden', height: currentHeight});
                        entryHolder.animate({height: nowHeight}, 400, function() { $(this).removeAttr('style'); });
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        preloader.remove();
                        alert("Ошибка загрузки кода!\nОбновите страницу и попытайтесь еще раз");
                    }
                });
            }
        },

        vote: function(aElemTrigger) {
            var holder = aElemTrigger.closest('p.vote');
            if (holder) {
                var voteUrl = aElemTrigger.attr('href');
                var preloader = $('<img src="' + votePreloader.src + '" class="preloader" alt="Загрузка" title="Идёт учет голоса…" />');
                holder.html(preloader);

                $.ajax({
                    url: voteUrl,
                    data: {format: 'ajax'},
                    success: function(msg) {
                        holder.html(msg);
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown){
                        preloader.remove();
                        alert("Ошибка учета голоса!\nОбновите страницу и попытайтесь еще раз");
                    }
                });
            }
        }
    }

    $(function() {
        $('a.entry-comments-load').click(function() {
            comments.load($(this));
            return false;
        });

        $('.vote a').live('click', function() {
            code.vote($(this));
            return false;
        });

        $('.comment-vote a').live('click', function() {
            comments.vote($(this));
            return false;
        });

        $('.entry-content a.trigger').click(function(){
            code.unfold($(this));
            return false;
        });

        $('#expand-trigger').click(function() {
            $('#userpane').toggleClass('expanded');
            return false;
        });

        //Если вдруг подключили js higlight драйвер
        if (typeof(hljs) == 'object') {
            hljs.initHighlighting();
        }
    });
})(jQuery);