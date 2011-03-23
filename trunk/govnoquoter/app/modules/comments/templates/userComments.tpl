
<ul>
<?php foreach ($comments as $comment) { ?>
<li><?php echo $this->bbcode(nl2br(htmlspecialchars($comment->getText()))); ?></li>
<?php }?>
</ul>