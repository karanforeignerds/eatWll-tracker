import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/constants/string.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Goals/set_goals.dart';
import 'package:eatwelltracker/pages/PickForMe/pick_for_me.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:eatwelltracker/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// todo Goals
class Goals extends StatelessWidget {
  Goals({Key? key}) : super(key: key);
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      endDrawer: const SideDrawer(),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppBarWidget(
                scfolldKey: scaffoldkey,
                title: "Goal",
                centerTitle: true,
                backNavigation: true,
                profile: true,
                onPressed: () {
                    Get.back();
                },
              ),
          Align(
                alignment:  Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12),
                  child:GestureDetector(
                          onTap: () {
                           Get.to(()=>PickForMe(isFromSetGoal: false,));
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
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                      .collection("Goals")
                      .doc(auth.currentUser!.uid)
                      .snapshots(),
              builder: (_, goalSnapshot) {
                if (goalSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: Column(
                    children: [
                      !goalSnapshot.data!.exists
                          ? Center(
                              child: CustomText(
                                text: "Empty",
                                color: AppColors.greyBlack,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: goalSnapshot.data!['goal'].length,
                                itemBuilder: (_, int index) {
                                  return HomeCard(
                                    isPickForMe: false,
                                    data: goalsCardData[index],
                                    height: 140,
                                    name: goalSnapshot.data!['goal'][index]
                                        ['name'],
                                    quantity: int.parse(goalSnapshot
                                        .data!['goal'][index]['quantity']
                                        .toString()),
                                  );
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 140,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: 3),
                              ),
                            ),
                      Expanded(
                        child: const SizedBox(
                          height: 0,
                        ),
                      ),
                      CustomButton(
                            text: "Set Goals",
                            radius: 15,
                            onPressed: () {
                              Get.to(() => SetGoals());
                            },
                            height: 53,
                            width: 178,
                          ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
