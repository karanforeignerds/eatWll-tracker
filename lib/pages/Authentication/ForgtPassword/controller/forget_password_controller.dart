import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{



final dialogTrue=false.obs;
final emailController=TextEditingController();
final formKey=GlobalKey<FormState>();

 resetPassword() async {
   if(formKey.currentState!.validate()){
     await auth.sendPasswordResetEmail(email: emailController.text)
         .then((value){
       dialogTrue.value=true;
       emailController.clear();
     }).catchError((e){
       loadingDialog(button: true,message: "Something went wrong");
     });
   }
}

}