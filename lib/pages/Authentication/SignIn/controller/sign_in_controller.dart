import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/CheckUserType/check_user_type.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController{
  @override
  void onInit() {
    getPassword();
    // TODO: implement onInit
    super.onInit();
  }

  getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('password')!=null){
      password.text=prefs.getString('password')!;
    }
  }


  RxBool passHide=true.obs;
  RxBool isRememberPass=false.obs;

  final email=TextEditingController();
  final password=TextEditingController();
  final formKey=GlobalKey<FormState>();

  Future<void> logIn() async {

    loadingDialog(loading: true, message: "Signing...");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await auth
          .signInWithEmailAndPassword(
          email: email.text, password: password.text)
          .then((value) async {
        Purchases.logIn(auth.currentUser!.uid);
        if(isRememberPass.value){
              await prefs.setString('password',password.text.toString());
            }
        if(Platform.isAndroid){
          getToken();
        }
        Get.offAll(() => CheckUserType());
      });
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      Get.back();

      if(e.toString()=="[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
        loadingDialog(message: "The password is invalid", button: true);
      }
      if(e.toString()=="[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        loadingDialog(message: "There is no user record corresponding to this email. The user may have been deleted.", button: true);
      }
      if(e.toString()=="[firebase_auth/INVALID_LOGIN_CREDENTIALS] An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]"){
        loadingDialog(message: "Invalid login credentials.", button: true);
      }
    }
  }
  void getToken() async {
    var deviceToken = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .update({'deviceToken': deviceToken});
  }


}