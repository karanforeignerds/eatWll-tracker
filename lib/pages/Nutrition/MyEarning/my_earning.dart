import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Nutrition/MyEarning/Controller/my_earning_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyEarnings extends StatelessWidget {
   MyEarnings({super.key});

  final controller =Get.put(MyEarningController());
  final List<ChartData> chartData = [
     ChartData("Week01", 10),
     ChartData("Week02", 55),
     ChartData("Week03", 115),
     ChartData("Week04", 100),
     ChartData("Week05", 90),
     ChartData("Week06", 100),
     // ChartData("Sunday", 22),
   ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream:  FirebaseFirestore.instance.collection("SubscriptionsDetail").snapshots(),
        builder: (_,subscriptionSnapshot){
          if(subscriptionSnapshot.connectionState==ConnectionState.waiting){
            return Center( child: CircularProgressIndicator());
          }
          var totalSales=0.00;
          var amountFromAllContributors=0.00;

          if(subscriptionSnapshot.data!.docs.isNotEmpty){
            for(int i=0;i<subscriptionSnapshot.data!.docs.length;i++){

              var data=subscriptionSnapshot.data!.docs[i];
              if(data['nutritionistId']==auth.currentUser!.uid){
                totalSales=totalSales+double.parse(data['price'].toString());
                amountFromAllContributors=amountFromAllContributors+double.parse(data['price'].toString());
              }else{
                amountFromAllContributors=amountFromAllContributors+double.parse(data['price'].toString());
              }
            }
          }


          return Column(
            children: [
              AppBarWidget(
                  backNavigation: true,
                  profile: true,
                  centerTitle: true,
                  title: "Charitable Contribution"),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 24,),
                      // SizedBox(
                      //   height: Get.height*0.25,
                      //   width: Get.width,
                      //   child: SfCartesianChart(
                      //       primaryXAxis: CategoryAxis(
                      //           isVisible: true,
                      //           majorGridLines:
                      //           MajorGridLines(color: Colors.grey,dashArray: [5],),
                      //           rangePadding: ChartRangePadding.none,
                      //           labelStyle:
                      //           const TextStyle(color: AppColors.black,fontFamily: "SfProDisplay",fontSize: 10,) ),
                      //       ///
                      //       primaryYAxis: CategoryAxis(
                      //
                      //           isVisible: true,
                      //           majorGridLines:
                      //           MajorGridLines(color: Colors.grey,dashArray: [5]),
                      //           rangePadding: ChartRangePadding.none,labelStyle:
                      //       const TextStyle(color: AppColors.black,fontFamily: "SfProDisplay",fontSize: 12)),
                      //
                      //
                      //       plotAreaBorderColor: Colors.transparent,
                      //       plotAreaBorderWidth: 0,
                      //       palette:  [
                      //         AppColors.lightGreen.withOpacity(0.3),
                      //       ],
                      //
                      //
                      //       tooltipBehavior: TooltipBehavior(enable: false),
                      //       series: <ChartSeries>[
                      //         StackedAreaSeries<ChartData, String>(
                      //
                      //             borderColor: AppColors.lightGreen,
                      //             borderWidth: 1,
                      //
                      //             markerSettings: MarkerSettings(isVisible: true),
                      //             dataSource: chartData,
                      //             xValueMapper: (ChartData data, _) => data.x,
                      //             yValueMapper: (ChartData data, _) => data.y),
                      //       ]),
                      // ),
                      Center(
                        child: Text("10% of ALL Eat Well Tracker sales are donated to UNICEF USA’s Every Child Nourished program.",

                          style: TextStyle(color: AppColors.black,fontFamily: "SfProDisplay",fontSize: 18,fontWeight: FontWeight.w600,),textAlign: TextAlign.center,),

                      ),

                      SizedBox(height: 36,),
                      earningDetailWidget(title: "Total sales",amount: "\$ ${totalSales.toStringAsFixed(2)}"),
                      earningDetailWidget(title: "Amount Contributed",amount: "\$ ${(totalSales*0.1).toStringAsFixed(2)}"),
                      Expanded(
                          child: SizedBox(height: Get.height*0.05,)),

                      CustomButton(text: "Amount Contributed from all Nutritionist", radius: 20, onPressed: (){
                        showDialog(context: context, builder: (_){
                          return AlertDialog(

                            content: Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(child: Text("Contributions",style: TextStyle(color: AppColors.black,fontFamily: "SfProDisplay",fontSize: 18,fontWeight: FontWeight.w600),)),
                                SizedBox(height: 16,),
                                Center(child: Text("\$ ${(amountFromAllContributors*0.1).toStringAsFixed(2)}",style: TextStyle(color: AppColors.black,fontFamily: "SfProDisplay",fontSize: 16,),)),
                                SizedBox(height: 24,),
                                CustomButton(text: "Okay", radius: 10, onPressed: (){
                                  Get.back();
                                })
                              ],
                            ),
                          );
                        });

                      },height: 53,),
                      SizedBox(height: 12,),

                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget earningDetailWidget({String? title,String? amount}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          color: AppColors.white2,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(0, 5))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.greyBlack,
          ),
          CustomText(
            text: amount,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: AppColors.lightGreen,
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}