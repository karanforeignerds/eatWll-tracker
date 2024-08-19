import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppBarWidget(
          centerTitle: true,
          title: "About",
          backNavigation: true,
          profile: true,
        ),
        SizedBox(
          height: 24,
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Documents").doc('aboutUs').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(!snapshot.data!.exists){
                return noDataExit();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "About Us",
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.greyBlack,
                      ),
                      SizedBox(height: 16),
                      ///SCOPE OF TERMS & CONDITIONS===================
                      CustomText(
                        align: TextAlign.justify,
                        text: snapshot.data!['data'],
                        color: AppColors.greyBlack,

                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
  noDataExit(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "About Us",
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.greyBlack,
              ),
              SizedBox(height: 16),
              CustomText(
                align: TextAlign.justify,
                text:
                "Take the headache out of diet tracking by using a flexible, intuitive way to manage your food intake",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.greyBlack,
              ),
              SizedBox(height: 16),
              CustomText(
                align: TextAlign.justify,
                text:
                "Eat Well Tracker is designed to keep you on track with your nutritional goals without overwhelming you with details. Whether you're using our goals or setting your own or those of your health advisor, the app allows you to easily record what you're eating and track your daily progress.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.greyBlack,
                //  Forget about complicated point systems, calorie counting or time-consuming food lookups—our ultimate aim is to help you EAT WELL in the most simple and straightforward way possible.
              ),
              SizedBox(height: 16),
              CustomText(
                align: TextAlign.justify,
                text:
                "Forget about complicated point systems, calorie counting or time-consuming food lookups—our ultimate aim is to help you EAT WELL in the most simple and straightforward way possible.",
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.greyBlack,
              ),
            ]),
      ),
    );
  }
}
