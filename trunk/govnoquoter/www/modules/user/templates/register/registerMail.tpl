<p>Hello, {$user->getLogin()|h}!</p>
<p>&nbsp;</p>
<p>На Ваш e-mail была запрошена регистрация на сайте <a href="{url route="default"}">Говнокод.ру</a></p>
<p>&nbsp;</p>
<p>Для подтверждения регистрации перейдите по этой ссылке:</p>
<p><a href="{url route="default2" module="user" action="register" _user=$user->getId() _confirm=$confirm escape=true}">{url route="default2" module="user" action="register" _user=$user->getId() _confirm=$confirm escape=true}</a></p>