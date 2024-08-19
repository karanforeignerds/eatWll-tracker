import 'package:eatwelltracker/connectivity_check.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/loading_widget.dart';

class NoInternetService extends StatelessWidget {
  const NoInternetService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "No Internet",color: AppColors.greyBlack),
            SizedBox(height: 12,),
            SizedBox(
              width: Get.width*0.3,
              child: CustomButton(text: "Retry", radius: 10, onPressed: () async {
                loadingDialog(message: "Checking...",loading: true);
                isInternetAvailable.value=await checkConnectivity();
                Get.back();
              }),
            )
          ],
        ),
      ),
    );
  }
}
