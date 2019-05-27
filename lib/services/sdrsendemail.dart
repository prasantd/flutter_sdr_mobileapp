//import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SDRSendMail {
  String _body;
  String _subject;
  String _recipients;
  String _sender;

  bool isSuccess = false;
  String platformResponse = "";

  SDRSendMail(String _senderName, String _songName, String _message) {
    _sender = _senderName;
    _subject = '[Mobile App]: Song Request from $_senderName';
    _recipients = 'info@shuddhdesiradio.com';
    _body =
        'Please play this song. </br> Song Name: $_songName </br> Message: $_message </br> Requestor: $_senderName';
  }

  Future<bool> sendEmail() async {
    final smtpServer = gmail('sdremailsetup@gmail.com', 'S@turd@yshows2018');

    final message = new Message()
      ..from = new Address(_recipients, _sender)
      ..subject = _subject
      ..recipients.add(_recipients)
      ..html = _body;

    final sendReports =
        await send(message, smtpServer, timeout: new Duration(seconds: 15));
    sendReports.forEach((sr) {
      if (sr.sent) {
        print('Message sent.');
        isSuccess = true;
      } else {
        print('Message not sent.');
        for (var p in sr.validationProblems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
    });
    return isSuccess;
  }
}
