import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/About/about.dart';
import 'package:eatwelltracker/pages/PortionReference/portion_reference.dart';
import 'package:eatwelltracker/pages/Profile/profile.dart';
import 'package:eatwelltracker/pages/Subscription/subscription.dart';
import 'package:eatwelltracker/pages/Terms/terms.dart';
import 'package:eatwelltracker/widgets/delete_account_popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../pages/Authentication/TypeSelection/join_as.dart';
import 'loading_widget.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.white,
      width: Get.width,
      child: Row(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              width: Get.width * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
            ),
          ),
          Container(
            color: AppColors.lightGreen,
            width: Get.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(auth.currentUser!.uid)
                        .snapshots(),
                    builder: (_, profileSnapshot) {
                      if (profileSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Get.back();
                              Get.to(() => Profile());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 30),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: profileSnapshot.data!['image'] !=
                                              ""
                                          ? NetworkImage(
                                              profileSnapshot.data!['image'])
                                          : AssetImage("assets/profile.png")
                                              as ImageProvider,
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profileSnapshot.data!['name'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(profileSnapshot.data!['email'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal))
                            ],
                          )
                        ],
                      );
                    }),

                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => Profile());
                    },
                    child: tile(name: "Profile Information")),

                GestureDetector(
                    onTap: () {
                      Get.to(SubscriptionPlan());
                    },
                    child: tile(name: "Subscription")),
                GestureDetector(
                    onTap: () {
                      Get.to(const About());
                    },
                    child: tile(name: "About")),
                GestureDetector(
                    onTap: () {
                      Get.to(const TermsOfServices());
                    },
                    child: tile(name: "Terms of Use & Privacy Policy")),

                GestureDetector(
                    onTap: () {
                      Get.to(PortionReference());
                    },
                    child: tile(name: "Portion Reference")),
                GestureDetector(
                    onTap: () {
                      deleteAccount(context);
                    },
                    child: tile(name: "Delete Account")),
                GestureDetector(
                    onTap: () {
                      loadingDialog(
                          message: 'Are you sure you want to logout?',
                          button: true,
                          log: true,
                          onPressed: () {
                            auth.signOut();
                            Get.offAll(() => JoinAs());
                          });
                    },
                    child: tile(name: "Logout")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget tile({required String name}) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 2,
        color: Colors.white,
      ),
      Container(
        // margin: const EdgeInsets.symmetric(vertical: 18),
        padding: const EdgeInsets.only(left: 30, top: 18, bottom: 18),
        // height: 50,
        width: double.infinity,
        color: Colors.transparent,
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}


// GestureDetector(
//     onTap: (){
//       Get.back();
//       Get.to(const InviteFriend());
//     },
//     child: tile(name: "Share your referral code")),

// GestureDetector(
//     onTap: () {
//       Get.back();
//       Get.to(const PrivacyPolicy());
//     },
//     child: tile(name: "Privacy Policy")),