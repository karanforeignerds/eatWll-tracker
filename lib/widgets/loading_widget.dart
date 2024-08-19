import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

loadingDialog({
  String? message,
  bool loading = false,
  bool button = false,
  bool log = false,
  void Function()? onPressed,
}) {
  showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.white,
        elevation: 1,
        actions: [
          Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      loading
                          ? CircularProgressIndicator(
                              color: AppColors.lightGreen,
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      message != null
                          ? SizedBox(
                            width: Get.width*0.6,
                            child: CustomText(
                              text: message,
                              align: TextAlign.center,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          log
                              ? CustomButton(
                                  radius: 10,
                                  text: "Yes",
                                  width: 100,
                                  height: 40,
                                  onPressed: onPressed ?? () {},
                                )
                              : const SizedBox(),
                          const SizedBox(width: 20),
                          button
                              ? CustomButton(
                                  radius: 10,
                                  text: log ? "No" : "Okay",
                                  width: 100,
                                  height: 40,
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ],
              ))
        ],
      );
    },
  );
}
