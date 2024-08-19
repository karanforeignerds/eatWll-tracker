import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogFoodController extends GetxController{

  RxString selectedValue="Breakfast".obs;


  Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

}