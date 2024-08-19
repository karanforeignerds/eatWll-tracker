import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';


class ExpansionTileWidget extends StatelessWidget {
  ExpansionTileWidget(
      {Key? key,
      required this.tileText,
      required this.widget,
      this.middleText = "", required this.isExpanded})
      : super(key: key);

  final String tileText;
  final Widget widget;
  final String? middleText;
  final bool isExpanded;
  // var arrow = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 4,
                spreadRadius: 3,
                offset: Offset(1, 4))
          ], color: AppColors.white2, borderRadius: BorderRadius.circular(10)),
          child: ExpansionTile(
            key: GlobalKey(),
            initiallyExpanded: isExpanded,
            textColor: AppColors.greyBlack,
            iconColor: AppColors.lightGreen,
            onExpansionChanged: (bool? val) {

              //val == true ? arrow.value = true : arrow.value = false;

            },

            title:
            CustomText(color: AppColors.lightGreen,text: tileText,fontWeight: FontWeight.w700,fontSize: 15,),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(color: AppColors.lightGreen,text: middleText!,fontWeight: FontWeight.w700,fontSize: 14,),
                  const SizedBox(
                    width: 30,
                  ),
                  isExpanded == false
                      ? const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: AppColors.lightGreen,
                        )
                      : const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.lightGreen,
                          size: 30,
                        ),
                ],
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            children: [widget],
          ),
        );
  }
}
