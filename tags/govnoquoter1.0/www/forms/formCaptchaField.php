<?php
/**
 * $URL$
 *
 * MZZ Content Management System (c) 2005-2007
 * Website : http://www.mzz.ru
 *
 * This program is free software and released under
 * the GNU/GPL License (See /docs/GPL.txt).
 *
 * @link http://www.mzz.ru
 * @version $Id$
 */

/**
 * formCaptchaField: captcha
 *
 * @package system
 * @subpackage forms
 * @version 0.1
 */
class formCaptchaField extends formElement
{
    public function render($attributes = array(), $value = null)
    {
        $captcha_id = md5(microtime(true));

        $url = new url('captcha');
        $url->add('rand', $captcha_id, true);

        $image = $this->renderTag('img', array(
            'src' => $url->get(),
            'width' => 120,
            'height' => 40,
            'alt' => 'Click to refresh',
            'onclick' => 'javascript: this.src = "' . $url->get() . '&amp;r=" + Math.random();')
        );

        $hidden = $this->renderTag('input', array(
            'type' => 'hidden',
            'name' => $attributes['name'] . '_id',
            'value' => $captcha_id)
        );

        $attributes['type'] = 'text';
        $attributes['value'] = '';
        $attributes['style'] = 'font-size: 24px; vertical-align: middle;';
        return $hidden . $image . ' &#8250; ' . $this->renderTag('input', $attributes);
    }
}

?>