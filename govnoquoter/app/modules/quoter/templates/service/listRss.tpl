<?php echo '<?xml version="1.0" encoding="UTF-8"?>'; ?>

<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
<?php
switch ($type) {
    case 'user':
        $rss_url = $this->url('userCodesRss', array('id' => $list_user->getId())) . '/';
?>
        <title>Говнокод.ру — лента пользователя <?php echo htmlspecialchars($list_user->getLogin()); ?></title>
        <link><?php echo htmlspecialchars($rss_url); ?></link>
        <description><![CDATA[Говнокод: по колено в коде. Персональная лента говнокода для пользователя <?php echo htmlspecialchars($list_user->getLogin()); ?>.]]></description>
<?php
        break;

    case 'category':
        $rss_url = $this->url('langRss', array('name' => $list_category->getName())) . '/';
?>
        <title>Говнокод.ру — <?php echo htmlspecialchars($list_category->getTitle()); ?></title>
        <link><?php echo htmlspecialchars($rss_url); ?></link>
        <description><![CDATA[Говнокод: по колено в коде. Говнокод на языке программирования <?php echo htmlspecialchars($list_category->getTitle()); ?>.]]></description>
<?php
        break;

    default:
        $rss_url = $this->url('rss') . '/';
?>
        <title>Говнокод.ру</title>
        <link><?php echo htmlspecialchars($rss_url); ?></link>
        <description><![CDATA[Говнокод: по колено в коде]]></description>
<?php
        break;
}
?>

        <language>ru</language>
        <managingEditor>support@govnokod.ru (govnokod.ru support)</managingEditor>
        <generator><?php echo MZZ_NAME . ' v.100500-' . MZZ_REVISION; ?></generator>
        <pubDate><?php echo date('D, d M Y H:i:s O'); ?></pubDate>
        <lastBuildDate><?php echo date('D, d M Y H:i:s O'); ?></lastBuildDate>
        <image>
            <link><?php echo htmlspecialchars($rss_url); ?></link>
            <url>http://govnokod.ru/images/brand.png</url>
            <title>Говнокод.ру</title>
        </image>
        <atom:link href="<?php echo htmlspecialchars($rss_url); ?>" rel="self" type="application/rss+xml" />
<?php foreach ($quotes as $quote) { ?>
        <item>
            <title><?php echo htmlspecialchars($quote->getCategory()->getTitle()); ?> / Говнокод #<?php echo htmlspecialchars($quote->getId()); ?></title>
            <guid isPermaLink="true"><?php echo htmlspecialchars($this->url('quoteView', array('id' => $quote->getId()))); ?></guid>
            <link><?php echo htmlspecialchars($this->url('quoteView', array('id' => $quote->getId()))); ?></link>
            <description>
                <![CDATA[
<?php if (trim($quote->getDescription())) { ?>
                    <p><?php echo nl2br($this->bbcode(htmlspecialchars(trim($quote->getDescription())))); ?></p>
<?php
}
if ($quote->isSpecial()) { ?>
                    <?php echo htmlspecialchars($quote->getText()); ?>
<?php } else { ?>
                    <pre><code class="<?php echo htmlspecialchars($quote->getCategory()->getJsAlias()); ?>"><?php echo htmlspecialchars($quote->getText()); ?></code></pre>
<?php } ?>
                ]]>
            </description>
            <pubDate><?php echo date('D, d M Y H:i:s O', $quote->getCreated()); ?></pubDate>
            <category><?php echo htmlspecialchars($quote->getCategory()->getTitle()); ?></category>
            <author><?php echo htmlspecialchars($quote->getUser()->getLogin()); ?></author>
        </item>
<?php } ?>
    </channel>
</rss>