import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/InviteFriend/invite_friend_controller.dart';
import 'package:eatwelltracker/validation/validations.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteFriend extends StatelessWidget {
  InviteFriend({Key? key}) : super(key: key);

  final controller = Get.put(InviteFriendController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            backNavigation: true,
            title: "Invite Friends",
            centerTitle: true,
            profile: true,
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("AppUrl")
                    .doc('url')
                    .snapshots(),
                builder: (_, appUrlSnapshot) {
                  if (appUrlSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 30.0, bottom: 27),
                            child: CustomText(
                              text: "Email",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.greyBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 36.0),
                            child: CustomTextField(
                              textFieldColor: AppColors.white,
                              hint: "Enter email",
                              trim: true,
                              controller: controller.emailController,
                              onValidate: (val) => emailValidation(val),
                              preFixWidget: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Image.asset("assets/email.png",
                                    height: 24, width: 24),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 6,
                                color: AppColors.yellow,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              CustomText(
                                color: AppColors.greyBlack,
                                text: "Invite your friends via email",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: CustomButton(
                              text: "Share",
                              radius: 20,
                              onPressed: () async {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.sendEmail(
                                      url: appUrlSnapshot.data!['url'] != ""
                                          ? appUrlSnapshot.data!['url']
                                          : "www.eatWellTracker.com");
                                }},
                              height: 53,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
/*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      CustomText(
                        text: "Your Referral Code",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyBlack,
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Container(
                        height: 49,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.greyBlack.withOpacity(0.15),
                                spreadRadius: 5,
                                blurRadius: 4,
                                offset: Offset(0, 3)),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * 0.75,
                              child: CustomText(
                                color: AppColors.greyBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                text: referralCode == ""
                                    ? "Your don't have referral Code"
                                    : referralCode,
                                maxLine: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  if (referralCode != "") {
                                    await Clipboard.setData(
                                            ClipboardData(text: referralCode))
                                        .then((value) {
                                      Get.showSnackbar(GetSnackBar(
                                        titleText: CustomText(text: "Copied",fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
                                        message: "Referral Code has been copied.",
                                        duration: Duration(seconds: 5),
                                        backgroundColor: AppColors.lightGreen,
                                      ));
                                    });
                                  }
                                },
                                child: Image.asset(
                                  "assets/copy.png",
                                  height: 18,
                                  color: darkGreen,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.yellow,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          CustomText(
                            color: AppColors.greyBlack,
                            text: "Invite your friends via your referral code",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.yellow,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          CustomText(
                            color: AppColors.greyBlack,
                            text: "Ask your friends to sign up",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 6,
                            color: AppColors.yellow,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          CustomText(
                            color: AppColors.greyBlack,
                            text: "Enjoy App free for one week",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: "Send",
                        radius: 20,
                        onPressed: () async {
                          await Share.share(
                            "Download this Amazing App\ncheck out this Amazing app on https://www.eatwell.com\n Use My referral code to Signup \n $referralCode",
                            subject:
                                "check out this Amazing app on https://www.eatwell.com\n Use My referral code to Signup \n ${referralCode.toString()}",
                          );
                        },
                        height: 53,
                      ),
                    ],
                  ),
                );*/
