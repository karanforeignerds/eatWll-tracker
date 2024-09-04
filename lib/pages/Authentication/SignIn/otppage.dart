// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../Home/home.dart';
//
// class OtpVerificationScreen extends StatelessWidget {
//   final String verificationId;
//   final TextEditingController otpController = TextEditingController();
//
//   OtpVerificationScreen({required this.verificationId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Verify OTP"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image widget added here
//             Image.asset(
//               'assets/generate_code.png', // Replace with your image asset path
//               width: 100, // Adjust width as needed
//               height: 100, // Adjust height as needed
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 24),
//             TextField(
//               controller: otpController,
//               decoration: InputDecoration(
//                 labelText: "Enter OTP",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () async {
//                 if (otpController.text
//                     .trim()
//                     .isEmpty) {
//                   Get.snackbar("Error", "Please enter the OTP");
//                   return;
//                 }
//
//                 try {
//                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: verificationId,
//                     smsCode: otpController.text.trim(),
//                   );
//
//                   await FirebaseAuth.instance.signInWithCredential(credential);
//                   Get.offAll(() => Home());
//                 } catch (e) {
//                   Get.snackbar(
//                       "Error", "Invalid OTP or other error: ${e.toString()}");
//                 }
//               },
//               child: Text("Verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:eatwelltracker/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';

import '../DashBoard/dashboard.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String vid; // Verification ID from Firebase Auth
  var phoneNumber = TextEditingController(); // User's phone number

  OtpVerificationScreen({super.key, required this.vid, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  var code = '';

  signin() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,
      smsCode: code,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        // Get.offAll(DashboardScreen(userData: userInfo));
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error occurred', e.code);
    } catch (e) {
      Get.snackbar('Error occurred', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset('assets/generate_code.png', height: 300, width: 250),
            Center(
              child: Text(
                "OTP Verification",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Enter OTP sent to your phone number",
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.phoneNumber as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            textcode(),
            SizedBox(height: 60),
            button(),
          ],
        ),
      ),
    );
  }

  Widget button() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (code.length == 6) {
            signin();
          } else {
            Get.snackbar('Error', 'Please enter a valid OTP');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(140, 178, 241, 1),
          padding: EdgeInsets.all(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            'Verify',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textcode() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Pinput(
          length: 6,
          onChanged: (value) {
            setState(() {
              code = value;
            });
          },
        ),
      ),
    );
  }
}
