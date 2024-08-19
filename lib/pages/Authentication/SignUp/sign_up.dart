import 'package:eatwelltracker/connectivity_check.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Authentication/SignUp/controller/sign_up_controller.dart';
import 'package:eatwelltracker/pages/Terms/terms.dart';
import 'package:eatwelltracker/validation/validations.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key, this.fromUser = false}) : super(key: key);

  final bool fromUser;
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 30),
              child: Image.asset(
                fromUser ? "assets/signUp.png" : "assets/Sign up-bro 1.png",
                height: 250,
                width: 250,
              ),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24),
                  child: Column(
                    children: [
                      const CustomText(
                        text: "Sign up",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      fromUser
                          ? SizedBox()
                          : CustomTextField(
                              hint: "Business / Practice name",
                              controller: controller.businessName,
                              onValidate: (val) => fieldValidation(val),
                              preFixWidget: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Image.asset("assets/person.png",
                                    height: 24, width: 24),
                              ),
                            ),
                      SizedBox(
                        height: !fromUser ? 10 : 0,
                      ),
                      CustomTextField(
                        hint: "User Name",
                        trim: true,
                        controller: controller.userName,
                        onValidate: (val) => fieldValidation(val),
                        preFixWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.asset("assets/person.png",
                              height: 24, width: 24),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      CustomTextField(
                        hint: "Email",
                        trim: true,
                        controller: controller.email,
                        onValidate: (val) => emailValidation(val),
                        preFixWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.asset("assets/email.png",
                              height: 24, width: 24),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      //
                      // CustomTextField(
                      //   hint: "Phone number",
                      //   controller: controller.phone,
                      //   onValidate: (val)=>phoneValidation(val),
                      //   preFixWidget: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //     child: Image.asset("assets/smartphone2.png",
                      //         height: 20, width: 20),
                      //   ),
                      //   keyBoardType: TextInputType.phone,
                      // ),

                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CustomTextField(
                      //   hint: "Address",
                      //   controller: controller.address,
                      //   onValidate: (val)=>addressValidation(val),
                      //   preFixWidget: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //     child: Image.asset("assets/placeholder.png",
                      //         height: 24, width: 24),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CustomTextField(
                          hint: /*fromUser?"**********":*/ "Password",
                          obscureText: controller.passHide.value,
                          controller: controller.password,
                          onValidate: (val) => passwordValidation(val),
                          preFixWidget: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset(
                              "assets/lock 1.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          suffixIcon: SizedBox(
                            height: 50,
                            width: 50,
                            child: GestureDetector(
                                onTap: () {
                                  controller.passHide.value =
                                      !controller.passHide.value;
                                },
                                child: Obx(
                                  () => Icon(
                                    controller.passHide.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.greyBlack,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => CustomTextField(
                          hint: /* "**********"*/ "Password",
                          obscureText: controller.conPassHide.value,
                          controller: controller.confirmPassword,
                          onValidate: (val) => confirmPasswordValidation(
                              val, controller.password.text),
                          preFixWidget: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset(
                              "assets/lock 1.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          suffixIcon: SizedBox(
                            height: 50,
                            width: 50,
                            child: GestureDetector(
                                onTap: () {
                                  controller.conPassHide.value =
                                      !controller.conPassHide.value;
                                },
                                child: Obx(
                                  () => Icon(
                                    controller.conPassHide.value
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.greyBlack,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: fromUser ? 10 : 0,
                      ),
                      fromUser
                          ? CustomTextField(
                              hint: "Referral Code (Optional)",
                              controller: controller.referralCode,
                              keyBoardType: TextInputType.number,
                              preFixWidget: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Image.asset("assets/referral2.png",
                                    height: 24, width: 24),
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 24,
                      ),

                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.terms.value =
                                    !controller.terms.value;
                                controller.termsError.value = false;
                              },
                              child: Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: AppColors.lightGreen, width: 2)),
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    size: 14,
                                    color: controller.terms.value
                                        ? AppColors.lightGreen
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // Terms of use & Privacy Policy
                          RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: "SfProDisplay"),
                                  children: [
                                TextSpan(
                                  text: "Accept ",
                                  style: TextStyle(
                                    color: AppColors.greyBlack,
                                  ),
                                ),
                                TextSpan(
                                    text: "Terms of use ",
                                    style: TextStyle(
                                      color: AppColors.lightGreen,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => TermsOfServices());
                                      }),
                                TextSpan(
                                    text: "& ",
                                    style: TextStyle(
                                      color: AppColors.greyBlack,
                                    )),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      color: AppColors.lightGreen,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => TermsOfServices());
                                      }),
                              ])),
                        ],
                      ),
                      Obx(() => controller.termsError.value
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16.0, left: 16),
                                child: CustomText(
                                  text: "Accept terms & condition",
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            )
                          : SizedBox()),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: "Sign up",
                        radius: 20,
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            isInternetAvailable.value =
                                await checkConnectivity();
                            if (isInternetAvailable.value) {
                              controller.register(
                                  type: fromUser ? "User" : "Nutrition");
                            } else {
                              loadingDialog(
                                  message:
                                      "Please check your internet connection",
                                  button: true);
                            }
                          }
                        },
                        height: 53,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blackLight.withOpacity(0.1),
                              spreadRadius: 6,
                              blurRadius: 10,
                              offset: const Offset(1, 8))
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            color: AppColors.black,
                            text: "Already have an account? ",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const CustomText(
                                color: AppColors.lightGreen,
                                text: "Sign In",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
