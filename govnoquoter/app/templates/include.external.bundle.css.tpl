<?php
if (isset($__media['css'])) {
    $externals = array();
    foreach ($__media['css'] as $file => $cssitem) {
        if ($cssitem['join']) {
            $externals[] = $file;
        } else {
?>
<?php echo $this->render($cssitem['tpl'], array('filename' => $file)); ?>
<?php
        }
    }
    if ($externals) {
        $externals_string = join(',', $externals);
?>
    <link rel="stylesheet" type="text/css" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl() . '/media/' . md5($externals_string)); ?>.css?files=<?php echo htmlspecialchars($externals_string); ?>" />
<?php
    }
}
?>