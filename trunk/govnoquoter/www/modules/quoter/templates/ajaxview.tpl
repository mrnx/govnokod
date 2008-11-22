    <div class="numbers">
        {foreach from=$quote->generateLines() item="line" name="lineIterator"}
            {if $smarty.foreach.lineIterator.first && $quote->getLinesCount() > 15}
                <span id="codefolder{$quote->getId()}" style="float: left;">
                    <a href="{url route="withId" action="" id=$quote->getId()}" id="unfoldCode{$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" style="display: none;" title="Развернуть">
                        <img src="{$SITE_PATH}/templates/images/nolines_plus.gif" alt="" />
                    </a>
                    <a href="{url route="withId" action="" id=$quote->getId()}" id="foldCode{$quote->getId()}" onclick="foldCode({$quote->getId()}); return false;" title="Свернуть">
                        <img src="{$SITE_PATH}/templates/images/nolines_minus.gif" alt="" />
                    </a>
                </span> {$line}
            {else}
                {$line}
            {/if}
            {if !$smarty.foreach.lineIterator.last}<br />{/if}
        {/foreach}
    </div>
    <div class="code">
        {$quote->getText()|highlite:$quote->getCategory()->getName()}
    </div>