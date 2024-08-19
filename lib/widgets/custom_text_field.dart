
import 'package:eatwelltracker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hint,
      this.onValidate,
      this.preFixWidget,
      obs,
      this.keyBoardType = TextInputType.text,
      this.obscureText = false,
      this.controller,
      this.onSaved,
      this.maxlines = 1,
      this.enabled,
      this.hintColor = AppColors.greyBlack,
      this.suffixIcon,
      this.hintSize = 18,
      this.cursorColor = AppColors.black,
      this.hintFamily = 'SfProDisplay',
      this.focusColor = Colors.transparent,
      this.textFieldColor = AppColors.white1,
      this.hintWeight = FontWeight.w700,
      this.onTap,
      this.hintStyle = FontStyle.normal,
      this.onChanged,
      this.trim = false,
      this.maxLength, this.label})
      : super(key: key);
  final bool trim;
  final String hint;
  final String? label;
  final int? maxLength;
  final Widget? preFixWidget;
  final Widget? suffixIcon;
  final bool? enabled;
  final int? maxlines;
  final double? hintSize;
  final FontWeight? hintWeight;
  final bool obscureText;
  final Color? hintColor;
  final Color? textFieldColor;
  final Color focusColor;
  final Color cursorColor;
  final String? hintFamily;
  final FontStyle hintStyle;
  final TextInputType keyBoardType;
  final void Function()? onTap;
  final String? Function(String?)? onValidate;
  final TextEditingController? controller;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.none,
      elevation: 0,

      borderRadius: BorderRadius.circular(15),
      shadowColor: AppColors.black.withOpacity(0.4),
      child: TextFormField(


        inputFormatters: trim == true && maxLength != null
            ? [
                FilteringTextInputFormatter.deny(RegExp(r" ")),
                LengthLimitingTextInputFormatter(maxLength)
              ]
            : trim
                ? [
                    FilteringTextInputFormatter.deny(RegExp(r" ")),
                  ]
                : maxLength != null
                    ? [LengthLimitingTextInputFormatter(maxLength)]
                    : null,
        onChanged: onChanged,
        maxLines: maxlines,
        keyboardType: keyBoardType,
        onTap: onTap,
        cursorColor: cursorColor,
        validator: onValidate,
        controller: controller,
        onSaved: onSaved,
        enabled: enabled,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black,fontFamily: "SfProDisplay"),
        decoration: InputDecoration(
          labelText: label,
            labelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "SfProDisplay",
                fontSize: 13,
                color: AppColors.greyBlack
            ),
            errorStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontFamily: "SfProDisplay",
                fontSize: 10,
                color: Colors.redAccent),
            filled: true,
            fillColor: textFieldColor,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            hintText: hint,
            contentPadding: const EdgeInsets.all(16),
            hintStyle: TextStyle(
              fontStyle: hintStyle,
              fontFamily: hintFamily,
              color: hintColor,
              fontWeight: hintWeight,
              fontSize: hintSize,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 10,
                color: Colors.white.withOpacity(0.9),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            prefixIcon: preFixWidget,
            suffixIcon: suffixIcon,
            suffixIconConstraints:
                const BoxConstraints(maxWidth: 150, maxHeight: 150)),
      ),
    );
  }
}
