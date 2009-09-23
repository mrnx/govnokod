{* main="service/mail/main.tpl" placeholder="content" *}
Hello, <em>{$user->getLogin()|h}</em>!<br />
<br />
На Ваш e-mail была запрошена регистрация на сайте <a href="{url route="default"}">Говнокод.ру</a>!<br />
<br />
Для подтверждения своих намерений перейдите по этой ссылке:<br />
<br />
<a href="{url route="default2" module="user" action="register" _user=$user->getId() _confirm=$confirm escape=true}">{url route="default2" module="user" action="register" _user=$user->getId() _confirm=$confirm escape=true}</a><br />
<br /><br />
Внимание! Если Вы чувствуете, что получили это письмо по ошибке, то просто проигнорируйте его.