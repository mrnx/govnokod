<?php
    $this->add('langs/' . $quote->getCategory()->getGeshiAlias() . '.css');
    $url = $toolkit->getRequest()->getUrl();

    $user_profile_url = $url . '/user/' . $quote->getUser()->getLogin() . '/profile/';

?>
        <h2><a rel="chapter" href="<?php echo htmlspecialchars($url . '/' . $quote->getCategory()->getName()); ?>/"><?php echo htmlspecialchars($quote->getCategory()->getTitle()); ?></a> / <a rel="bookmark" class="entry-title" href="<?php echo htmlspecialchars($url . '/' . $quote->getCategory()->getName() . '/' . $quote->getId()); ?>">Говнокод #<?php echo $quote->getId(); ?></a></h2>
        <p class="vote">
            <?php echo $this->render('quoter/rating.tpl', array('quote' => $quote)); ?>
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
        <p class="description"><?php echo nl2br($this->bbcode(htmlspecialchars(trim($quote->getDescription())))); /*|trim|h|bbcode|nl2br}*/ ?></p>
        <p class="author">
            Запостил: <a href="<?php echo htmlspecialchars($user_profile_url); ?>"><img src="<?php echo htmlspecialchars($quote->getUser()->getAvatarUrl(20)); ?>" alt="" class="avatar" /></a> <a href="<?php echo htmlspecialchars($user_profile_url); ?>"><?php echo htmlspecialchars($quote->getUser()->getLogin()); ?></a>,
            <abbr title="<?php echo date('c', $quote->getCreated()); ?>"><?php echo i18n::date($quote->getCreated(), 'date2'); ?></abbr>
        </p>