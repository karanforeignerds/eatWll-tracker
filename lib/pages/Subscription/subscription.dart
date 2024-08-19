import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Subscription/Controller/subscription_controller.dart';
import 'package:eatwelltracker/purchases/check_subscription.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SubscriptionPlan extends StatelessWidget {
  SubscriptionPlan({Key? key, this.isShowBackButton=true}) : super(key: key);
  final bool isShowBackButton;

  final controller=Get.put(SubscriptionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppBarWidget(
            title: "Subscription",
            centerTitle: isShowBackButton,
            backNavigation: isShowBackButton,
            profile: true,
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                   Obx(() => ListView.builder(
                       physics: const NeverScrollableScrollPhysics(),
                       primary: false,
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       itemCount: controller.subscriptionPackages.length,
                       itemBuilder: (_,int index){

                         return SubscriptionCard(data: controller.subscriptionPackages[index]);

                       })),
                    Obx(() => controller.subscriptionPackages.isEmpty?
                    CustomText(text: "No Plans Found")
                        :SizedBox()
                   /* buildEntitlement(entitlement)*/),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //todo return subscription status widget
  Widget buildEntitlement(Entitlement entitlement){
    switch (entitlement){
      case Entitlement.allCourses:
        return CustomText(text: "You ar on paid Plan");
      case Entitlement.free:
      default:
      return CustomText(text: "You ar on free Plan");
    }
  }
}
