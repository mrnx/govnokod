<?php
if (isset($__media['js'])) {
    $externals = array();
    foreach ($__media['js'] as $file => $jsitem) {
        if ($jsitem['join']) {
            $externals[] = $file;
        } else {
?>
    <script type="text/javascript" src="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/js/' . $file); ?>"></script>
<?php
        }
?>
<?php
    }
    if ($externals) {
        $externals_string = join(',', $externals);
?>
    <script type="text/javascript" src="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/media/' . md5($externals_string)); ?>.js?files=<?php echo htmlspecialchars($externals_string); ?>&amp;v=3"></script>
<?php
    }
}
?>