            {strip}
                <ol class="linenumbers">
                {foreach from=$quote->generateLines() item="line" name="lineIterator"}
                    <li>{if $smarty.foreach.lineIterator.first && $quote->getLinesCount() > 15}
                        <span id="codefolder{$quote->getId()}" class="folder">
                            <a href="{url route="withId" action="" id=$quote->getId()}" id="unfoldCode{$quote->getId()}" onclick="unfoldCode({$quote->getId()}); return false;" style="display: none;" title="Развернуть">
                                <img src="{$SITE_PATH}/templates/images/nolines_plus.gif" alt="" />
                            </a>
                            <a href="{url route="withId" action="" id=$quote->getId()}" id="foldCode{$quote->getId()}" onclick="foldCode({$quote->getId()}); return false;" title="Свернуть">
                                <img src="{$SITE_PATH}/templates/images/nolines_minus.gif" alt="" />
                            </a>
                        </span>
                        {/if}
                    {$line}</li>
                {/foreach}
                </ol>
                {$quote->getText()|highlite:$quote->getCategory()->getName():$quote->getHighlightedLines():$quote->getId()}
            {/strip}