{strip}
{add file="jquery.js"}
{add file="jquery.scrollTo.js"}
{add file="govnokod.js"}
{if $current_user->getHighlightDriver() == 'js'}{add file="jshighlight/govnokod.css"}{add file="jshighlight/highlight.pack.js"}{add file="govnokod.jsh.js"}{/if}

{if $time == 'day'}
{title append="Лучший говнокод за сегодня"}
{elseif $time == 'week'}
{title append="Лучший недельный говнокод"}
{elseif $time == 'month'}
{title append="Лучший говнокод за месяц"}
{elseif $time == 'ever'}
{title append="Лучший говнокод за всё время"}
{/if}
{/strip}

<ol class="posts hatom">
    <li class="hentry">
        <h2>Лучший говнокод</h2>
        <dl>
            <dt>В номинации:</dt>
            <dd>
                <ul>
                    <li>{if $nomination != 'rating'}<a href="{url route="best" nomination="rating" _time=$time}">Лучший рейтинг</a>{else}Лучший рейтинг{/if}</li>
                    <li>{if $nomination != 'comments'}<a href="{url route="best" nomination="comments" _time=$time}">Самый комментируемый</a>{else}Самый комментируемый{/if}</li>
                </ul>
            </dd>

            <dt>За время:</dt>
            <dd>
                <ul>
                    <li>{if $time != 'day'}<a href="{url _time="day"}">за этот день</a>{else}за этот день{/if}</li>
                    <li>{if $time != 'week'}<a href="{url _time="week"}">за неделю</a>{else}за неделю{/if}</li>
                    <li>{if $time != 'month'}<a href="{url _time="month"}">за месяц</a>{else}за месяц{/if}</li>
                    <li>{if $time != 'ever'}<a href="{url _time="ever"}">за всё время</a>{else}за всё время{/if}</li>
                </ul>
            </dd>
        </dl>
    </li>
{foreach from=$quotes item="quote"}
    {include file="quoter/listitem.tpl" quote=$quote}
{foreachelse}
    <li class="hentry">
        <h2>В этой номинации ничего нет!</h2>
        <p>Видимо, еще не успели добавить</p>
    </li>
{/foreach}
</ol>