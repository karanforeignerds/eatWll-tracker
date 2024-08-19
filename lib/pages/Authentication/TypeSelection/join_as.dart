import 'dart:ui';

import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Authentication/SignIn/sign_in.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinAs extends StatelessWidget {
  const JoinAs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: Get.height * 0.65,
              width: Get.width,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/style.png"))),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset("assets/apple.png")),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                          height: Get.height * 0.6,
                          child: Image.asset("assets/fruitMan.png"))),
                  Positioned(
                      bottom: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          // blendMode: BlendMode.dst

                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: CustomText(
                                color: darkGreen,
                                fontSize: 24,
                                text: "Eat Well – off to a great start",
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      )),
                ],
              )),
          SizedBox(height: Get.height*0.05,),
          CustomButton(
            text: "Join as User",
            radius: 16,
            onPressed: () {
              Get.to(()=>SignIn(fromUser: true,));
            },
            borderColor: lightGreen,
            color: Colors.white,
            textStyle: TextStyle(
              color: lightGreen,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            width: Get.width * 0.35,
          ),
          SizedBox(height: Get.height*0.035,),
          CustomButton(
            text: "Join as nutritionist",
            radius: 16,
            onPressed: () {
              Get.to(()=>SignIn(fromUser: false,));
            },
            width: Get.width * 0.45,
          )
        ],
      ),
    );
  }
}
