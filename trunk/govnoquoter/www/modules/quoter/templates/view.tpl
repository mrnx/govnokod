{add file="prototype.js"}
{add file="govnokod.js"}
{title append=$quote->getCategory()->getTitle()|htmlspecialchars}
{assign var="number" value=$quote->getId()}
{title append="Говнокод#$number"}

    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <p class="rate">[ <a href="{url route="withId" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> {$quote->getRating()} <a href="{url route="withId" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a> ]</p>
                <h1><a href="{url route="categoryList" name=$quote->getCategory()->getName()|htmlspecialchars}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод#{$quote->getId()}</a> {$quote->getJip()}</h1>
                <div class="colorCode" id="colorCode{$quote->getId()}">
                    {strip}<table cellpadding="0" cellspacing="0" style="width: 100%;">
                        <tr>
                            <td class="numbers">
                                {foreach from=$quote->generateLines() item="line" name="lineIterator"}
                                    {$line}{if !$smarty.foreach.lineIterator.last}<br />{/if}
                                {/foreach}
                            </td>
                            <td class="code">
                                {$quote->getText()|trim|highlite:$quote->getCategory()->getName():$quote->getHighlightedLines():$quote->getId()}
                            </td>
                        </tr>
                    </table>{/strip}
                </div>

                {if $quote->getDescription()}<br />{$quote->getDescription()|htmlspecialchars|nl2br}{/if}
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>