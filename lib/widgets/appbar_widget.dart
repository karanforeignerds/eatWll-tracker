import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Authentication/TypeSelection/join_as.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'loading_widget.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget(
      {Key? key,
      this.title,
      this.backNavigation = false,
      this.centerTitle = false,
      this.profile = true,
      this.scfolldKey,
      this.onPressed,
      this.showLogout = false})
      : super(key: key);

  final String? title;
  final bool backNavigation;
  final bool centerTitle;
  final bool profile;
  final bool showLogout;
  final scfolldKey;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.14,
      width: Get.width,
      decoration: const BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backNavigation
                  ? GestureDetector(
                      onTap: onPressed ?? () => Get.back(),
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: const BoxDecoration(
                            color: darkGreen, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_back_outlined,
                          color: AppColors.white,
                        ),
                      ),
                    )
                  : CustomText(
                      text: title,
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
              centerTitle
                  ? CustomText(
                      text: title,
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )
                  : const SizedBox(),
              profile
                  ? GestureDetector(
                      onTap: () {
                        // scfolldKey.currentState!.openEndDrawer();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset("assets/AppbarProfileIcon.png"),
                      ),
                    )
                  : showLogout
                      ? GestureDetector(
                          onTap: () {
                            loadingDialog(
                                message: 'Are you sure you want to logout?',
                                button: true,
                                log: true,
                                onPressed: () {
                                  auth.signOut();
                                  Get.offAll(() => JoinAs());
                                });
                          },
                          child: Icon(
                            Icons.logout,
                            color: AppColors.white,
                          ),
                        )
                      : const SizedBox(
                          width: 42,
                          height: 60,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
