import 'package:flutter/material.dart';

class LogFoodWidget extends StatelessWidget {
  const LogFoodWidget({Key? key, required this.image, required this.title, this.onTap})
      : super(key: key);

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        color: Colors.white,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 200,
          width: 175,
          padding: EdgeInsets.symmetric(vertical: 28),
          child: Column(
            children: [
              Image.asset(
                image,
                height: 80,
                width: 80,
              ),
              Expanded(child: SizedBox()),
              Text(
                title,
                style: TextStyle(
                    fontFamily: "SfProDisplay",
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
