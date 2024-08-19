import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Goals/Controller/set_goal_controller.dart';
import 'package:eatwelltracker/pages/PickForMe/pick_for_me.dart';
import 'package:eatwelltracker/widgets/Model/set_goal_wid_model.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:eatwelltracker/widgets/set_goal_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class SetGoals extends StatelessWidget {
  SetGoals({
    Key? key,
  }) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller = Get.put(SetGoalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.white,
      endDrawer: SideDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBarWidget(
            scfolldKey: scaffoldKey,
            profile: true,
            backNavigation: true,
            centerTitle: true,
            title: "Set Goals",
            onPressed: () {
              Get.back();
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => PickForMe(
                        isFromSetGoal: true,
                      ));
                },
                child: const CustomText(
                    color: AppColors.skyBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    text: "Pick for me",
                    underLine: true),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 4,
                          spreadRadius: 3,
                          offset: Offset(1, 4))
                    ],
                    color: AppColors.white2,
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                margin: EdgeInsets.only(top: 24, bottom: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          text: "Category",
                          color: AppColors.lightGreen,
                        ),
                        CustomText(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          text: "Quantity",
                          color: AppColors.lightGreen,
                        )
                      ],
                    ),
                    StreamBuilder(
                        stream: auth.currentUser == null
                            ? null
                            : FirebaseFirestore.instance
                                .collection("Goals")
                                .doc(auth.currentUser!.uid)
                                .snapshots(),
                        builder: (context, goalSnapshot) {
                          if (goalSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var data = goalSnapshot.data?.data();
                          if (data != null) {
                            // controller.setGoalData =
                            //     RxList<SetGoalWidgetModel>.from(
                            //         data['goal'].map((e) => SetGoalWidgetModel(
                            //               name: e['name'],
                            //               count: (e['quantity']).obs,
                            //             )));

                            for (var goal in controller.setGoalData) {
                              for (var data in data['goal']) {
                                if (goal.name == data['name']) {
                                  goal.count!.value = data['quantity'];
                                }
                              }
                            }
                          }

                          return Obx(
                            () => Column(
                              children: List.generate(
                                controller.setGoalData.length,
                                (index) {
                                  SetGoalWidgetModel data =
                                      controller.setGoalData[index];
                                  return Obx(() => SetGoalWidget(
                                        name: data.name,
                                        count: data.count!.value,
                                        onDecrementPressed: () {
                                          if (data.count != 0) {
                                            data.count!.value--;
                                          }
                                        },
                                        onIncrementPressed: () {
                                          data.count!.value++;
                                        },
                                      ));
                                },
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 12,
                    ),
                    CustomButton(
                      text: "Save Goal",
                      radius: 15,
                      height: 53,
                      width: 178,
                      onPressed: () {
                        controller.saveGoal();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
