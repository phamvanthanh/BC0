<?php

// $email and $message are the data that is being
// posted to this page from our html contact form
// When we unzipped PHPMailer, it unzipped to
// public_html/PHPMailer_5.2.0
require("../lib/PHPMailer/PHPMailerAutoload.php");
$email = $_REQUEST['email'] ;
$message = $_REQUEST['message'] ;
$mail = new PHPMailer();
$mail->IsSMTP();// set mailer to use SMTP
$mail->SMTPDebug = 1; // debugging: 1 = errors and messages, 2 = messages only
$mail->SMTPAuth = true;     // turn on SMTP authentication
$mail->SMTPSecure = 'ssl'; // secure transfer enabled REQUIRED for Gmail
$mail->Host = "smtp.gmail.com"; // localhost if send from your server where this php script lives
$mail->Port = 465; // or 587
$mail->IsHTML(true); // set email format to HTML
$mail->Username = "qscompanion@gmail.com";  // SMTP username
$mail->Password = "thanh03021986"; // SMTP password

// $email is the user's email address the specified
// on our contact us page. We set this variable at
// the top of this page with:
// $email = $_REQUEST['email'] ;
$mail->From = $email;

// below we want to set the email address we will be sending our email to.
$mail->AddAddress("pthanh.ce@gmail.com", "QsCompanion");

// set word wrap to 50 characters
$mail->WordWrap = 50;
// set email format to HTML
$mail->IsHTML(true);

$mail->Subject = "You have received feedback from your website!";

// $message is the user's message they typed in
// on our contact us page. We set this variable at
// the top of this page with:
// $message = $_REQUEST['message'] ;
$mail->Body    = $message;
$mail->AltBody = $message;

if(!$mail->Send())
{
   echo "Message could not be sent. <p>";
   echo "Mailer Error: " . $mail->ErrorInfo;
   exit;
}
else
    echo "Message has been sent";
?>