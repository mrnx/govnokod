<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <title>Офис администратора<?php echo htmlspecialchars($this->title(array('separator' => ' | ', 'start' => ' — '))); ?></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="generator" content="<?php echo MZZ_NAME . 'v.' . MZZ_VERSION . '-' . MZZ_REVISION; ?>" />
    <link rel="stylesheet" type="text/css" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/css/admin/adm.css" />
<?php echo $this->render('include.css.tpl'); ?>
    <script type="text/javascript">
    //<!--
    var SITE_PATH = '<?php echo htmlspecialchars(SITE_PATH); ?>';
    var SITE_LANG = 'ru';
    //-->
    </script>
<?php echo $this->render('include.js.tpl'); ?>
    <script type="text/javascript">
    //<!--
        MZZ.tools.zebra('table.admin');
    //-->
    </script>
</head>
<body>
<?php echo $content; ?>
</body>
</html>