<?php
    echo '<?xml version="1.0" encoding="UTF-8"?>';
    $url = new url('rssComments');
    $url->add('id', $commentsFolder->getParentId());
    $rss_url = $url->get() . '/';
?>

<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
    <channel>
        <title>Говнокод.ру — Комментарии говнокода #<?php echo $commentsFolder->getParentId(); ?></title>
        <link><?php echo htmlspecialchars($rss_url); ?></link>
        <description><![CDATA[Говнокод: по колено в коде]]></description>
        <language>ru</language>
        <managingEditor>support@govnokod.ru (govnokod.ru support)</managingEditor>
        <generator><?php echo htmlspecialchars(MZZ_NAME); ?> v.100500</generator>
        <pubDate><?php echo date('D, d M Y H:i:s O'); ?></pubDate>
        <lastBuildDate><?php echo date('D, d M Y H:i:s O'); ?></lastBuildDate>
        <image>
            <link><?php echo htmlspecialchars($rss_url); ?></link>
            <url>http://govnokod.ru/images/brand.png</url>
            <title>Говнокод.ру — Комментарии говнокода #<?php echo $commentsFolder->getParentId(); ?></title>
        </image>
        <atom:link href="<?php echo htmlspecialchars($rss_url); ?>" rel="self" type="application/rss+xml" />
<?php
$comment_iteration = 0;
foreach ($comments as $comment) {
    $comment_iteration++;
?>
        <item>
            <title>Комментарий #<?php echo $comment_iteration; ?></title>
            <guid><?php echo $comment->getId(); ?></guid>
            <link><?php echo htmlspecialchars($this->url('quoteView', array('id' => $commentsFolder->getParentId()))); ?>#comment<?php echo $comment->getId(); ?></link>
            <description>
                <![CDATA[
                <?php echo nl2br($this->bbcode(htmlspecialchars(trim($comment->getText())))); ?>

                ]]>
            </description>
            <pubDate><?php echo date('D, d M Y H:i:s O', $comment->getCreated()); ?></pubDate>
            <author><?php echo htmlspecialchars($comment->getUser()->getLogin()); ?></author>
        </item>
<?php } ?>
    </channel>
</rss>