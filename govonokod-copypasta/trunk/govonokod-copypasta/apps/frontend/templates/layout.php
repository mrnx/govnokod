<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<?php include_http_metas() ?>
<?php include_metas() ?>

<?php include_title() ?>

<link rel="shortcut icon" href="/favicon.ico" />

</head>
<body>
  <div style="margin: 20px 10px;">
    <h1>Йа Шапко</h1>
  </div>
  <div id="b-left">
    <?php include_partial('index/actions');?>
    <?php include_component('index', 'lastCopypastas');?>
    <?php include_partial('global/credits');?>
  </div>
  <div id="b-center">
    <?php echo $sf_content ?>
  </div>

</body>
</html>
