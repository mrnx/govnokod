<?php if (!$validator->isValid()): ?>
    <dl class="errors">
        <dt>Ошибка компиляции комментария:</dt>
        <dd>
            <ol>
<?php foreach ($validator->getErrors() as $error): ?>
                <li><?php echo $error; ?></li>
<?php endforeach; ?>
            </ol>
        </dd>
    </dl>
<?php endif; ?>

    <dl>
        <dt><img class="avatar" src="<?php echo htmlspecialchars($user->getAvatarUrl(28)); ?>" alt="ava" title="Аватар" /> <?php echo $formTitle; ?></dt>
        <dd>
            <?php echo $__form->textarea(array('name' => 'text', 'value' => $comment->getText(), 'rows' => 5, 'cols' => 5, 'useDefault' => $onlyForm)); ?>
            <div class="field-info">
                А не использовать ли нам <a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'bbcode'))); ?>" onclick="comments.toggleBBCodeBlock(this); return false;">bbcode</a>?
                <div class="bbcodes">
                    <ul style="margin-left: 0;">
                        <li>[b]жирный[/b] — <b>жирный</b></li>
                        <li>[i]курсив[/i] — <i>курсив</i></li>
                        <li>[u]подчеркнутый[/u] — <span style="text-decoration:underline;">подчеркнутый</span></li>
                        <li>[s]перечеркнутый[/s] — <span style="text-decoration:line-through;">перечеркнутый</span></li>
                        <li>[blink]мигающий[/blink] — <span style="text-decoration:blink;">мигающий</span></li>
                        <li>[color=red]цвет[/color] — <span style="color:red;">цвет</span> (<a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'bbcode'))); ?>#color">подробнее</a>)</li>
                        <li>[size=20]размер[/size] — <span style="font-size:20px">размер</span> (<a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'bbcode'))); ?>#size">подробнее</a>)</li>
                        <li>[code=&lt;language&gt;]some code[/code] (<a href="<?php echo htmlspecialchars($this->url('pageActions', array('name' => 'bbcode'))); ?>#code">подробнее</a>)</li>
                    </ul>
                </div>
            </div>
        </dd>
<?php if ($showCaptcha): ?>
        <dt><?php echo $__form->caption(array('name' => 'captcha', 'value' => 'Проверочный код:', 'onError' => '')); ?></dt>
        <dd><?php echo $__form->captcha(array('name' => 'captcha', 'value' => 'Проверочный код:', 'onError' => '')); ?></dd>
<?php endif; ?>
    </dl>

    <p>
        <?php echo $__form->submit(array('name' => 'commentSubmit', 'class' => 'send', 'value' => 'Отправить комментарий [Ctrl+Enter]')); ?>
    </p>