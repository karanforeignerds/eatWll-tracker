import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/daily_activity_widget.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../IntakeHistory/intake_history.dart';

class DailyActivity extends StatelessWidget {

  DailyActivity({Key? key, this.viewUserSnapshot}) : super(key: key);

  final  scaffoldkey =  GlobalKey<ScaffoldState>();
  final DocumentSnapshot? viewUserSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      endDrawer: const SideDrawer(),
      backgroundColor: AppColors.white1,
      body: Column(
        children: [
          AppBarWidget(title: "Daily Activity",centerTitle: true,backNavigation: true,profile: true,scfolldKey: scaffoldkey,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(text: "Today’s Goal",fontWeight: FontWeight.w700,fontSize: 15,color: AppColors.greyBlack,),
                GestureDetector(

                    onTap: ()=>Get.to( IntakeHistory(viewUserSnapshot: viewUserSnapshot,)),
                    child: const CustomText(text: "Intake History",fontWeight: FontWeight.w700,fontSize: 15,color: AppColors.skyBlue,)),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection("Users")
                    .doc(viewUserSnapshot!=null?viewUserSnapshot!.id:auth.currentUser!.uid).collection("Goals").doc(DateFormat('yyyy-MM-dd').format(DateTime.now())).snapshots(),
                builder: (_,goalSnapshot){
                  if(goalSnapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(!goalSnapshot.data!.exists){
                    return dataNotExit(viewUserSnapshot: viewUserSnapshot);
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 24,),
                      child: ListView.builder(
                          primary: false,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount:goalSnapshot.data!['goal'].length,
                          itemBuilder: (_,int index){
                            return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("Users")
                                    .doc(viewUserSnapshot!=null?viewUserSnapshot!.id:auth.currentUser!.uid)
                                    .collection("LogFood").where('date',isEqualTo: DateFormat('yyyy-MM-dd').format(DateTime.now()))
                                    .where('category',isEqualTo: goalSnapshot.data!['goal'][index]['name']).snapshots(),
                                builder: (_,logFoodSnapshot){
                                  if(logFoodSnapshot.connectionState==ConnectionState.waiting){
                                    return Center(child: SizedBox(),);
                                  }

                                  double dataQuantity=0.0;
                                  for(int i=0;i<logFoodSnapshot.data!.size;i++){
                                    dataQuantity=(double.parse(dataQuantity.toString())+double.parse(logFoodSnapshot.data!.docs[i]['quantity'])).toDouble();
                                  }
                                  print(goalSnapshot.data!['goal'][index]['quantity']);

                                  return DailyActivityWidget(
                                    isIntakePage: false,
                                    title: goalSnapshot.data!['goal'][index]['name'],
                                    completeValue: goalSnapshot.data!['goal'][index]['quantity']==0 && dataQuantity==0
                                        ? 0
                                        : (dataQuantity/double.parse(goalSnapshot.data!['goal'][index]['quantity'].toString()))*100.0,
                                  );

                                });

                          }),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  dataNotExit({DocumentSnapshot? viewUserSnapshot}){
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Goals')
            .doc(viewUserSnapshot!=null?viewUserSnapshot.id:auth.currentUser!.uid).snapshots(),
        builder: (_,goalSnapshot){

          if(goalSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          if(!goalSnapshot.data!.exists){
            return Center( child: CustomText(text: "Please add goal to see activity"),);
          }

          return SingleChildScrollView(
            child: ListView.builder(
                itemCount: goalSnapshot.data!['goal'].length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (_,int index){
                return DailyActivityWidget(
                  isIntakePage: false,
                  title: goalSnapshot.data!['goal'][index]['name'],
                  completeValue: 0
                );
            }),
          );
        });
  }
}
