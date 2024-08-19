import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownWidget extends StatelessWidget {
  DropdownWidget(
      {Key? key,
      required this.list,
      required this.value,
      required this.onchange, this.height, this.textColor, this.decoration, this.borderRadius, this.iconColor, this.iconSize, this.textTileWidth})
      : super(key: key);

  final List<String> list;
  final  onchange;
  final  String value;
  final Color? textColor;
  final Color? iconColor;
  final double? height;
  final double? iconSize;
  final double? borderRadius;
  final BoxDecoration? decoration;
  final double? textTileWidth;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xffF5F5F5),
      elevation: 0,
      borderRadius: BorderRadius.circular(borderRadius??10),
      child: Container(
        padding: EdgeInsets.only(left: 8),
        height: height??null,
        decoration: decoration??BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonFormField<String>(
          dropdownColor: const Color(0xffF5F5F5),
          elevation: 30,


          // padding: EdgeInsets.only(left: 10),
          decoration: InputDecoration(
              alignLabelWithHint: true,
              hintText: "Abc",

              border: InputBorder.none),
          value: value,
          style:  TextStyle(
              overflow: TextOverflow.ellipsis, color: textColor??Colors.black),

          icon:  Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.keyboard_arrow_down,color: iconColor??null,size: iconSize??null,),
          ),
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(
                width: textTileWidth??Get.width*0.7,
                child: Text(
                  value,
                  style: const TextStyle(overflow: TextOverflow.ellipsis,),
                ),
              ),
            );
          }).toList(),
          onChanged: onchange,
        ),
      ),
    );
  }
}
