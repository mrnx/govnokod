<?php
if (isset($__media['js'])) {
    foreach ($__media['js'] as $file => $jsitem) {
?>
    <script type="text/javascript" src="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/js/' . $file); ?>"></script>
<?php
    }
}
?>