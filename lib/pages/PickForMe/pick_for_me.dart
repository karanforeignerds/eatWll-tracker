import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/constants/string.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Goals/Controller/set_goal_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickForMe extends StatelessWidget {
  PickForMe({super.key, required this.isFromSetGoal});
  final bool isFromSetGoal;
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            scfolldKey: scaffoldkey,
            title:"Pick for me",
            centerTitle: true,
            backNavigation: true,
            profile: true,
            onPressed: () {
              Get.back();
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 12),
              child: CustomText(
                text: '"Based on USDA Standards"',
                color: AppColors.greyBlack,
                fontWeight: FontWeight.w700,
              )
            ),
          ),
          StreamBuilder<DocumentSnapshot>(
              stream:  FirebaseFirestore.instance
                  .collection("PreDefinedGoal")
                  .doc('goal')
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
                              isPickForMe: true,
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
                        text: "Pick Goal",
                        radius: 15,
                        onPressed: () {
                          if (isFromSetGoal==false) {
                            FirebaseFirestore.instance
                                .collection('Goals')
                                .doc(auth.currentUser!.uid)
                                .set({
                              'goal': goalSnapshot.data!['goal']
                            }).then((value) => Get.back());
                          } else {
                            for(int i=0;i<goalSnapshot.data!['goal'].length;i++){
                              for(var element in Get.find<SetGoalController>().setGoalData){
                                if(element.name.toString()==goalSnapshot.data!['goal'][i]['name']){
                                  element.count!.value=int.parse(goalSnapshot.data!['goal'][i]['quantity']);
                                }
                              }
                            }
                            Get.back();
                          }
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
