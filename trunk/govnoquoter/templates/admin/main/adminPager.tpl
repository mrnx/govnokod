<?php
if ($pager->getPagesTotal() > 1) {
    $prev = $pager->getPrev();
    $next = $pager->getNext();
    if (!is_null($prev)) {
?>
    <a href="<?php echo htmlspecialchars($prev); ?>">Предыдущая</a>
<?php } else { ?>
    Предыдущая
<?php
    }

    foreach ($pages as $page) {
        if (!empty($page['skip'])) {
            echo '...';
        } else if (!empty($page['current'])) {
?>
    &nbsp;<strong><?php echo $page['page']; ?></strong>&nbsp
<?php
        } else {
?>
    &nbsp;<a href="<?php echo htmlspecialchars($page['url']); ?>"><?php echo $page['page']; ?></a>&nbsp;
<?php
        }
    }

    if (!is_null($next)) {
?>
    <a href="<?php echo htmlspecialchars($next); ?>">Следующая</a>
<?php } else { ?>
    Следующая
<?php
    }
}
?>