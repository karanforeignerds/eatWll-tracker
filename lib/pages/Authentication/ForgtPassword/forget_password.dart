import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/validation/validations.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/forget_password_controller.dart';

class ForgetPassword extends StatelessWidget {
  final bool fromUser;
  ForgetPassword({Key? key, this.fromUser = false}) : super(key: key);

  final controller = Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Form(
          key: controller.formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 40.0,
                        right: 40,
                        top: 40,
                        bottom: !fromUser ? 40 : 0),
                    child: Image.asset(
                      fromUser
                          ? "assets/forgot.png"
                          : "assets/Reset password-pana 1.png",
                    ),
                  ),
                  Positioned(
                      left: 16,
                      top: 36,
                      child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back)))
                ],
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.skyBlue.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 6)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          const CustomText(
                            text: "Forget Password",
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: CustomText(
                              align: TextAlign.center,
                              text:
                                  "Not to worry, it happens to the best of us."
                                  "please enter your email address below ",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          CustomTextField(
                            hint: "Email",
                            controller: controller.emailController,
                            onValidate: (val) => emailValidation(val),
                            preFixWidget: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Image.asset("assets/email.png",
                                  height: 24, width: 24),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  controller.resetPassword();
                                },
                                child: const CustomText(
                                  underLine: true,
                                  color: lightGreen,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  text: "Resend",
                                ),
                              )),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            text: "Submit",
                            radius: 20,
                            onPressed: () {
                              controller.resetPassword();
                            },
                            height: 53,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.blackLight.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                  offset: const Offset(1, 4))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.dialogTrue.value
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    controller.dialogTrue.value = false;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          AppColors.white.withOpacity(0.6),
                          AppColors.black.withOpacity(0.6),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: Get.height * 0.28,
                        width: Get.width * 0.9,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/message.png",
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: CustomText(
                                align: TextAlign.center,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                text: "A reset link has been emailed to you."
                                    "Please also check your spam",
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomButton(
                              text: "Okay",
                              radius: 5,
                              onPressed: () {
                                // controller.dialogTrue.value=false;
                                Get.back();
                              },
                              height: 45,
                              width: 135,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColors.blackLight.withOpacity(0.1),
                                    spreadRadius: 10,
                                    blurRadius: 10,
                                    offset: const Offset(1, 4))
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox())
      ],
    ));
  }
}
