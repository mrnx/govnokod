<ol id="language">
<?php
    $url = $toolkit->getRequest()->getUrl();
    foreach ($categories as $category_tmp) {
?>
    <li><a href="<?php echo htmlspecialchars($url . '/' . $category_tmp->getName()); ?>"><?php echo htmlspecialchars($category_tmp->getTitle()); ?></a> <span>(<?php echo $category_tmp->getQuoteCounts(); ?>)</span></li>
<?php
    }
    unset($categories);
?>
</ol>