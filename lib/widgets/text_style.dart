import 'package:flutter/material.dart';


customTextStyle({
  final String? fontFamily,
  final Color? color,
  final double? fontSize,
  final FontWeight? fontWeight,
  final bool underLine=false,
}) {
    return TextStyle(
        decoration: underLine ? TextDecoration.underline : null,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? "SfProDisplay"

    );
}