{assign var="highlight" value="js"}
<ol>{foreach from=$quote->generateLines() item="line"}<li>{$line}</li>{/foreach}</ol>
{if $highlight == "geshi"}
{assign var="langName" value=$quote->getCategory()->getGeshiAlias()|h}
{$quote->getText()|highlite:$langName}
{else}
{assign var="langName" value=$quote->getCategory()->getJsAlias()|h}
<pre><code class="{$langName|h}">{$quote->getText()|h}</code></pre>
{/if}