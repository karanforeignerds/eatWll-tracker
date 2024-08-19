import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class SetGoalWidget extends StatelessWidget {
  const SetGoalWidget({Key? key,this.onDecrementPressed,this.onIncrementPressed,this.count,this.name}) : super(key: key);

  final Function()? onIncrementPressed;
  final Function()? onDecrementPressed;
  final int? count;
  final String? name;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(fontSize: 15,fontWeight: FontWeight.w700,text: name,color: AppColors.black,),
          Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: onDecrementPressed,
                      child: const Icon(Icons.remove,color: AppColors.lightGreen,)),
                  const SizedBox(width: 8,),
                  CustomText(fontSize: 14,fontWeight: FontWeight.w700,text: count.toString(),color: AppColors.greyBlack,),
                  const SizedBox(width: 8,),
                  GestureDetector(
                      onTap: onIncrementPressed,
                      child: const Icon(Icons.add,color: AppColors.lightGreen,)),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
