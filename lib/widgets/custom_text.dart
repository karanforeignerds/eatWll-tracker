
import 'package:eatwelltracker/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
        this.text,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.align, this.underLine=false, this.fontFamily, this.overflow,  this.maxLine})
      : super(key: key);

  final String? text;
  final String? fontFamily;
  final TextAlign? align;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool underLine;
  final TextOverflow? overflow;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: align,
      maxLines: maxLine,
      style: TextStyle(
          decoration: underLine?TextDecoration.underline:null,
          color: color??AppColors.black,
          overflow: overflow,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily??"SfProDisplay"),
    );
  }
}