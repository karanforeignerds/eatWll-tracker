import 'package:eatwelltracker/constants/colors.dart';
import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,this.height,this.width,required this.text,
    this.boxShadow,
    required this.radius,this.color,required this.onPressed,this.textStyle, this.icon, this.borderColor}) : super(key: key);

  final double? height;
  final double? width;
  final String text;
  final TextStyle? textStyle;
  final double radius;
  final Color? color;
  // final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final void Function() onPressed;
  final Widget? icon;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          boxShadow: boxShadow,
      ),
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            elevation: double.infinity,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius),side: BorderSide(color:borderColor??Colors.transparent,width: 2 )),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: color??AppColors.lightGreen,
        ),
        onPressed: onPressed,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: textStyle ?? const TextStyle(
                fontFamily: "SfProDisplay",
                color: AppColors.white,fontSize: 18,fontWeight: FontWeight.w700
              )),
              icon!=null?icon!:Container(width: 0,),
            ],
          ),
        ),
      ),
    );
  }
}
