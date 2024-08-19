import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/connectivity_check.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/no_internet_service.dart';
import 'package:eatwelltracker/pages/LogFoods/Controller/add_food_controller.dart';
import 'package:eatwelltracker/pages/PortionReference/portion_reference.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/drop_down.dart';

class AddFood extends StatelessWidget {
  AddFood({Key? key, required this.appBarTitle, required this.dateTime})
      : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(AddFoodController());
  final String appBarTitle;
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Obx(() => isInternetAvailable.value
        ? Scaffold(
            key: scaffoldKey,
            endDrawer: const SideDrawer(),
            body: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  AppBarWidget(
                    profile: true,
                    backNavigation: true,
                    centerTitle: true,
                    scfolldKey: scaffoldKey,
                    title: appBarTitle,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              List<String> categorySnapshot = ["Select Category"];
                              RxList<List<String>> servings = [['Select Serving']].obs;
                              for (int i = 0; i < snapshot.data!.docs.length+1; i++) {
                                if(i==snapshot.data!.docs.length){
                                  categorySnapshot.add("MyDishes");
                                }else{
                                  categorySnapshot.add(snapshot.data!.docs[i]['name']);
                                }
                                List<String> list = ['Select Serving'];
                                if (i==snapshot.data!.docs.length) {
                                  FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("MyDishes").get()
                                      .then((value) {
                                    if (value.docs.isNotEmpty) {
                                      for (int k = 0; k < value.docs.length; k++) {
                                          list.add(value.docs[k]['logFoodType']);
                                      }
                                    }
                                  });
                                } else {
                                  for (int j = 0; j < snapshot.data!.docs[i]['servings'].length; j++) {
                                    list.add(snapshot.data!.docs[i]['servings'][j]);
                                  }
                                }
                                servings.add(list);
                              }
                              controller.selectedCategory.value = "";
                              controller.selectedServing.value = "Select Serving";
                              controller.selectedIndex.value = 0;
                              print(categorySnapshot);
                              print(servings);

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  const CustomText(
                                    color: AppColors.greyBlack,
                                    text: "Select Category",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  const SizedBox(height: 16),
                                  DropdownWidget(
                                    value: categorySnapshot[0],
                                    list: categorySnapshot,
                                    onchange: (value) async {
                                      print(value);
                                      controller.selectedIndex.value = categorySnapshot.indexOf(value);
                                      controller.selectedServing.value = "Select Serving";
                                      controller.selectedCategory.value = value;
                                      controller.otherServingName.clear();
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  Obx(() => CustomText(
                                        color: AppColors.greyBlack,
                                        text:
                                            controller.selectedCategory.value ==
                                                    "Other"
                                                ? "Other category"
                                                : "Select Serving",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  const SizedBox(height: 16),
                                  Obx(
                                    () => controller.selectedCategory.value ==
                                            "Other"
                                        ? CustomTextField(
                                            controller:
                                                controller.otherServingName,
                                            onValidate: (val) {
                                              if (val!.trim().isEmpty) {
                                                return "Field is required";
                                              }
                                              controller.selectedServing.value =
                                                  val.toString();
                                              return null;
                                            },
                                            hint: "Add name",
                                            hintSize: 14,
                                            textFieldColor:
                                                Colors.grey.withOpacity(0.1))
                                        : DropdownWidget(
                                            value: controller
                                                .selectedServing.value,
                                            list: servings[
                                                controller.selectedIndex.value],
                                            onchange: (val) {
                                              controller.selectedServing.value =
                                                  val;
                                            }),
                                  ),
                                  const SizedBox(height: 24),
                                  Obx(() => controller.selectedCategory.value !=
                                      "MyDishes"?const CustomText(
                                    color: AppColors.greyBlack,
                                    text: "Quantity",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ):SizedBox()),
                                 Obx(() =>  SizedBox(height: controller.selectedCategory.value !=
                                     "MyDishes"?16:0),),
                                  Obx(() => controller.selectedCategory.value !=
                                      "MyDishes"?CustomTextField(
                                      keyBoardType:
                                      TextInputType.numberWithOptions(
                                          decimal: true),
                                      controller: controller.quantityController,
                                      onValidate: (val) {
                                        if (val!.trim().isEmpty) {
                                          return "Quantity is required";
                                        }
                                        return null;
                                      },
                                      hint: "Enter Quantity",
                                      hintSize: 14,
                                      textFieldColor:
                                      Colors.grey.withOpacity(0.1)):SizedBox()),
                                  Obx(() => SizedBox(height: controller.selectedCategory.value !=
                                      "MyDishes"?24:0)),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => PortionReference());
                                        },
                                        child: CustomText(
                                          text: "Portion Reference",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.lightGreen,
                                          underLine: true,
                                        )),
                                  ),
                                  SizedBox(height: Get.height * 0.07),
                                  Align(
                                      alignment: Alignment.center,
                                      child: CustomButton(
                                        text: "Add",
                                        radius: 15,
                                        onPressed: () async {
                                          isInternetAvailable.value =
                                              await checkConnectivity();
                                          if (isInternetAvailable.value) {controller.addFood(appBarTitle: appBarTitle, dateTime: dateTime);
                                          } else {
                                            loadingDialog(
                                                message:
                                                    "Please check your internet connection",
                                                button: true);
                                          }
                                        },
                                        height: 53,
                                        width: 172,
                                      )),
                                  SizedBox(height: 20),
                                ],
                              );
                            },
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        : NoInternetService());
  }
}
