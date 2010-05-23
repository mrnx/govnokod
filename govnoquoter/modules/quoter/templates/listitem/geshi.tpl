<?php
    $this->add('langs/' . $quote->getCategory()->getGeshiAlias() . '.css');
    $url = $toolkit->getRequest()->getUrl();
?>
            <li class="hentry">
                <h2><a rel="chapter" href="<?php echo htmlspecialchars($url . '/' . $quote->getCategory()->getName()); ?>"><?php echo htmlspecialchars($quote->getCategory()->getTitle()); ?></a> / <a rel="bookmark" class="entry-title" href="<?php echo htmlspecialchars($url . '/' . $quote->getId()); ?>">Говнокод #<?php echo $quote->getId(); ?></a></h2>
                <p class="vote">
                    {include file="quoter/rating.tpl" quote=$quote}
                </p>
                <div class="entry-content">
<?php
    if ($quote->getLinesCount() > 30) {
?>
                    <ol><?php foreach ($quote->generateLines(15) as $line) { echo '<li>', $line, '</li>'; } ?><li>…</li><li><?php echo $quote->getLinesCount(); ?></li></ol>
                    <?php echo $quote->getGeshiText(15); ?>
                    <a class="trigger" href="<?php echo htmlspecialchars($url . '/' . $quote->getId()); ?>" title="показать весь код">показать весь код +</a>
<?php
    } else {
?>
                    <ol><?php foreach ($quote->generateLines() as $line) { echo '<li>', $line, '</li>'; } ?><li>…</li><li><?php echo $quote->getLinesCount(); ?></li></ol>
                    <?php echo $quote->getGeshiText(); ?>
<?php
    }
?>
                </div>
                <p class="description">
                    <?php echo nl2br($this->bbcode(htmlspecialchars(trim($quote->getDescription())))); /*|trim|h|bbcode|nl2br}*/ ?>
                </p>
                <p class="author">
                    Запостил: <a href="<?php echo htmlspecialchars($url . '/user/' . $quote->getUser()->getId()); ?>"><img src="<?php echo htmlspecialchars($quote->getUser()->getAvatarUrl(20)); ?>" alt="" class="avatar" /></a> <a href="<?php echo htmlspecialchars($url . '/user/' . $quote->getUser()->getId()); ?>"><?php echo htmlspecialchars($quote->getUser()->getLogin()); ?></a>,
                    <abbr title="<?php echo date('c', $quote->getCreated()); ?>"><?php echo i18n::date($quote->getCreated(), 'date2'); ?></abbr>
                </p>
                <div class="entry-comments">
                    <span class="comments-icon<?php if ($toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0) { echo ' comments-new" title="Есть новые комментарии!'; } ?>">&nbsp;</span><a href="<?php echo htmlspecialchars($url . '/' . $quote->getId()); ?>" class="entry-comments-load">Комментарии</a> <span class="entry-comments-count">(<?php echo $quote->getCommentsCount(); if ($toolkit->getUser()->isLoggedIn() && $quote->getNewCommentsCount() > 0) { ?>, <span title="Новые комментарии" class="entry-comments-new">+<?php echo $quote->getNewCommentsCount(); ?></span><?php } ?>)</span>
                </div>
            </li>