<?php
$this->add('jquery.js');
$this->add('jquery.scrollTo.js');
$this->add('govnokod.js');

$highlight_driver = $toolkit->getUser()->getHighlightDriver();

switch ($type) {
    case 'category':
        $this->title($list_category->getTitle());
        break;

    case 'paper':
        $this->title('Печатное издание');
        break;

    default:
        $this->title('По колено в коде');
        break;
}

?>
<ol class="posts hatom">
<?php
if ($type == 'paper' && $pager->getRealPage() == 1) {
?>
    <li class="hentry">
        <h2>Печатное издание Говнокод.ру</h2>
        <p>В данном разделе собраны <b>все</b> говнокоды, когда-либо опубликованные на сайте.</p>
    </li>
<?php
}

$quotes_count = $quotes->count();
if ($quotes_count) {
    $list_item_file = 'nohl';
    if ($highlight_driver == 'geshi') {
        $list_item_file = 'geshi';
    } else if ($highlight_driver == 'js') {
        $list_item_file = 'js';

        $this->add('jshighlight/highlight.pack.js');
        $this->add('jshighlight/govnokod.css');
    }
    foreach($quotes as $quote) {
        if ($quote->isSpecial()) {
            $list_item_file = 'special';
        }

        echo $this->render('quoter/listitem/' . $list_item_file . '.tpl', array('quote' => $quote, 'highlight_driver' => $highlight_driver));
    }
} else {
?>
    <li class="hentry">
        <h2>Пусто</h2>
    </li>
<?php
}
?>
</ol>

<?php
if ($pager->getPagesTotal() > 1) {
    echo $pager->toString();
}
?>