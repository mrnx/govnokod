<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

<?php include_http_metas() ?>
<?php include_metas() ?>

<?php include_title() ?>
<!--[if IE]>
<style type="text/css">
  .rounded-css3 {
    border: 1px solid #999 !important;
    background-color: #fff !important;
  }
</style>
<![endif]--> 
<link rel="shortcut icon" href="/favicon.ico" />

</head>
<body>
  <a href="#" class="header">
    <img src="/images/logo.png" alt="Логотип портала Говнокод.Ру" title="Да, это говно" />
    Govnokod.ru
  </a>

  <ul class="menu">
    <li class="active"><?php echo link_to(__('Govnokode'), '@homepage')?></li>
    <li><?php echo link_to(__('Govnobash'), 'http://www.govnokod.ru/')?></li>
  </ul>
  
  <div id="b-left" class="rounded rounded-css3 rounded-svg">
    <?php include_partial('index/actions');?><br /><br />
    <?php include_component('index', 'lastCopypastas');?><br />
  </div>
  <div id="b-center" class="rounded rounded-css3 rounded-svg">
    <?php echo $sf_content ?>
  </div>

</body>
</html>
