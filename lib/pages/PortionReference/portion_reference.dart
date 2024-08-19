import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/PortionReference/Controller/portion_referenceController.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortionReference extends StatelessWidget {
  PortionReference({super.key});

  final controller =Get.put(PortionReferenceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            backNavigation: true,
            title: "Portion reference",
            profile: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:24 ),
            child: Column(
              children: [

                Container(
                  decoration: BoxDecoration(color:AppColors.white3,borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),topRight: Radius.circular(15)
                  ),
                      boxShadow: [
                        BoxShadow(color: AppColors.shadowColor,spreadRadius: 1,blurRadius: 10,offset: Offset(0, 5))
                      ]
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.portionData.length+1,
                      itemBuilder: (_,int index){

                    return index==0?Container(
                      padding: EdgeInsets.symmetric(vertical: 21,horizontal: 8),
                      decoration: BoxDecoration(color:AppColors.white,borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),topRight: Radius.circular(15)
                      ),
                          boxShadow: [
                            BoxShadow(color: AppColors.shadowColor.withOpacity(0.05),spreadRadius: 1,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(text: "Symbol",fontWeight: FontWeight.w500,fontSize: 16,))),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(text: "Comparison",fontWeight: FontWeight.w500,fontSize: 16,))),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(text: "Serving Size",fontWeight: FontWeight.w500,fontSize: 16,))),
                        ],
                      ),
                    ):Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(controller.portionData[index-1].symbolImage,height: 60,width: index==1?60:80,))),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(text: controller.portionData[index-1].comparison,fontWeight: FontWeight.w500,fontSize: 16,))),
                          Expanded(
                              flex: 1,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CustomText(text: controller.portionData[index-1].servingSize,fontWeight: FontWeight.w500,fontSize: 16,))),
                        ],
                      ),
                    );

                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
