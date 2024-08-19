import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class InviteFriendController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void sendEmail({url}) async {
    loadingDialog(message: "Sending invitation", loading: true);
    String username = 'eatwelltracker@gmail.com';
    String password = 'fidd hbmo ukwt mzop';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, "Eat Well Tracker")
      ..recipients.add(emailController.text)
      ..subject = 'Download App'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<p>${url}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      emailController.clear();
      Get.back();
      await loadingDialog(message: "Invitation Sent", button: true);
    } on MailerException catch (e) {
      Get.back();
      loadingDialog(
          message: "Failed to send email", button: true); // verification code
      print('Message not sent.${e.message}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
