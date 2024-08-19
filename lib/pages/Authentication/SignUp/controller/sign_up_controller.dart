import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/pages/CheckUserType/check_user_type.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../main.dart';

class SignUpController extends GetxController {
  RxBool passHide = true.obs;
  RxBool conPassHide = true.obs;
  RxBool terms = false.obs;
  RxBool termsError = false.obs;
  final formKey = GlobalKey<FormState>();

  final businessName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
// final phone=TextEditingController();
// final address=TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referralCode = TextEditingController();

  register({required String type}) async {
    if (terms.value) {
      loadingDialog(message: "Creating Account...", loading: true);
      var deviceToken = Platform.isAndroid? await FirebaseMessaging.instance.getToken():'';
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(value.user!.uid)
            .set({
          // "phoneNo": phone.text,
          "deviceToken": deviceToken,
          "email": email.text,
          "name": userName.text,
          "businessName": userName.text,
          // "address":address.text,
          "type": type,
          "referralCode":
              referralCode.text.isNotEmpty && referralCode.text.length > 7
                  ? referralCode.text.split('#').first
                  : referralCode.text,
          "image": "",
          "d_o_b": "",
          "subscriptionValidTill": DateTime.now().add(Duration(days: 7)),
        }).then((value1) {
          try {
            Purchases.logIn(auth.currentUser!.uid);
            referralCheck(userId: value.user!.uid);
            Get.back();

            Get.offAll(() => CheckUserType(
                  formRegister: type == "User" ? true : false,
                ));
          } catch (e) {
            Get.back();
            loadingDialog(
                message: "An unexpected error occurred", button: true);
          }
        });
      }).onError((error, stackTrace) {
        Get.back();
        print(error.toString());
        if (error.toString() ==
            "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
          loadingDialog(
              message:
                  "The email address is already in use by another account.",
              button: true);
        }
      });
    } else {
      termsError.value = true;
    }
  }

  referralCheck({userId}) {
    if (referralCode.text.isNotEmpty) {
      if (referralCode.text.length > 7) {
        FirebaseFirestore.instance
            .collection("Referrals")
            .where('code', isEqualTo: referralCode.text.split('#').first)
            .get()
            .then((value2) {
          if (value2.docs.isNotEmpty) {
            FirebaseFirestore.instance.collection("ReferralUsers").add({
              'referralCode': referralCode.text.split('#').first,
              'nutritionistId': value2.docs[0]['userId'],
              'userId': userId,
            });
          }
        });
        FirebaseFirestore.instance
            .collection("Users")
            .doc(referralCode.text.split('#').last)
            .get()
            .then((value3) {
          Timestamp t = value3['subscriptionValidTill'];
          value3.reference.update(
              {"subscriptionValidTill": t.toDate().add(Duration(days: 7))});
        });
      } else {
        FirebaseFirestore.instance
            .collection("Referrals")
            .where('code', isEqualTo: referralCode.text.toString())
            .get()
            .then((value2) {
          if (value2.docs.isNotEmpty) {
            FirebaseFirestore.instance.collection("ReferralUsers").add({
              'referralCode': referralCode.text.toString(),
              'nutritionistId': value2.docs[0]['userId'],
              'userId': userId,
            });
          }
        });
      }
    }
  }
}
