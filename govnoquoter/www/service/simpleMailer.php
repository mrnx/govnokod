<?php
fileLoader::load('libs/phpmailer/class.phpmailer');

class simpleMailer
{
    protected $mailer;

    public function __construct($subject, $body, $to, $from, $fromName)
    {
        $mail = new phpmailer();
        $mail->IsHtml(true);
        $mail->CharSet  = 'utf-8';

        $mail->From     = $from;
        $mail->FromName = $fromName;

        $mail->Subject  = $subject;
        $mail->Body     = $body;
        $mail->AddAddress($to);
        $this->mailer = $mail;
    }

    public function send()
    {
        return $this->mailer->Send();
    }
}
?>