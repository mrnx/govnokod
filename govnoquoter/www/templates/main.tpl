{* main="header.tpl" placeholder="content" *}
    <div class="header">
        <a href="/">
            <img src="{$SITE_PATH}/templates/images/logo.png" alt="Логотип портала Говнокод.Ру" title="Да, это говно" />
            Govnokod.ru
        </a>
    </div>
    <div class="add-govno"><a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}"><img src="{$SITE_PATH}/templates/images/icon-plus.png" alt="" /></a> <a href="{if $listAll|default:true}{url route="quoteAdd"}{else}{url route="quoteAddFull" name=$category->getName()}{/if}">Накласть говнокод</a></div>
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

    {$content}