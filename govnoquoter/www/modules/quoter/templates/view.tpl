{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}
{title append=$quote->getCategory()->getTitle()|htmlspecialchars}

    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <p class="rate">[ <a href="{url route="withId" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> {$quote->getRating()} <a href="{url route="withId" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a> ]</p>
                <h1><a href="{url route="categoryList" name=$quote->getCategory()->getName()|htmlspecialchars}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод#{$quote->getId()}</a></h1>
                <div class="colorCode" id="colorCode{$quote->getId()}">
                    <div class="numbers">
                        {foreach from=$quote->generateLines() item="line" name="lineIterator"}
                            {$line}{if !$smarty.foreach.lineIterator.last}<br />{/if}
                        {/foreach}
                    </div>
                    <div class="code">
                        {$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getHighlightedLines():$quote->getId()}
                    </div>
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>