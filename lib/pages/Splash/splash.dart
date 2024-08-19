import 'dart:math';
import 'dart:ui';

import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Authentication/TypeSelection/join_as.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  // var pageIndex = 0.obs;

  final int index=Random().nextInt(9);
  final List splashPagesList = [
    {
      "title": 'Eat Well – off to a great start',
      "text":
          "You're making great progress towards a healthier you. Keep up the good work!\n Remember, food is fuel for your body. Choose wisely and your body will thank you.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
          "Congratulations on deciding to Eat Well!! Investing in your health is the best investment you can make. Without good health, all other wealth is meaningless. Your health is your most valuable asset, you are making a great investment by making sure you are eating well. A healthy body and mind are the foundation for a happy and fulfilling life. When you prioritize your health above all else, everything else will fall into place. Make the right choices today for your future.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
          "It's not about perfection, it's about progress. And you're making amazing progress towards your health goals. \nEating well is an act of self-love. Keep showing yourself that love every day.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "You're making great progress towards a healthier you. Keep up the good work!\n Remember, food is fuel for your body. Choose wisely and your body will thank you.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "Congratulations on deciding to Eat Well!! Investing in your health is the best investment you can make. Without good health, all other wealth is meaningless. Your health is your most valuable asset, you are making a great investment by making sure you are eating well. A healthy body and mind are the foundation for a happy and fulfilling life. When you prioritize your health above all else, everything else will fall into place. Make the right choices today for your future.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "It's not about perfection, it's about progress. And you're making amazing progress towards your health goals. \nEating well is an act of self-love. Keep showing yourself that love every day.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "You're making great progress towards a healthier you. Keep up the good work!\n Remember, food is fuel for your body. Choose wisely and your body will thank you.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "Congratulations on deciding to Eat Well!! Investing in your health is the best investment you can make. Without good health, all other wealth is meaningless. Your health is your most valuable asset, you are making a great investment by making sure you are eating well. A healthy body and mind are the foundation for a happy and fulfilling life. When you prioritize your health above all else, everything else will fall into place. Make the right choices today for your future.",
    },
    {
      "title": 'Eat Well – off to a great start',
      "text":
      "It's not about perfection, it's about progress. And you're making amazing progress towards your health goals. \nEating well is an act of self-love. Keep showing yourself that love every day.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Get.height * 0.83,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: Get.height * 0.65,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/style.png"))),
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
                              filter:
                              ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              // blendMode: BlendMode.dst

                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  // color: Colors.red,
                                  // padding: const EdgeInsets.symmetric(vertical: 90.0),
                                  child: CustomText(
                                    color: darkGreen,
                                    fontSize: 24,
                                    text: splashPagesList[index]['title'],
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          )),
                    ],
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: CustomText(
                      color: blackText,
                      fontSize: 14,
                      text: splashPagesList[index]['text'],
                      fontWeight: FontWeight.w500,
                      align: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: Get.height*0.17,
          child: Column(
            children: [

              Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => JoinAs());
                    },
                    child: Container(
                      height: 95,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/btnShape.png"),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: const CustomText(
                          color: Colors.white,
                          fontSize: 22,
                          text: "Login",
                          fontWeight: FontWeight.w500,
                          align: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

      ],
    )
);
  }
}
