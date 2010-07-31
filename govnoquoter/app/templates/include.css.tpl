<?php
if (isset($__media['css'])) {
    foreach ($__media['css'] as $file => $cssitem) {
?>
    <link rel="stylesheet" type="text/css" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/css/' . $file); ?>" media="screen" />
<?php
    }
}
?>