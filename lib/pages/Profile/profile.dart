import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Profile/Controller/profile_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/image_picker.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            title: "Profile",
            backNavigation: true,
            profile: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot>(
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

                  controller.name.text = profileSnapshot.data!['name'];
                  controller.email.text = profileSnapshot.data!['email'];
                  // controller.contact.text=profileSnapshot.data!['phoneNo'];
                  controller.selectedDate.value =
                      profileSnapshot.data!['d_o_b'];
                  controller.imageUrl.value = profileSnapshot.data!['image'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        GestureDetector(
                            onTap: () async {
                              controller.image =
                                  await PickImage.pickProfilePicture();
                              controller.imagePath.value =
                                  File(controller.image!.path);
                            },
                            child: Obx(
                              () => Container(
                                height: 82,
                                width: 82,
                                decoration: BoxDecoration(
                                    color: AppColors.skyBlue,
                                    shape: BoxShape.circle,
                                    image: controller
                                            .imagePath.value.path.isEmpty
                                        ? DecorationImage(
                                            image: profileSnapshot
                                                        .data!['image'] !=
                                                    ""
                                                ? NetworkImage(
                                                    profileSnapshot
                                                        .data!['image'],
                                                  )
                                                : AssetImage(
                                                        "assets/profile.png")
                                                    as ImageProvider,
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: FileImage(
                                              File(controller
                                                  .imagePath.value.path),
                                            ),
                                            fit: BoxFit.cover)),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 1, right: 3),
                                      height: 24,
                                      width: 24,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.lightGreen),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.white,
                                        size: 12,
                                      )),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomText(
                          color: AppColors.lightGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          text: profileSnapshot.data!['name'],
                        ),
                        CustomText(
                          color: AppColors.skyBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          text: profileSnapshot.data!['email'],
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        CustomTextField(
                          hint: "Michel Doe",
                          controller: controller.name,
                          preFixWidget: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset("assets/user.png",
                                height: 24, width: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          hint: "xyz@example.com",
                          enabled: false,
                          controller: controller.email,
                          preFixWidget: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image.asset("assets/email.png",
                                height: 24, width: 24),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 16,
                        // ),
                        // CustomTextField(
                        //   hint: "+92-xxxxxxx",
                        //   controller: controller.contact,
                        //   enabled: true,
                        //   preFixWidget: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //     child: Image.asset("assets/smartphone.png",
                        //         height: 20, width: 20),
                        //   ),
                        //   keyBoardType: TextInputType.phone,
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () async {
                            //todo date picker
                            var date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse("1923-01-01"),
                                lastDate: DateTime.now());
                            if (date != null) {
                              controller.selectedDate.value =
                                  DateFormat("dd/MM/yyyy").format(date);
                            }
                          },
                          child: Obx(() => CustomTextField(
                                enabled: false,
                                preFixWidget: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Image.asset("assets/birthday.png",
                                      height: 24, width: 24),
                                ),
                                hint: "birthday",
                                controller: TextEditingController(
                                    text: controller.selectedDate.value != ""
                                        ? controller.selectedDate.value
                                        : null),
                                // label: "Date of Birth",
                              )),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        CustomButton(
                            text: "Save",
                            radius: 15,
                            onPressed: () {
                              controller.saveProfile(
                                  profileReference:
                                      profileSnapshot.data!.reference);
                            },
                            height: 53,
                            width: 178,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.greyBlack.withOpacity(0.1),
                                  offset: const Offset(0, 5),
                                  blurRadius: 4,
                                  spreadRadius: 5)
                            ]),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
