{* main="header.tpl" placeholder="content" *}
    <div class="header">
        <a href="/">
            <img src="{$SITE_PATH}/templates/images/logo.png" alt="Говнокод.Ру" title="Да, это говно!" />
            Govnokod.ru
        </a>
    </div>
    <div class="add-govno">
        <a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}" title="Наговнокодить!"><img src="{$SITE_PATH}/templates/images/icon-plus.png" alt="" /></a>
        <a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}" title="По просьбе трудящихся">Наговнокодить!</a>
    </div>
    <ul class="menu">
        <li class="active"><a href="{url route="default"}">Говнокод</a></li>
        {*<li><a href="http://bin.govnokod.ru/">Говнобин</a></li>*}
    </ul>
    <div style="clear:both"></div>
    <ul class="sub-menu">
        <li class="left">&nbsp;</li>
    	<li><a href="#">Новый</a></li>
    	<li><a href="#">Лучший</a></li>
    	<li class="right">&nbsp;</li>
    </ul>

    <div style="clear: both;"></div>

    {$content}

    <div class="footer">
        © говнокод.ру
        <img src="{$SITE_PATH}/templates/images/mrHankey.png" alt="Мистер Хэнки" title="Мистер Хэнки" />
    </div>
    {*
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
var pageTracker = _gat._getTracker("UA-6478594-1");
pageTracker._trackPageview();
</script>*}