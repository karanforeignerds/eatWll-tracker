import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({Key? key, required this.image, required this.title, required this.description}) : super(key: key);

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 68,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.background.withOpacity(0.2),
                offset: const Offset(0, 0.9),
                blurRadius: 4,
                spreadRadius: 3),
          ]),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 4, horizontal: 4),
            width: 80,
            decoration: BoxDecoration(
                color: AppColors.skyBlue,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage("assets/c1.png"),
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                text: title,
              ),
              SizedBox(
                width:Get.width*0.6,
                child: CustomText(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  text: description,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
