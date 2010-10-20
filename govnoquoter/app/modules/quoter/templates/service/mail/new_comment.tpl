<?php echo $this->render('service/mail/header.tpl'); ?>
Hello, <b><?php echo htmlspecialchars($quoteUser->getLogin()); ?></b>!<br />
<br />
Между прочим, у Вашего <a href="<?php echo htmlspecialchars($this->url('quoteView', array('id' => $quote->getId()))); ?>" title="Перейти к просмотру говнокода">говнокода #<?php echo $quote->getId(); ?></a>
появился <a href="<?php echo htmlspecialchars($this->url('quoteView', array('id' => $quote->getId()))); ?>#comment<?php echo $comment->getId(); ?>" title="Перейти к чтению комментария">новый комментарий</a>!<br />
<br />
<em><?php echo $this->bbcode(nl2br(htmlspecialchars(trim($comment->getText())))); ?></em>

<?php echo $this->render('service/mail/footer.tpl'); ?>