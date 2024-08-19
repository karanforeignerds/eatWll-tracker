import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../widgets/loading_widget.dart';

class MyDishesController extends GetxController {
  RxList<Widget> items = <Widget>[Container()].obs;
  final dishNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ///
  List<TextEditingController> quantityControllers = [TextEditingController()];
  List<TextEditingController> otherCategoryControllers = [
    TextEditingController()
  ];

  List<RxInt> selectedIndex = [];
  List<RxString> selectedServing = [];
  List<RxString> selectedCategory = [];

  ///

  addDish({required DateTime date}) {
    loadingDialog(message: "Adding...", loading: true);
    bool selectCategory = false;
    List<Map<String, dynamic>> itemList = [];

    for (int i = 0; i < items.length; i++) {
      print(selectedCategory[i].toString() + selectedServing[i].toString());
      if (selectedCategory[i].value == "Select Category" ||
          selectedServing[i].value == "Select Serving") {
        selectCategory = true;
        Get.back();
        loadingDialog(
            message: "Select category of item ${i + 1}", button: true);
      } else {
        itemList.add({
          'category': selectedCategory[i].value,
          "serving": selectedServing[i].value,
          'quantity': quantityControllers[i].text,
        });
      }

      /// if all item satisfied
      if (itemList.length == items.length && selectCategory == false) {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser!.uid)
            .collection("MyDishes")
            .add({
          "date": DateFormat('yyyy-MM-dd').format(date),
          "logFoodType": dishNameController.text,
          "items": itemList,
          'time': DateTime.now().millisecondsSinceEpoch,
        }).then((value) {
        }).whenComplete(() {
          dispose();
          Get.close(2);
        });
      }
    }
  }

  editDish({required DocumentSnapshot dishSnapshot}) {
    List<Map<String, dynamic>> itemList = [];

    loadingDialog(message: "Saving Changes...", loading: true);

    for (int i = 0; i < items.length; i++) {
      itemList.add({
        'category': selectedCategory[i].value,
        "serving": selectedServing[i].value,
        'quantity': quantityControllers[i].text,
      });
    }

    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('MyDishes')
        .doc(dishSnapshot.id)
        .update({
          'logFoodType': dishNameController.text,
          'items': itemList,
        })
        .then((value) {})
        .whenComplete(() {
          dispose();
          Get.close(3);
        });
  }

  @override
  void dispose() {
    items.clear();
    dishNameController.clear();
    quantityControllers.clear();
    otherCategoryControllers.clear();
    selectedIndex.clear();
    selectedServing.clear();
    selectedCategory.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
