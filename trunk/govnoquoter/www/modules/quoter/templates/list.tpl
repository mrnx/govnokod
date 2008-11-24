{add file="prototype.js"}
{add file="effects.js"}
{add file="govnokod.js"}

<table cellpadding="0" cellspacing="0" style="width: 80%;">
    <tr>
        <td style="width: 60%; vertical-align: top;">
            {if $listAll}
                {title append="говнокод онлайн"}
                <table class="rblock">
                    <tr>
                        <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
                        <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
                    </tr>
                    <tr class="content">
                        <td>&nbsp;</td>
                        <td>
                            <h1>Говнокод.ру</h1>
                            Нашли или выдавили из себя код, который нельзя назвать нормальным, на который без улыбки не взглянешь? Не торопитесь его удалять
                            или рефакторить — запостите его на говнокод.ру, посмеемся вместе!
                            <br /><br />
                            <a href="http://code.google.com/p/govnokod/">http://code.google.com/p/govnokod/</a>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
                        <td class="empty">&nbsp;</td>
                        <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
                    </tr>
                </table>
            {else}
                {if $category->getPage()}
                    {assign var="pageTitle" value=$category->getPage()->getTitle()}
                    {assign var="pageContent" value=$category->getPage()->getContent()}
                {else}
                    {assign var="pageTitle" value=$category->getTitle()}
                    {assign var="pageContent" value=""}
                {/if}
                {title append=$pageTitle|htmlspecialchars}

                <table class="rblock">
                    <tr>
                        <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
                        <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
                    </tr>
                    <tr class="content">
                        <td>&nbsp;</td>
                        <td>
                            <h1>{$pageTitle|htmlspecialchars}</h1>
                            {$pageContent}
                            {if $category->getQuoteCounts() == 0}
                            <br /><br />
                            Раздел пуст. <a href="{url route="quoteAddFull" name=$category->getName()}">Накласть</a> говнокод первым.
                            {/if}
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
                        <td class="empty">&nbsp;</td>
                        <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
                    </tr>
                </table>
            {/if}
        </td>
        <td style="width: 20%; vertical-align: top;">
            <div class="right-block">
                <div class="block">
                    <div class="top">&nbsp;</div>
                        <div class="content">
                            <ul>
                                {foreach from=$categories item="category"}
                                <li><a href="{url route="categoryList" name=$category->getName()|htmlspecialchars}">{$category->getTitle()|htmlspecialchars} ({$category->getQuoteCounts()})</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    <div class="bottom">&nbsp;</div>
                </div>
            </div>
        </td>
    </tr>
</table>
{foreach from=$quotes item="quote"}
    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/images/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <p class="rate">[ <a href="{url route="withId" action="cool" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="понравилось!">+</a> {$quote->getRating()} <a href="{url route="withId" action="suxx" id=$quote->getId()}" onclick="ajaxvote(this); return false;" title="отстой!">-</a> ]</p>
                <h2><a href="{url route="categoryList" name=$quote->getCategory()->getName()|htmlspecialchars}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="quoteView" id=$quote->getId()}">Говнокод#{$quote->getId()}</a> {$quote->getJip()}</h2>
                <div class="colorCode" id="colorCode{$quote->getId()}">
                    {strip}<table cellpadding="0" cellspacing="0" style="width: 100%;">
                        <tr>
                            <td class="numbers">
                            {foreach from=$quote->generateLines(15) item="line" name="lineIterator"}
                                {if $smarty.foreach.lineIterator.first && $quote->getLinesCount() > 15}
                                    <span id="codefolder{$quote->getId()}" style="float: left;">
                                        <a href="{url route="withId" action="" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="Развернуть">
                                            <img src="{$SITE_PATH}/templates/images/nolines_plus.gif" alt="" />
                                        </a>
                                    </span> {$line}
                                {else}
                                    {$line}
                                {/if}
                                {if !$smarty.foreach.lineIterator.last}<br />{/if}
                            {/foreach}
                            {if $quote->getLinesCount() > 15}
                                <br />…<br />
                                <a href="{url route="withId" action="" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="Развернуть">{$quote->getLinesCount()}</a>
                            {/if}
                            </td>
                            <td class="code">
                                {$quote->getText(15)|highlite:$quote->getCategory()->getName():$quote->getHighlightedLines()}
                                {if false && $quote->getLinesCount() > 15}<br />{/if}
                            </td>
                        </tr>
                    </table>{/strip}
                </div>

                {if $quote->getDescription()}<br />{$quote->getDescription()}{/if}

            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/images/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/images/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>
{/foreach}