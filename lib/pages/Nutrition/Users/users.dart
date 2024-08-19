import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Nutrition/Users/Controller/user_controller.dart';
import 'package:eatwelltracker/pages/Nutrition/View_User_Dashboard/view_user_dashboard.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends StatelessWidget {
  UserView({super.key});

  final controller =Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: [
          AppBarWidget(backNavigation: true,centerTitle: true,title: "My Clients",profile: true),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("ReferralUsers").where('nutritionistId',isEqualTo: auth.currentUser!.uid).snapshots(),
                builder: (_,referralUserSnapshot){

                  if(referralUserSnapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(referralUserSnapshot.data!.docs.isEmpty){
                    return Center(child:  CustomText(text: "No Clients"),);
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(text: TextSpan(
                                style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,fontFamily: "SfProDisplay"),
                                children: [
                                  TextSpan(text: "Total Referrals: ",style: TextStyle(color: AppColors.greyBlack)),
                                  TextSpan(text:  referralUserSnapshot.data!.size.toString(),style: TextStyle(color: AppColors.lightGreen)),
                                ]
                            )),
                          ),
                          SizedBox(height: 8,),
                          ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: referralUserSnapshot.data!.size,
                              padding: EdgeInsets.zero,
                              itemBuilder: (_,int index){
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection("Users").doc(referralUserSnapshot.data!.docs[index]['userId']).snapshots(),
                                    builder: (_,userSnapshot){
                                      if(userSnapshot.connectionState==ConnectionState.waiting){
                                        return SizedBox();
                                      }
                                      if(!userSnapshot.data!.exists){
                                        return SizedBox();
                                      }

                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(()=>ViewUserDashboard(userSnapshot: userSnapshot.data!,));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 8),
                                          padding: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                          decoration: BoxDecoration(
                                              color: AppColors.white2,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(color: AppColors.shadowColor.withOpacity(0.1),blurRadius: 5,spreadRadius: 1,offset: Offset(0,5))
                                              ]
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Image.network(userSnapshot.data!['image'],errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    height: 60,
                                                      width: 80,
                                                      decoration: BoxDecoration(color: lightGreen),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.asset('assets/profile2.png',color: Colors.white,),
                                                      ));
                                                },),
                                              ),
                                              SizedBox(width: 16,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(text: userSnapshot.data!['name'],fontWeight: FontWeight.w700,fontSize: 14,),
                                                  SizedBox(height: 4,),
                                                  CustomText(text: userSnapshot.data!['referralCode'],fontWeight: FontWeight.w700,fontSize: 14,color: lightGreen,)
                                                ],
                                              )
                                            ],
                                          ),

                                        ),
                                      );
                                    });
                              })
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
