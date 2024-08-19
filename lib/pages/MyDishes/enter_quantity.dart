import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../connectivity_check.dart';
import '../../constants/string.dart';
import '../../main.dart';
import '../../widgets/button.dart';
import '../../widgets/loading_widget.dart';
import 'add_dish.dart';

class EnterQuantity extends StatelessWidget {
  EnterQuantity({Key? key, required this.dishSnapshot, this.viewUserSnapshot}) : super(key: key);

  final DocumentSnapshot dishSnapshot;
  final DocumentSnapshot? viewUserSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white3,
      body: Column(children: [
        AppBarWidget(
          profile: true,
          title: dishSnapshot['logFoodType'],
          centerTitle: true,
          backNavigation: true,
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Items:",
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 20),
                      itemCount: dishSnapshot['items'].length,
                      itemBuilder: ((_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: dishSnapshot['items'][index]['serving'],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),
                              Container(
                                height: 23,
                                width: 32,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: AppColors.greyBlack, width: 2),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffFFE9B8),
                                          Color(0xffFFE9B8),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight)),
                                child: Center(
                                    child: CustomText(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: AppColors.blackLight,
                                  text: dishSnapshot['items'][index]
                                      ['quantity'],
                                )),
                              )
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ))),
        viewUserSnapshot==null?Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      width: 178,
                      height: 53,
                      text: 'Add to Meal',
                      radius: 15,
                      onPressed: () async {
                        String mealSelected = '';

                        RxInt selected = 0.obs;

                        await showDialog(
                          barrierDismissible: true,
                          context: Get.context!,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: AppColors.white,
                              elevation: 1,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListView.builder(
                                      padding: const EdgeInsets.only(
                                          left: 7,
                                          right: 7,
                                          top: 7,
                                          bottom: 16),
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: logFood.length - 1,
                                      itemBuilder: (context, index) {
                                        return Obx(
                                          () => ListTile(
                                            onTap: () {
                                              print(index);
                                              print("TAPPED");
                                              selected.value = index;
                                            },
                                            tileColor: index == selected.value
                                                ? AppColors.lightGreen
                                                : Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                    logFood[index].image!,
                                                    height: 30,
                                                    width: 30,
                                                    fit: BoxFit.cover)),
                                            title: Text(
                                              logFood[index].title!,
                                              style: TextStyle(
                                                  fontFamily: "SfProDisplay",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    CustomButton(
                                      width: 178,
                                      height: 53,
                                      text: 'OK',
                                      radius: 15,
                                      onPressed: () async {
                                        if (selected.value == 0) {
                                          mealSelected = 'Breakfast';
                                        } else if (selected.value == 1) {
                                          mealSelected = 'Morning';
                                        } else if (selected.value == 2) {
                                          mealSelected = 'Lunch';
                                        } else if (selected.value == 3) {
                                          mealSelected = 'Afternoon Snack';
                                        } else if (selected.value == 4) {
                                          mealSelected = 'Dinner';
                                        } else {
                                          mealSelected = 'Evening Snack';
                                        }

                                        Get.back();
                                      },
                                    ),
                                    SizedBox(height: 20),
                                  ]),
                              //actions: [],
                            );
                          },
                        );

                        if (mealSelected != '') {
                          bool connected = await checkConnectivity();

                          if (connected) {
                            for (int k = 0;
                                k < dishSnapshot['items'].length;
                                k++) {
                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(auth.currentUser!.uid)
                                  .collection('LogFood')
                                  .add({
                                'category': dishSnapshot['items'][k]
                                    ['category'],
                                'date': DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now()),
                                'logFoodType': mealSelected,
                                'quantity': dishSnapshot['items'][k]
                                    ['quantity'],
                                'serving': dishSnapshot['items'][k]['serving'],
                                'time': DateTime.now().millisecondsSinceEpoch
                              });
                            }

                            loadingDialog(
                                message: 'Dish Added to Log', button: true);
                          } else {
                            loadingDialog(
                                message: 'Could not connect to the internet',
                                button: true);
                          }
                        }
                        ;
                      }),
                  CustomButton(
                    width: 178,
                    height: 53,
                    text: 'Edit Dish',
                    radius: 15,
                    onPressed: () async {
                      Get.to(() => AddDish(
                          dateTime: DateTime.now(),
                          isEdit: true,
                          dishSnapshot: dishSnapshot));
                    },
                  ),
                ])):SizedBox(),
      ]),
    );
  }
}
