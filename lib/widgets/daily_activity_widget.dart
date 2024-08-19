import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DailyActivityWidget extends StatelessWidget {
  const DailyActivityWidget(
      {Key? key,
      required this.title,
      required this.completeValue,
      required this.isIntakePage})
      : super(key: key);

  final String title;
  final double completeValue;
  final bool isIntakePage;

  @override
  Widget build(BuildContext context) {
    print(completeValue.toString()+title.toString());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 6,
                offset: Offset(-1, 3),
                spreadRadius: 5),
          ]),

      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 3000,
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: completeValue<=100.01 || completeValue.toStringAsFixed(1)=="NaN" || completeValue.toString()=="Infinity"?100.01:completeValue,
                    ranges: completeValue<=100.01?<GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: completeValue <= 45 ? completeValue : 45,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 45,
                          endValue: completeValue <= 75 ? completeValue : 75,
                          color: completeValue <= 45
                              ? AppColors.greyWhite
                              : Colors.yellow,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 75,
                          endValue:
                              completeValue <= 100 ? completeValue : 100,
                          color: completeValue <= 75
                              ? AppColors.greyWhite
                              : Colors.green,
                          startWidth: 10,
                          endWidth: 10),

                    ]:<GaugeRange>[
                      GaugeRange(
                          startValue: 0,
                          endValue: completeValue <= 45 ? completeValue : 45,
                          color: Colors.red,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 45,
                          endValue: completeValue <= 75 ? completeValue : 75,
                          color: completeValue <= 45
                              ? AppColors.greyWhite
                              : Colors.yellow,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 75,
                          endValue:
                          completeValue <= 100 ? completeValue : 100,
                          color: completeValue <= 75
                              ? AppColors.greyWhite
                              : Colors.green,
                          startWidth: 10,
                          endWidth: 10),
                      GaugeRange(
                          startValue: 100,
                          endValue:completeValue,
                          color: Colors.orange,
                          startWidth: 10,
                          endWidth: 10),

                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: completeValue,
                        needleColor: AppColors.lightGreen,
                        knobStyle: const KnobStyle(color: AppColors.lightGreen),
                      ),
                    ],
                  )
                ]),
          ),
          CustomText(
              color: AppColors.greyBlack,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              text: title
              ),
          isIntakePage
              ? Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/checkmark.png",
                          width: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomText(
                          color: AppColors.lightGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          text:
                          completeValue.toStringAsFixed(1)=="NaN"?'Your intake is 100% of ${title}':"Your intake is ${completeValue.toStringAsFixed(1)}% of ${title}",
                        ),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
