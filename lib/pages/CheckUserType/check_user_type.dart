import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/no_internet_service.dart';
import 'package:eatwelltracker/pages/DashBoard/dashboard.dart';
import 'package:eatwelltracker/pages/Nutrition/Dashboard/nutrion_dashboard.dart';
import 'package:eatwelltracker/pages/Subscription/subscription.dart';
import 'package:eatwelltracker/purchases/check_subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckUserType extends StatelessWidget {
  const CheckUserType({super.key, this.formRegister = false});

  final bool formRegister;

  @override
  Widget build(BuildContext context) {
    print(auth.currentUser!.email);
    return Obx(() => isInternetAvailable.value
        ? StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(auth.currentUser!.uid)
                .snapshots(),
            builder: (_, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.lightGreen,
                    ),
                  ),
                );
              }
              userInfo = userSnapshot.data!;
              return userSnapshot.data!['type'] == "User"
                  ? DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(
                              userSnapshot.data!['subscriptionValidTill']
                                  .millisecondsSinceEpoch)) ||
                          Get.find<CheckSubscription>().entitlement ==
                              Entitlement.free
                      ? DashboardScreen(
                          userData: userSnapshot.data!,
                          fromRegistration: formRegister,
                        )
                      : SubscriptionPlan(
                          isShowBackButton: false,
                        )
                  : NutritionDashboard(
                      userData: userSnapshot.data!,
                    );
            },
          )
        : NoInternetService());
  }
}
