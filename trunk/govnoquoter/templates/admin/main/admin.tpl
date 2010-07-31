<?php
$this->wrap('admin/main/adminHeader.tpl');

$this->add('jquery.js');
$this->add('dui.js');
$this->add('jquery.ex.js');
$this->add('jip.css');
$this->add('fileLoader.js');
$this->add('jip/jipCore.js');
$this->add('jip/jipMenu.js');
$this->add('jip/jipWindow.js');
?>

    <div id="adminBody">
        <div id="adminHeader" class="clearfix">
            <h1>
                <a href="<?php echo htmlspecialchars(SITE_PATH); ?>/" title="Visit Site"><?php echo htmlspecialchars($toolkit->getRequest()->getUrl()); ?>/</a>
            </h1>
            <div class="userInfo"><?php echo $this->load('user', 'login', array('onlyForm' => true, 'tplPrefix' => 'admin/')); ?></div>
        </div>
        <div id="adminWrap" class="clearfix">
            <div class="c-topLeft"></div>
            <div class="c-top"></div>
            <div class="c-topRight"></div>
            <div class="c-left"></div>
            <div class="c-right"></div>
            <div class="c-bottomLeft"></div>
            <div class="c-bottom"></div>
            <div class="c-bottomRight"></div>
            <div id="adminSidebar">
                <?php echo $this->load('admin', 'menu'); ?>
            </div>
            <div id="adminPageWrap" class="clearfix">
                <div id="adminPage" class="clearfix">
                    <div class="c-topLeft"></div>
                    <div class="c-top"></div>
                    <div class="c-topRight"></div>
                    <div class="c-left"></div>
                    <div class="c-right"></div>
                    <div class="c-bottomLeft"></div>
                    <div class="c-bottom"></div>
                    <div class="c-bottomRight"></div>
                    <div style="position: absolute; top: -26px; right: 5px">
                    <a href="{url route='adminModule' name=$current_module action='config'}" class="mzz-jip-link"><img class="mzz-icon mzz-icon-admin mzz-icon-admin-action" src="{$SITE_PATH}/images/spacer.gif" width="16" height="16" alt="" /></a>
                    </div>
                    <?php echo $content; ?>
                </div>
            </div>
        </div>
        <div id="adminFooter"><span style="float:left"><a href="http://www.mzz.ru/"><?php echo MZZ_NAME; ?></a> (<?php echo 'v.' . MZZ_VERSION . '-' . MZZ_REVISION; ?>) 2005-<?php echo date('Y'); ?> | <a href="http://www.mzz.ru/docs/">Documentation</a> | <a href="http://trac.mzz.ru">Trac</a></span> <?php echo $timer->toString('timer/admin/timer.tpl', 'smarty'); ?></div>
    </div>
<?php
$this->wrap();
?>