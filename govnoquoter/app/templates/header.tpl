<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><?php echo htmlspecialchars($this->title(array('separator' => ' — ', 'end' => ' — '))); ?>Говнокод.ру</title>
    <meta name="keywords" content="<?php echo htmlspecialchars($this->meta(array('show' => 'keywords', 'default' => 'говнокод, смешной код, быдлокод, быдлокодеры, индусы, для программистов, про программистов, индусский код, записки программиста, говно, говнокод на php, mysql, perl'))); ?>" />
    <meta name="description" content="<?php echo htmlspecialchars($this->meta(array('show' => 'description', 'default' => 'Сборник говнокода на различных языках программирования'))); ?>" />
    <link rel="shortcut icon" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/animated_favicon.gif" type="image/gif" />
    <link title="Весь говнокод" type="application/rss+xml" rel="alternate" href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/rss"/>
<?php
if (isset($list_category)) {
?>
    <link title="<?php echo htmlspecialchars($list_category->getTitle()); ?> говнокод" type="application/rss+xml" rel="alternate" href="<?php echo htmlspecialchars($this->url('rssFull', array('name' => $list_category->getName()))); ?>"/>
<?php
}
?>
<?php echo $this->render('include.external.bundle.css.tpl'); ?>
    <!--[if lte IE 7]><link href="<?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/css/ie.css?v=2" rel="stylesheet" type="text/css"><![endif]-->
    <script type="text/javascript">
    //<!--
    var SITE_PATH = '<?php echo htmlspecialchars(SITE_PATH); ?>'; var SITE_LANG = 'ru';
    //-->
    </script>
<?php echo $this->render('include.external.bundle.js.tpl'); ?>
</head>
<body>
<?php
    echo $content;
?>
    <script type="text/javascript">
    var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
    document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript">
    var pageTracker = _gat._getTracker("UA-6478594-1");
    pageTracker._trackPageview();
    </script>
</body>
</html>