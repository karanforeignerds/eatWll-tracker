import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Nutrition/Refferals/Controller/referral_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Referrals extends StatelessWidget {
  Referrals({super.key});

  final controller = Get.put(ReferralController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            backNavigation: true,
            title: "Referrals",
            profile: true,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Referrals")
                    .where('userId', isEqualTo: auth.currentUser!.uid)
                    .snapshots(),
                builder: (_, referralSnapshot) {
                  if (referralSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (referralSnapshot.data!.docs.isEmpty) {
                    return Center(
                        child: CustomText(
                      text: "No Clients",
                    ));
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Column(
                        children: [
                          Card(
                            color: darkGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "If you want to follow your client’s use of the Tracker, instruct them to use Their Referral Code.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SfProDisplay',
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: referralSnapshot.data!.size,
                              itemBuilder: (_, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: AppColors.white2,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.shadowColor
                                                .withOpacity(0.1),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(0, 5))
                                      ]),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          "assets/clients.png",
                                          height: 60,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      //${referralSnapshot.data!.docs[index]['clientName']}
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: referralSnapshot
                                                      .data!.docs[index]
                                                      .data()
                                                      .toString()
                                                      .contains('clientName')
                                                  ? "${referralSnapshot.data!.docs[index]['clientName']}"
                                                  : ".....",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                                child: CustomText(
                                              text:
                                                  "Referral Code: ${referralSnapshot.data!.docs[index]['code']}",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors.lightGreen,
                                            )),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            referralSnapshot
                                                .data!.docs[index].reference
                                                .delete();
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: lightGreen,
                                          )),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openReferralDialog(context);
        },
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.lightGreen,
        // mini: true,
      ),
    );
  }
}

_openReferralDialog(BuildContext context) {
  final controller = Get.put(ReferralController());
  controller.nameController.clear();
  controller.codeController.value.clear();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            // gradient: LinearGradient(
            //   colors: [
            //     AppColors.white.withOpacity(0.6),
            //     AppColors.black.withOpacity(0.6),
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          width: Get.width * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: CustomText(
                      align: TextAlign.center,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      text: "Add Code",
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                          text: "Name",
                          color: AppColors.greyBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.shadowColor,
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3))
                        ]),
                    child: CustomTextField(
                      textFieldColor: AppColors.white2,
                      hint: "xyz",
                      hintSize: 14,
                      onValidate: (val) {
                        if (val!.trim().isEmpty) {
                          return "Name is not empty";
                        }
                        return null;
                      },
                      controller: controller.nameController,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        controller.generateCode();
                      },
                      child: CustomText(
                        text: "Auto Generate",
                        color: AppColors.lightGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        underLine: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.shadowColor,
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3))
                        ]),
                    child: Obx(() => CustomTextField(
                          textFieldColor: AppColors.white2,
                          hint: "0000",
                          enabled: false,
                          hintSize: 14,
                          onValidate: (val) {
                            if (val!.trim().isEmpty) {
                              return "Generate Auto Code";
                            }
                            return null;
                          },
                          controller: controller.codeController.value,
                        )),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       controller.generateCode();
                  //     },
                  //     child: CustomText(
                  //       text: "Auto Generate",
                  //       color: AppColors.lightGreen,
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 14,
                  //       underLine: true,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomButton(
                    text: "Okay",
                    radius: 5,
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addReferral();
                        controller.isAddReferral.value = false;
                      }
                    },
                    height: 45,
                    width: 135,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
