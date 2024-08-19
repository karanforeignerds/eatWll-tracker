import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/Model/set_goal_wid_model.dart';

class SetGoalController extends GetxController{

  final RxBool isExpanded=false.obs;
  final RxString selectedTemplate="Select save template".obs;
  var selected = false.obs;

  RxList<SetGoalWidgetModel> setGoalData = [
    SetGoalWidgetModel(name: "Meat/Protein", count: 0.obs),
    SetGoalWidgetModel(name: "Dairy", count: 0.obs),
    SetGoalWidgetModel(name: "Vegetable", count: 0.obs),
    SetGoalWidgetModel(name: "Fruit", count: 0.obs),
    SetGoalWidgetModel(name: "Bread/Starch", count: 0.obs),
    SetGoalWidgetModel(name: "Water", count: 0.obs),
    SetGoalWidgetModel(name: "Other", count: 0.obs),
  ].obs;

  saveGoal(){
    List goalData=[];
    for(int i=0;i<setGoalData.length;i++){
      SetGoalWidgetModel data = setGoalData[i];
      goalData.add({
        "name":data.name,
        "quantity":data.count!.value,
      });
    }

    if (selected.value) {
      saveAsTemplate( goalData: goalData);
    }else{
      FirebaseFirestore.instance.collection("Goals").doc(auth.currentUser!.uid).set({
        "goal":goalData,
      }).then((value){
        FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Goals").doc(DateFormat('yyyy-MM-dd').format(DateTime.now())).get().then((checkTodayGoalExistence){
          if(checkTodayGoalExistence.exists){
            checkTodayGoalExistence.reference.update({
              "goal":goalData,
            });
          }
        });
      });
      Get.back();
    }
  }
  saveAsTemplate({required List goalData}){
    final  templateNameController=TextEditingController();
    final formKey=GlobalKey<FormState>();
    Get.defaultDialog(
        title: "",
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: Get.width * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        color: AppColors.black,
                        text: "Enter Template Name",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        align: TextAlign.start,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hint: "Template Name",
                    controller: templateNameController,
                    onValidate: (val){
                      if(val!.trim().isEmpty){
                        return "Enter template name";
                      }
                      return null;
                    },

                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: "Save",
                    radius: 15,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                           FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Templates").add({
                             "name":templateNameController.text,
                             "goal":goalData,
                           });
                           FirebaseFirestore.instance.collection("Goals").doc(auth.currentUser!.uid).set({
                             "goal":goalData,
                           });
                           Get.close(2);
                      }
                    },
                    width: 172,
                    height: 53,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}