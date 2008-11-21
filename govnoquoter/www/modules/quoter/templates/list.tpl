{if $listAll}{title append="информационный портал нового поколения"}{else}{/if}
{add file="prototype.js"}
{add file="effects.js"}
{add file="codefolding.js"}

{foreach from=$quotes item="quote"}
    <table class="rblock">
        <tr>
            <td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-left-top.png" alt="" /></td>
            <td class="empty">&nbsp;</td><td style="width:20px"><img src="{$SITE_PATH}/templates/des/rblock-right-top.png" alt="" /></td>
        </tr>
        <tr class="content">
            <td>&nbsp;</td>
            <td>
                <p class="rate">[ <a href="#" onclick="alert('coming soon'); return false;">+</a> 32 <a href="#" onclick="alert('coming soon'); return false;">-</a> ]</p>
                <h2><a href="{url route="withAnyParam" action="list" name=$quote->getCategory()->getName()}">{$quote->getCategory()->getTitle()|htmlspecialchars}</a> / <a href="{url route="withId" action="" id=$quote->getId()}">Говнокод#{$quote->getId()}</a></h2>
                <div class="colorCode" id="colorCode{$quote->getId()}">
                    {strip}
                    <div class="numbers">

                        {foreach from=$quote->generateLines(15) item="line" name="lineIterator"}
                            {if $smarty.foreach.lineIterator.first && $quote->getLinesCount() > 15}
                                <span id="codefolder{$quote->getId()}" style="float: left;">
                                    <a href="{url route="withId" action="" id=$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" title="Развернуть">
                                        <img src="{$SITE_PATH}/templates/images/quoter/nolines_plus.gif" alt="" />
                                    </a>
                                </span> {$line}
                            {else}
                                {$line}
                            {/if}
                            {if !$smarty.foreach.lineIterator.last}<br />{/if}
                        {/foreach}

                        {if $quote->getLinesCount() > 15}
                            <br />…<br />
                            {$quote->getLinesCount()}
                        {/if}

                    </div>
                    <div class="code">
                        {$quote->getText(15)|highlite:$quote->getCategory()->getName()}
                        {if $quote->getLinesCount() > 15}...{/if}
                    </div>
                    {/strip}
                </div>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><img src="{$SITE_PATH}/templates/des/rblock-left-bottom.png" alt="" /></td>
            <td class="empty">&nbsp;</td>
            <td><img src="{$SITE_PATH}/templates/des/rblock-right-bottom.png" alt="" /></td>
        </tr>
    </table>
{/foreach}
{*
<div class="right-block">
	<div class="block">
    	<div class="top">&nbsp;</div>
            <div class="content">
              <ul>
                <li><a href="#">php</a></li>
                <li><a href="#">java</a></li>
                <li><a href="#">css</a></li>
              </ul>
            </div>
    	<div class="bottom">&nbsp;</div>
    </div>
</div>*}