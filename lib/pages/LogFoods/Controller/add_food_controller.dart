import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddFoodController extends GetxController{


  final formKey=GlobalKey<FormState>();
  final quantityController=TextEditingController();
  final otherServingName=TextEditingController();


  RxInt selectedIndex=0.obs;
  RxString selectedServing= ''.obs;
  RxString selectedCategory="".obs;

  addFood({required DateTime dateTime,required String appBarTitle}){

    print( DateFormat("yyyy-MM-dd").format(dateTime));

      if(selectedServing.value=="Select Serving" && selectedCategory.value!="Other"){
        loadingDialog(message: "Please Select Serving",button: true);
      }else if(selectedCategory.value=="Select Category"){
        loadingDialog(message: "Please Select Category",button: true);
      }else{
        if(formKey.currentState!.validate()){
        loadingDialog(message: "Adding...",loading: true);
        FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Goal").doc(DateFormat("yyyy-MM-dd").format(dateTime)).get().then((value) async {

          /// adding goal data ========================================================================================
          if(!value.exists){
            print(1);
            await FirebaseFirestore.instance.collection('Goals').doc(auth.currentUser!.uid).get().then((goalData){
              if(goalData.exists){
                print(2);
                FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Goals").doc(DateFormat("yyyy-MM-dd").format(dateTime)).set({
                  'date':DateFormat("yyyy-MM-dd").format(dateTime),
                  'goal':goalData['goal']
                });
                if(selectedCategory.value=="MyDishes"){
                  addMyDishesItemToLogFood(dateTime: dateTime,appBarTitle: appBarTitle);
                }else{
                  logFood0(dateTime: dateTime,appBarTitle: appBarTitle);
                }
              }
              else{
                print(3);
                if(selectedCategory.value=="MyDishes"){
                  addMyDishesItemToLogFood(dateTime: dateTime,appBarTitle: appBarTitle);
                }else{
                  logFood0(dateTime: dateTime,appBarTitle: appBarTitle);
                }
              }
            });
          }
          ///
          else{
            print(4);
            if(selectedCategory.value=="MyDishes"){
              addMyDishesItemToLogFood(dateTime: dateTime,appBarTitle: appBarTitle);
            }else{
              logFood0(dateTime: dateTime,appBarTitle: appBarTitle);
            }
          }

        });

        }
      }

  }

addMyDishesItemToLogFood({required DateTime dateTime,required String appBarTitle}){
  FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("MyDishes").where('logFoodType',isEqualTo: selectedServing.value).get().then((myDishesSnapshot){
    if(myDishesSnapshot.docs.isNotEmpty){
      for(int i=0;i<myDishesSnapshot.size;i++){
        for(int k=0;k<myDishesSnapshot.docs[i]['items'].length;k++){
          var category=myDishesSnapshot.docs[i]['items'][k]['category'];
          var serving=myDishesSnapshot.docs[i]['items'][k]['serving'];
          var quantity=myDishesSnapshot.docs[i]['items'][k]['quantity'];

          FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("LogFood").where('date',isEqualTo: DateFormat("yyyy-MM-dd").format(dateTime))
              .where('serving',isEqualTo: serving).where('category',isEqualTo: category).where('logFoodType',isEqualTo: appBarTitle)
              .get().then((value) {
            if(value.docs.isEmpty){
              print(10);
              FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection('LogFood').add(
                  {
                    "date":DateFormat("yyyy-MM-dd").format(dateTime),
                    "serving":serving,
                    "category":category,
                    "quantity":quantity,
                    "logFoodType":appBarTitle,
                    "time":DateTime.now().millisecondsSinceEpoch
                  });
            }else{
              print(12);
              var q=(double.parse(value.docs[0]["quantity"].toString())+double.parse(quantity.toString())).toString();
              value.docs[0].reference.update({
                "quantity":q,
                "time":DateTime.now().millisecondsSinceEpoch
              });
            }
          });
        }
      }
    }
  }).then((value) {
    selectedCategory.value="Select Category";
    selectedServing.value="Select Serving";
    quantityController.clear();
    Get.close(2);
  });
}


logFood0({required DateTime dateTime,required String appBarTitle}){
  FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("LogFood").where('date',isEqualTo: DateFormat("yyyy-MM-dd").format(dateTime))
      .where('serving',isEqualTo: selectedServing.value).where('category',isEqualTo: selectedCategory.value).where('logFoodType',isEqualTo: appBarTitle)
      .get().then((value) {

    if(value.docs.isEmpty){
      print(10);
      FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection('LogFood').add(
          {
            "date":DateFormat("yyyy-MM-dd").format(dateTime),
            "serving":selectedServing.value,
            "category":selectedCategory.value,
            "quantity":quantityController.text,
            "logFoodType":appBarTitle,
            "time":DateTime.now().millisecondsSinceEpoch
          }).then((value) {
        print(11);
        selectedCategory.value="Select Category";
        selectedServing.value="Select Serving";
        quantityController.clear();
        Get.close(2);
      });
    }else{
      print(12);
      var q=(double.parse(value.docs[0]["quantity"].toString())+double.parse(quantityController.text.toString())).toString();
      value.docs[0].reference.update({
        "quantity":q,
        "time":DateTime.now().millisecondsSinceEpoch
      }).then((value){
        print(14);

        selectedCategory.value="Select Category";
        selectedServing.value="Select Serving";
        quantityController.clear();
        Get.close(2);
      });
    }
  });
}

}