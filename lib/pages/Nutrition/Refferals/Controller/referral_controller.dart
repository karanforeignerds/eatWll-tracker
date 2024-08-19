import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReferralController extends GetxController{

  RxBool isAddReferral=false.obs;
  RxInt generatedCode=0000.obs;
  Rx<TextEditingController> codeController=TextEditingController().obs;
  TextEditingController nameController=TextEditingController();
  final formKey=GlobalKey<FormState>();


  generateCode(){
    generatedCode.value=Random().nextInt(9999999);
    FirebaseFirestore.instance.collection("Referrals").where('code',isEqualTo: generatedCode.value).get().then((value){
      if(value.docs.isEmpty){
        codeController.value.text=generatedCode.value.toString();
      }else{
        generatedCode();
      }
    });
  }

  addReferral(){

    FirebaseFirestore.instance.collection("Referrals").where('code',isEqualTo: generatedCode.value).get().then((value){
      if(value.docs.isEmpty){
        FirebaseFirestore.instance.collection("Referrals").add({
          'code':codeController.value.text,
          'userId':auth.currentUser!.uid,
          'clientName':nameController.text,
        }).then((value){
          codeController.value.clear();
          nameController.clear();
        });
      }else{
        loadingDialog(message: "This referral code is already in use.",button: true);
      }
    });



  }

}