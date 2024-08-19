import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Authentication/TypeSelection/join_as.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deleteAccount(context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final emailController =TextEditingController();
      final passwordController =TextEditingController();
      final formKey=GlobalKey<FormState>();
      return AlertDialog(
        title: Text('Delete Account',textAlign: TextAlign.center,),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("First verify your email and password.",style:TextStyle(
                fontSize: 16,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 16,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email",style:TextStyle(
                  fontSize: 14,
                )),
              ),
              SizedBox(height: 8,),
              CustomTextField(
                hint: "Email",
                controller: emailController,
                onValidate: (p0) {
                  if(p0!.trim().isEmpty){
                    return "Field is required";
                  }
                  else if(!GetUtils.isEmail(p0)){
                    return "Enter valid email";
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 16,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password",style:TextStyle(
                  fontSize: 14,
                )),
              ),
              SizedBox(height: 8,),
              CustomTextField(
                hint: "**********",
                obscureText: true,
                controller: passwordController,
                onValidate: (p0) {
                  if(p0!.trim().isEmpty){
                    return "Field is required";
                  } else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 24,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    width: 100,
                    text: "Cancel", radius: 16, onPressed: () {
                    Get.back();
                  },),
                  SizedBox(width: 12,),
                  CustomButton(
                    width: 100,
                    text: "Confirm", radius: 16, onPressed: () {
                    if(formKey.currentState!.validate()){
                      final credentials= EmailAuthProvider.credential(email: emailController.text, password: passwordController.text);
                      auth.currentUser!.reauthenticateWithCredential(credentials).then((value){
                        value.user!.delete();
                        Get.offAll(()=>JoinAs());
                      }).onError((error, stackTrace) {
                        if(error.toString()=="[firebase_auth/INVALID_LOGIN_CREDENTIALS] An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]"){
                          loadingDialog(message: "Invalid credentials",button: true);
                        }else{
                          loadingDialog(message: "Something went wrong");
                        }
                        print(error);
                      });
                    }
                  },),
                ],
              )
            ],
          ),
        ),
      );
    },);
}