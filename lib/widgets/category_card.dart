import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/Model/category_card_model.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key? key, this.data}) : super(key: key);

  final CategoryCardModel? data;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: AppColors.white2,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: AppColors.greyBlack.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 5,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                  color: AppColors.skyBlue,
                  image: DecorationImage(
                      image: AssetImage(data!.image!), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              text: data!.title,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomText(
              color: AppColors.greyBlack,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text: data!.description,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomText(
                  text: "Category",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.skyBlue,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.skyBlue,
                  size: 18,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
