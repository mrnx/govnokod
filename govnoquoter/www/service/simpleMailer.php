<?php
fileLoader::load('libs/phpmailer/class.phpmailer');

class simpleMailer
{
    protected $mailer;

    public function __construct($subject, $body, $to, $toName, $from, $fromName)
    {
        $mail = new phpmailer();
        $mail->IsHtml(true);
        $mail->CharSet  = 'utf-8';

        $mail->From     = $from;
        $mail->FromName = $fromName;

        $mail->Subject  = $subject;
        $mail->Body     = $body;
        $mail->AddAddress($to);

        $mail->IsSMTP();
        $mail->Host = 'localhost';
        $mail->Port = 25;

        $this->mailer = $mail;
    }

    public function send()
    {
        return $this->mailer->Send();
    }
}
?>