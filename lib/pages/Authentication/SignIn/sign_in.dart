
import 'package:eatwelltracker/connectivity_check.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Authentication/ForgtPassword/forget_password.dart';
import 'package:eatwelltracker/pages/Authentication/SignIn/controller/sign_in_controller.dart';
import 'package:eatwelltracker/pages/Authentication/SignUp/sign_up.dart';
// import 'package:eatwelltracker/pages/Authentication/SignIn/phone_number_sign_in.dart';
import 'package:eatwelltracker/validation/validations.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:eatwelltracker/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../PhoneNumberSignIn.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key, this.fromUser = false}) : super(key: key);

  final bool fromUser;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //freshly added
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40, top: 40),
                  child: Image.asset(widget.fromUser
                      ? "assets/signin.png"
                      : "assets/Mobile login-bro 1.png"),
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
                          text: "Sign in",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                          hint: "Email",
                          controller: controller.email,
                          trim: true,
                          onValidate: (val) => emailValidation(val),
                          preFixWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset("assets/email.png",
                                height: 24, width: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Obx(
                              () => CustomTextField(
                            hint: "Password",
                            obscureText: controller.passHide.value,
                            controller: controller.password,
                            onValidate: (val) => passwordValidation(val),
                            preFixWidget: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Navigate to the phone number sign-in screen or handle the sign-in logic
                        //     Get.to(() => PhoneNumberSignIn(
                        //      // fromUser: fromUser,
                        //     ));
                        //   },
                        //   child: const CustomText(
                        //     text: "Sign in with Phone Number",
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w700,
                        //     color: AppColors.lightGreen,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                      () => GestureDetector(
                                    onTap: () {
                                      controller.isRememberPass.value =
                                      !controller.isRememberPass.value;
                                    },
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(
                                              color: AppColors.lightGreen,
                                              width: 2)),
                                      child: Center(
                                        child: Icon(
                                          Icons.check,
                                          size: 14,
                                          color: controller.isRememberPass.value
                                              ? AppColors.lightGreen
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: CustomText(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    text: "Remember Password",
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ForgetPassword(
                                  fromUser: widget.fromUser,
                                ));
                              },
                              child: const CustomText(
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                text: "Forget Password?",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                          text: "Log in",
                          radius: 20,
                          onPressed: () async {
                            if (controller.formKey.currentState!.validate()) {
                              isInternetAvailable.value =
                              await checkConnectivity();
                              if (isInternetAvailable.value) {
                                controller.logIn();
                              } else {
                                loadingDialog(
                                    message: "Please check your internet connection",
                                    button: true);
                              }
                            }
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1.5,
                                color: Color.fromRGBO(0, 86, 241, 0.4).withOpacity(0.2),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomText(
                                color: AppColors.greyBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                text: "OR",
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1.5,
                                color: Color.fromRGBO(0, 86, 241, 0.4).withOpacity(0.2),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                          text: "Create an Account",
                          radius: 20,
                          onPressed: () {
                            Get.to(() => SignUp(
                              fromUser: widget.fromUser,
                            ));
                          },
                          height: 53,
                          color: Colors.transparent,
                          borderColor: AppColors.lightGreen,
                          textStyle: customTextStyle(
                            color: AppColors.lightGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: "SfProDisplay",
                          ),
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
    );
  }
}
