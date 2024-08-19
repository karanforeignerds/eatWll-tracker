// import 'package:eatwelltracker/constants/colors.dart';
// import 'package:eatwelltracker/pages/Authentication/SignIn/sign_in.dart';
// import 'package:eatwelltracker/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class Splash2 extends StatelessWidget {
//   const Splash2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//             height: Get.height * 0.7,
//             width: Get.width,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(image: AssetImage("assets/style.png"))),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     child: Image.asset("assets/apple.png")),
//                 Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     child: SizedBox(
//                         height: Get.height*0.6,
//                         child: Image.asset("assets/fruitMan.png"))),
//                 Positioned(
//                     bottom: 0,
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 90.0),
//                         child: Container(
//                           height: 45,
//                           decoration: BoxDecoration(
//                               color: AppColors.greyWhite,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 8.0, horizontal: 16),
//                             child: CustomText(
//                               color: AppColors.darkBlue,
//                               fontSize: 24,
//                               text: "The first wealth is health",
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ))),
//               ],
//             )
//         ),
//
//         const CustomText(
//           color: AppColors.darkBlue,
//           fontSize: 14,
//           text:
//               "Lörem ipsum nölingar skämsfilter telig, de trengen favis beren. Miskapet sengen prespen, latingen intrat."
//               "Jiligt fusm om gigasamma. Nir bed och dose kosyd vinde hypernetik."
//               "Minade polydade tinaligt än fafuvis. Digitalbox faling dise. ",
//           fontWeight: FontWeight.w500,
//           align: TextAlign.center,
//         ),
//         SizedBox(
//           height: Get.height * 0.05,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 8,
//               width: 8,
//               decoration: const BoxDecoration(
//                   shape: BoxShape.circle, color: AppColors.skyBlue),
//             ),
//             const SizedBox(
//               width: 4,
//             ),
//             Container(
//               height: 8,
//               width: 24,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   // shape: BoxShape.circle,
//                   color: AppColors.darkBlue),
//             ),
//           ],
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               GestureDetector(
//                 onTap: (){Get.offAll(()=> SignIn());},
//                 child: Container(
//                   height: 95,
//                   width: Get.width,
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage("assets/btnShape.png"),
//                           fit: BoxFit.cover)),
//                   child: const Icon(
//                     Icons.arrow_forward,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ));
//   }
// }
