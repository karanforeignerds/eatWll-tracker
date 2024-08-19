import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'switch_button.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              spreadRadius: 10,
              offset: Offset(-2, 4),
              blurRadius: 10,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Card Details :",
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.greyBlack,
                  align: TextAlign.left,
                )),
            const SizedBox(
              height: 24,
            ),
            const CustomTextField(
              hint: "5241  6248  1100  007",
              label: "Card number",
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hint: "********",
              label: "Password",
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: Get.width * 0.43,
                    child: const CustomTextField(
                      hint: "****",
                      label: "CVV",
                    )),
                SizedBox(
                    width: Get.width * 0.43,
                    child: const CustomTextField(
                      hint: "DD/MM/YYYY",
                      label: "Expiry date",
                    )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const CustomTextField(
              hint: "Optional",
              label: "Email",
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  color: AppColors.lightGreen,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  text: "Save Card data for future payments",
                  underLine: true,
                ),
                SwitchWidget(),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              text: "Pay now",
              radius: 15,
              onPressed: () {},
              height: 53,
              width: 172,
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
