import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/pages/IntakeHistory/intake_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/daily_activity_widget.dart';
import '../../widgets/drawer.dart';

class IntakeHistory extends StatelessWidget {
  final DocumentSnapshot? viewUserSnapshot;
  IntakeHistory({Key? key, this.viewUserSnapshot}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final RxString startDate="".obs;
  final RxString endDate="".obs;

  final Rx<DateTime> selectedStartDate=DateTime.now().subtract(Duration(days: 1)).obs;
  final Rx<DateTime> selectedEndDate=DateTime.now().subtract(Duration(days: 1)).obs;

  final controller =Get.put(IntakeHistoryController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const SideDrawer(),
      backgroundColor: AppColors.white1,
      body: Column(
        children: [
          AppBarWidget(
            title: "Intake History",
            centerTitle: true,
            backNavigation: true,
            profile: true,
            scfolldKey: scaffoldKey,
          ),
          ///Calender Widget

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow:  [
                  BoxShadow(
                      color: AppColors.shadowColor.withOpacity(0.05),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      spreadRadius: 5),
                ]),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Starting Date",
                      color: AppColors.greyBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDate.value,
                          firstDate: DateTime.parse("2023-01-01"),
                          lastDate: DateTime.now().subtract(Duration(days: 1)),);
                        if(date!=null){
                          startDate.value=DateFormat("yyyy-MM-dd").format(date);
                          selectedStartDate.value=date;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: AppColors.lightGreen),
                            borderRadius: BorderRadius.circular(5)),
                        child: Obx(() => CustomText(
                          text: startDate.value!=""?DateFormat("MM-dd-yyyy").format(selectedStartDate.value):"MM-DD-YYYY",
                          color: AppColors.greyBlack,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/timer 1.png",
                    width: 30,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Ending Date",
                      color: AppColors.greyBlack,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var date =await showDatePicker(

                            context: context,
                            initialDate: selectedEndDate.value,
                            firstDate: DateTime.parse("2023-01-01"),
                            lastDate: DateTime.now());
                        if(date!=null){
                          endDate.value=DateFormat("yyyy-MM-dd").format(date);
                          selectedEndDate.value=date;
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: AppColors.lightGreen),
                            borderRadius: BorderRadius.circular(5)),
                        child: Obx(() => CustomText(
                          text: endDate.value!=""?DateFormat("MM-dd-yyyy").format(selectedEndDate.value):"MM-DD-YYYY",
                          color: AppColors.greyBlack,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    )
                  ],
                ),
              ],
            ) ,
          ),

          Expanded(
            child: Obx(() =>  FutureBuilder(
                future: startDate.value!="" || endDate.value!=""
                    ?controller.intakeHistoryRange(startDate: startDate,endDate:  endDate,viewUserSnapshot: viewUserSnapshot)
                    :controller.intakeHistoryRange(startDate: startDate,endDate:  endDate,viewUserSnapshot: viewUserSnapshot),
                builder: (_,goalSnapshot){

                  if(goalSnapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }

                  // if(startDate.value=="" && endDate.value==""){
                  //   return Center(child: Text('Choose date range'));
                  // }

                  if(goalSnapshot.data!.isEmpty){
                    return Center(child: Text('Empty'));
                  }

                  return FutureBuilder(
                      future: controller.sumOFGoals(goalSnapshot.data),
                      builder: (_,sumOfGoal){

                        if(sumOfGoal.connectionState==ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }


                        return FutureBuilder(
                            future: controller.logFood(dates: sumOfGoal.data![0]['dates'],viewUserSnapshot: viewUserSnapshot),
                            builder: (_,intakeData){

                              if(intakeData.connectionState==ConnectionState.waiting){
                                return Center(child:  CircularProgressIndicator(),);
                              }
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        primary: false,
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                                        shrinkWrap: true,
                                        itemCount:sumOfGoal.data!.length,
                                        itemBuilder: (_, int index) {
                                          var goalData=sumOfGoal.data![index];
                                          var takenData=intakeData.data![index];
                                          print(goalData['name']);
                                          print(takenData['quantity']);
                                          print(goalData['quantity']);
                                          print( (takenData['quantity']/double.parse(goalData['quantity'].toString()))*100.0);
                                          return DailyActivityWidget(
                                            isIntakePage: true,
                                            title: goalData['name'],
                                            completeValue:goalData['quantity']==0 && takenData['quantity']==0 ?0:(takenData['quantity']/double.parse(goalData['quantity'].toString()))*100.0,
                                          ) ;
                                        }),
                                  ],
                                ),
                              );

                            });
                      });

                })
            ),
          )
        ],
      ),
    );
  }
}
