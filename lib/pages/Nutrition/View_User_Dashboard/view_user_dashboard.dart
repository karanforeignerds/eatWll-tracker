import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/pages/DailyActivity/daily_activity.dart';
import 'package:eatwelltracker/pages/Home/home.dart';
import 'package:eatwelltracker/pages/IntakeHistory/intake_history.dart';
import 'package:eatwelltracker/pages/Nutrition/View_User_Dashboard/controller/view_user-dashboard_controller.dart';
import 'package:eatwelltracker/pages/Nutrition/view_user_goal/view_user_goal.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/logFood_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUserDashboard extends StatelessWidget {
  final DocumentSnapshot userSnapshot;
  ViewUserDashboard({super.key,required this.userSnapshot});

  final controller=Get.put(ViewUserDashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            backNavigation: true,
            title: "${userSnapshot['name']}",
            centerTitle: true,
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LogFoodWidget(
                    image: "assets/logfood.png",
                    title: "Log Food",
                    onTap: () {
                      Get.to(() => Home(viewUserSnapshot: userSnapshot,));
                    },
                  ),
                  LogFoodWidget(
                    image: "assets/daily.png",
                    title: "Daily Activity",
                    onTap: () {
                      Get.to(() => DailyActivity(viewUserSnapshot: userSnapshot,));
                    },
                  )
                ],
              ),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LogFoodWidget(
                    image: "assets/history.png",
                    title: "Intake History",
                    onTap: () {
                      Get.to(() => IntakeHistory(viewUserSnapshot: userSnapshot,));
                    },
                  ),
                  LogFoodWidget(
                    image: "assets/goal.png",
                    title: "Goals",
                    onTap: () {
                      Get.to(()=>ViewUserGoal(viewUserSnapshot: userSnapshot,));
                      // Get.to(()=>SetGoals());
                    },
                  )
                ],
              ),

            ],
          ),
        ],
      )
    );
  }
}
