<?php echo $this->render('service/mail/header.tpl'); ?>
Hello, <b><?php echo htmlspecialchars($you->getLogin()); ?></b>!<br />
<br />
Пользователь <a href="<?php echo htmlspecialchars($this->url('user-profile', array('id' => $him->getId()))); ?>"><?php echo htmlspecialchars($you->getLogin()); ?></a> ответил на Ваш комментарий к <a href="<?php echo htmlspecialchars($this->url('quoteView', array('id' => $quote->getId()))); ?>">говнокоду #<?php echo $quote->getId(); ?></a>!<br />
<br />
Напомним, Вы написали:<br />
<em><?php echo $this->bbcode(nl2br(htmlspecialchars(trim($yourComment->getText())))); ?></em>
<br />
<br />
На что получили <a href="{$commentsFolder->getDefaultBackUrl()|h}#comment{$answerComment->getId()}">ответ</a>:<br />
<em><?php echo $this->bbcode(nl2br(htmlspecialchars(trim($answerComment->getText())))); ?></em>
<br /><br /><br />
С уважением, Ваш <a href="{url route="default"}">Говнокод</a>.