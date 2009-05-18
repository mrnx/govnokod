{form->hidden name="captcha_id" value=$captcha_id}
<img width="120" height="40" src="{url route="captcha" _rand=$captcha_id}" onclick="javascript: this.src = '{url route="captcha" _rand=$captcha_id}&amp;r=' + Math.random();" alt="Click to refresh"/>
{form->text name="captcha" style="font-size: 30px; width: 120px; vertical-align: top;"}