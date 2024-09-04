//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:eatwelltracker/constants/colors.dart';
// import 'package:eatwelltracker/widgets/button.dart';
// import 'package:eatwelltracker/widgets/custom_text.dart';
// import 'package:eatwelltracker/widgets/custom_text_field.dart';
// import 'package:eatwelltracker/widgets/text_style.dart';
// import 'package:eatwelltracker/pages/CheckUserType/check_user_type.dart';
// import 'otppage.dart'; // Import the OTP page
//
// class PhoneNumberSignIn extends StatelessWidget {
//   final bool fromUser;
//
//   PhoneNumberSignIn({Key? key, this.fromUser = false}) : super(key: key);
//
//   final TextEditingController phoneNumberController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   void sendCode() async {
//     try {
//       final phoneNumber = phoneNumberController.text;
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) {
//           // Auto verification is not handled in this example
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           Get.snackbar('Error Occurred', e.message ?? 'Verification failed');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Get.to(() => OtpVerificationScreen(vid: verificationId));
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Timeout logic if needed
//         },
//       );
//     } on FirebaseAuthException catch (e) {
//       Get.snackbar('Error Occurred', e.message ?? 'Error occurred');
//     } catch (e) {
//       Get.snackbar('Error Occurred', e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: formKey,
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 40.0, right: 40, top: 80),
//                   child: Image.asset(
//                     fromUser
//                         ? "assets/generate_code.png"
//                         : "assets/generate_code.png",
//                   ),
//                 ),
//                 Positioned(
//                   left: 16,
//                   top: 36,
//                   child: GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Icon(Icons.arrow_back),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(60),
//                     topLeft: Radius.circular(60),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.skyBlue.withOpacity(0.1),
//                       blurRadius: 10,
//                       spreadRadius: 6,
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 40),
//                         const CustomText(
//                           text: "Sign in with Phone",
//                           fontSize: 24,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.black,
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextField(
//                           hint: "Enter your phone number",
//                           controller: phoneNumberController,
//                           trim: true,
//                           onValidate: (val) => phoneNumberValidation(val),
//                           preFixWidget: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16.0),
//                             child: Icon(
//                                 Icons.phone, color: AppColors.lightGreen),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         CustomButton(
//                           text: "Get OTP",
//                           radius: 20,
//                           onPressed: () {
//                             if (formKey.currentState!.validate()) {
//                               sendCode();
//                             }
//                           },
//                           height: 53,
//                           color: AppColors.lightGreen,
//                           textStyle: customTextStyle(
//                             color: AppColors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                             fontFamily: "SfProDisplay",
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 height: 1.5,
//                                 color: Color.fromRGBO(0, 86, 241, 0.4)
//                                     .withOpacity(0.2),
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 8.0),
//                               child: CustomText(
//                                 color: AppColors.greyBlack,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 14,
//                                 text: "OR",
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height: 1.5,
//                                 color: Color.fromRGBO(0, 86, 241, 0.4)
//                                     .withOpacity(0.2),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 24),
//                         CustomButton(
//                           text: "Back to Sign In",
//                           radius: 20,
//                           onPressed: () {
//                             Get.back();
//                           },
//                           height: 53,
//                           color: Colors.transparent,
//                           borderColor: AppColors.lightGreen,
//                           textStyle: customTextStyle(
//                             color: AppColors.lightGreen,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                             fontFamily: "SfProDisplay",
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String? phoneNumberValidation(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number cannot be empty';
//     }
//     // Regex for international phone numbers
//     final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
//     if (!phoneRegex.hasMatch(value)) {
//       return 'Enter a valid phone number';
//     }
//     return null;
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:eatwelltracker/constants/colors.dart';
// // import 'package:eatwelltracker/widgets/button.dart';
// // import 'package:eatwelltracker/widgets/custom_text.dart';
// // import 'package:eatwelltracker/widgets/custom_text_field.dart';
// // import 'package:eatwelltracker/widgets/text_style.dart';
// // import 'package:eatwelltracker/pages/CheckUserType/check_user_type.dart';
// // import 'otppage.dart'; // Import the OTP page
// //
// // class PhoneNumberSignIn extends StatelessWidget {
// //   final bool fromUser;
// //
// //   PhoneNumberSignIn({Key? key, this.fromUser = false}) : super(key: key);
// //
// //   final TextEditingController phoneNumberController = TextEditingController();
// //   final TextEditingController nameController = TextEditingController(); // New controller for name
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //
// //   void sendCode() async {
// //     try {
// //       final phoneNumber = phoneNumberController.text;
// //       final name = nameController.text; // Get the name from the controller
// //       await FirebaseAuth.instance.verifyPhoneNumber(
// //         phoneNumber: phoneNumber,
// //         verificationCompleted: (PhoneAuthCredential credential) {
// //           // Auto verification is not handled in this example
// //         },
// //         verificationFailed: (FirebaseAuthException e) {
// //           Get.snackbar('Error Occurred', e.message ?? 'Verification failed');
// //         },
// //         codeSent: (String verificationId, int? resendToken) {
// //           // Pass the name and phone number to the OTP screen if needed
// //           Get.to(() => OtpVerificationScreen(vid: verificationId, name: name));
// //         },
// //         codeAutoRetrievalTimeout: (String verificationId) {
// //           // Timeout logic if needed
// //         },
// //       );
// //     } on FirebaseAuthException catch (e) {
// //       Get.snackbar('Error Occurred', e.message ?? 'Error occurred');
// //     } catch (e) {
// //       Get.snackbar('Error Occurred', e.toString());
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Form(
// //         key: formKey,
// //         child: Column(
// //           children: [
// //             Stack(
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.only(left: 40.0, right: 40, top: 80),
// //                   child: Image.asset(
// //                     fromUser
// //                         ? "assets/generate_code.png"
// //                         : "assets/generate_code.png",
// //                   ),
// //                 ),
// //                 Positioned(
// //                   left: 16,
// //                   top: 36,
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       Get.back();
// //                     },
// //                     child: Icon(Icons.arrow_back),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Expanded(
// //               child: Container(
// //                 width: Get.width,
// //                 decoration: BoxDecoration(
// //                   color: AppColors.white,
// //                   borderRadius: const BorderRadius.only(
// //                     topRight: Radius.circular(60),
// //                     topLeft: Radius.circular(60),
// //                   ),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: AppColors.skyBlue.withOpacity(0.1),
// //                       blurRadius: 10,
// //                       spreadRadius: 6,
// //                     ),
// //                   ],
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                   child: SingleChildScrollView(
// //                     child: Column(
// //                       children: [
// //                         const SizedBox(height: 40),
// //                         const CustomText(
// //                           text: "Sign in with Phone",
// //                           fontSize: 24,
// //                           fontWeight: FontWeight.w700,
// //                           color: AppColors.black,
// //                         ),
// //                         const SizedBox(height: 16),
// //                         CustomTextField(
// //                           hint: "Enter your name", // Field for name
// //                           controller: nameController,
// //                           trim: true,
// //                           onValidate: (val) {
// //                             if (val == null || val.isEmpty) {
// //                               return 'Name cannot be empty';
// //                             }
// //                             return null;
// //                           },
// //                           preFixWidget: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                             child: Icon(Icons.person, color: AppColors.lightGreen),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 16),
// //                         CustomTextField(
// //                           hint: "Enter your phone number",
// //                           controller: phoneNumberController,
// //                           trim: true,
// //                           onValidate: (val) => phoneNumberValidation(val),
// //                           preFixWidget: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                             child: Icon(Icons.phone, color: AppColors.lightGreen),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 24),
// //                         CustomButton(
// //                           text: "Get OTP",
// //                           radius: 20,
// //                           onPressed: () {
// //                             if (formKey.currentState!.validate()) {
// //                               sendCode();
// //                             }
// //                           },
// //                           height: 53,
// //                           color: AppColors.lightGreen,
// //                           textStyle: customTextStyle(
// //                             color: AppColors.white,
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 18,
// //                             fontFamily: "SfProDisplay",
// //                           ),
// //                         ),
// //                         const SizedBox(height: 24),
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             Expanded(
// //                               child: Container(
// //                                 height: 1.5,
// //                                 color: Color.fromRGBO(0, 86, 241, 0.4).withOpacity(0.2),
// //                               ),
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.symmetric(horizontal: 8.0),
// //                               child: CustomText(
// //                                 color: AppColors.greyBlack,
// //                                 fontWeight: FontWeight.w700,
// //                                 fontSize: 14,
// //                                 text: "OR",
// //                               ),
// //                             ),
// //                             Expanded(
// //                               child: Container(
// //                                 height: 1.5,
// //                                 color: Color.fromRGBO(0, 86, 241, 0.4).withOpacity(0.2),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 24),
// //                         CustomButton(
// //                           text: "Back to Sign In",
// //                           radius: 20,
// //                           onPressed: () {
// //                             Get.back();
// //                           },
// //                           height: 53,
// //                           color: Colors.transparent,
// //                           borderColor: AppColors.lightGreen,
// //                           textStyle: customTextStyle(
// //                             color: AppColors.lightGreen,
// //                             fontWeight: FontWeight.w700,
// //                             fontSize: 18,
// //                             fontFamily: "SfProDisplay",
// //                           ),
// //                         ),
// //                         const SizedBox(height: 24),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   String? phoneNumberValidation(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Phone number cannot be empty';
// //     }
// //     // Regex for international phone numbers
// //     final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
// //     if (!phoneRegex.hasMatch(value)) {
// //       return 'Enter a valid phone number';
// //     }
// //     return null;
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/text_style.dart';
import 'otppage.dart'; // Import the OTP page

class PhoneNumberSignIn extends StatelessWidget {
  final bool fromUser;

  PhoneNumberSignIn({Key? key, this.fromUser = false}) : super(key: key);

  final TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void sendCode() async {
    try {
      final phoneNumber = phoneNumberController.text.trim();

      if (phoneNumber.isEmpty) {
        Get.snackbar('Error Occurred', 'Phone number cannot be empty');
        return;
      }

      // Firebase phone number verification with automatic background CAPTCHA handling
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback is triggered when the verification is completed automatically
          // You can sign the user in directly with the provided credential
          FirebaseAuth.instance.signInWithCredential(credential).then((UserCredential result) {
            Get.snackbar('Success', 'Phone number verified and user signed in');
            //Get.to(() => OtpVerificationScreen(vid: verificationId, phoneNumber: phoneNumber));
            // Navigate to the desired screen after successful sign-in
          }).catchError((e) {
            Get.snackbar('Error', e.toString());
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error Occurred', e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP verification screen and pass the verification ID
          Get.to(() => OtpVerificationScreen(vid: verificationId, phoneNumber: phoneNumber));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout if needed
        },
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error Occurred', e.message ?? 'Error occurred');
    } catch (e) {
      Get.snackbar('Error Occurred', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40, top: 80),
                  child: Image.asset("assets/generate_code.png"),
                ),
                Positioned(
                  left: 16,
                  top: 36,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(60),
                    topLeft: Radius.circular(60),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.skyBlue.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        const CustomText(
                          text: "Sign in with Phone",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Please enter your phone number with the country code (e.g., +1 for the USA).",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: "Enter your phone number",
                          controller: phoneNumberController,
                          trim: true,
                          onValidate: (val) => phoneNumberValidation(val),
                          preFixWidget: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(Icons.phone, color: AppColors.lightGreen),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: "Get OTP",
                          radius: 20,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              sendCode();
                            }
                          },
                          height: 53,
                          color: AppColors.lightGreen,
                          textStyle: customTextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: "SfProDisplay",
                          ),
                        ),
                        const SizedBox(height: 24),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: "Back to Sign In",
                          radius: 20,
                          onPressed: () {
                            Get.back();
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
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    // Regex for international phone numbers
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
