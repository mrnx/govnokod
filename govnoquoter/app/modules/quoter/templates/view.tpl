<?php
    $this->title('Говнокод #' . $quote->getId());
    $this->title($quote->getCategory()->getTitle());

    $this->meta(array('description' => $quote->getDescription(), 'reset' => true));

    $this->add('jquery.js');
    $this->add('jquery.scrollTo.js');
    $this->add('govnokod.js');

    $highlight_driver = $toolkit->getUser()->getHighlightDriver();
?>

<ol class="posts hatom">
    <li class="hentry">
<?php
    $list_item_file = 'nohl';
    if ($highlight_driver == 'geshi') {
        $list_item_file = 'geshi';
    } else if ($highlight_driver == 'js') {
        $list_item_file = 'js';

        $this->add('jshighlight/highlight.pack.js');
        $this->add('jshighlight/govnokod.css');
    }

    if ($quote->isSpecial()) {
        $list_item_file = 'special';
    }

    echo $this->render('quoter/listitem/' . $list_item_file . '.tpl', array('quote' => $quote, 'highlight_driver' => $highlight_driver));
    echo $this->load('comments', 'list', array('object' => $quote));
?>
    </li>
</ol>