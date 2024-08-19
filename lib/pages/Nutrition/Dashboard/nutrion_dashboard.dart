import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Nutrition/MyEarning/my_earning.dart';
import 'package:eatwelltracker/pages/Nutrition/Refferals/referrals.dart';
import 'package:eatwelltracker/pages/Nutrition/Users/users.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/delete_account_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionDashboard extends StatelessWidget {
  const NutritionDashboard({super.key, required this.userData});
  final DocumentSnapshot userData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          AppBarWidget(title: userData['name'],profile: false,showLogout: true),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>Referrals());
                      },
                      child: dashboardWidget(image: "assets/generate_code.png",title: "Referrals")),
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>UserView());
                      },
                      child: dashboardWidget(image: "assets/my_referal.png",title: "My Clients")),
                  GestureDetector(
                      onTap: (){
                        Get.to(()=>MyEarnings());
                      },
                      child: dashboardWidget(image: "assets/my_earning.png",title: "Charitable Contribution")),
                  GestureDetector(
                      onTap: (){
                        deleteAccount(context);
                      },
                      child: dashboardWidget(image: "assets/No data-pana 1.png",title: "Delete Account")),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget dashboardWidget({String? image,String? title}){
    return Container(
      width: Get.width,
      height: 217,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
          color: AppColors.white3,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: AppColors.shadowColor,spreadRadius: 2,blurRadius: 10)
          ]
      ),

      child: Column(
        children: [
          Container(
            height: 155,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 9),
            padding: EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(image!),
          ),
          SizedBox(height: 7,),
          CustomText(text: title,fontWeight: FontWeight.w700,fontSize: 18,),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}
