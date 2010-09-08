<?php
$user = $toolkit->getUser();
if ($user->isLoggedIn()) {
    if ($user->getId() == $quote->getUser()->getId()) {
?>
    <span class="vote-on" title="Я не могу голосовать за собственный код">&darr;</span>
    <strong<?php if ($quote->getRating() < 0) echo ' class="bad"';?> title="<?php echo $quote->getRatingsOn(); ?> за и <?php echo $quote->getRatingsAgainst(); ?> против"><?php if ($quote->getRating() > 0) { echo '+'; } elseif ($quote->getRating() < 0) { echo '&minus;'; } echo abs($quote->getRating()); ?></strong>
    <span class="vote-against" title="Я не могу голосовать за собственный код">&uarr;</span>
<?php
    } else {
        $current_user_rate = $quote->getCurrentUserRate();
        if ($current_user_rate) {
?>
    <?php if ($current_user_rate == -1) { ?><span class="vote-on my-vote" title="Мой голос"><?php } else { ?><span class="vote-on"><?php } ?>&darr;</span>
    <strong<?php if ($quote->getRating() < 0) echo ' class="bad"';?> title="<?php echo $quote->getRatingsOn(); ?> за и <?php echo $quote->getRatingsAgainst(); ?> против"><?php if ($quote->getRating() > 0) { echo '+'; } elseif ($quote->getRating() < 0) { echo '&minus;'; } echo abs($quote->getRating()); ?></strong>
    <?php if ($current_user_rate == 1) { ?><span class="vote-against my-vote" title="Мой голос"><?php } else { ?><span class="vote-against"><?php } ?>&uarr;</span>
<?php
        } else {
?>
    <a class="vote-against" rel="nofollow" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/ratings/code/' . $quote->getId() . '/against/'); ?>" title="Минусну!">&darr;</a>
    <strong<?php if ($quote->getRating() < 0) echo ' class="bad"';?> title="<?php echo $quote->getRatingsOn(); ?> за и <?php echo $quote->getRatingsAgainst(); ?> против"><?php if ($quote->getRating() > 0) { echo '+'; } elseif ($quote->getRating() < 0) { echo '&minus;'; } echo abs($quote->getRating()); ?></strong>
    <a class="vote-on" rel="nofollow" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/ratings/code/' . $quote->getId() . '/on/'); ?>" title="Плюсану!">&uarr;</a>
<?php
        }
    }
} else {
?>
    <strong class="just-rating<?php if ($quote->getRating() < 0) echo ' bad';?>" title="<?php echo $quote->getRatingsOn(); ?> за и <?php echo $quote->getRatingsAgainst(); ?> против"><?php if ($quote->getRating() > 0) { echo '+'; } elseif ($quote->getRating() < 0) { echo '&minus;'; } echo abs($quote->getRating()); ?></strong>
<?php
}
?>