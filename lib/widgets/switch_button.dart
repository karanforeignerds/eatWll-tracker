import 'package:eatwelltracker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchWidget extends StatelessWidget {
   SwitchWidget({Key? key}) : super(key: key);


  final RxBool isEnabled = false.obs;
  final animationDuration = const Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return
      Obx(() =>
      GestureDetector(
        onTap: (){
          isEnabled.value=!isEnabled.value;
        },
        child: AnimatedContainer(
        height: 24,
        width: 46,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.lightGreen,AppColors.lightGreen]
          ),
          // color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(30),
        ),
        duration: animationDuration,

        child: AnimatedAlign(
          duration: animationDuration,
          alignment:  isEnabled.value ? Alignment.centerRight :     Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
            child: Container(
              width:20,
              height: 30,
              decoration: const BoxDecoration(
                //image: DecorationImage(image: AssetImage("assets/switchCircle.png")),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.lightGreen,darkGreen]
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
    )
    ),
      );
  }
}
