import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/Model/home_card_model.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeCard extends StatelessWidget {
  HomeCard({Key? key,this.data,this.height, required this.name, required this.quantity, required this.isPickForMe}) : super(key: key);

  final String name;
  final int quantity;
  final bool isPickForMe;

  final HomeCardModel? data;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return
    isPickForMe
        ?
    name=="Other"?SizedBox():Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:height?? 120,
        width: 100,
        decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: AppColors.shadowColor,blurRadius: 4,spreadRadius: 3,offset: const Offset(0,4))]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("${data!.image}",height: 60,),
            CustomText(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 13,text: name,),
            CustomText(color: AppColors.black,fontWeight: FontWeight.w700,fontSize: 13,
              text: name=="Water"?"${quantity} oz":quantity.toString(),
            ),
          ],
        ),
      ),
    )
        :
    StreamBuilder<QuerySnapshot>(
        stream:
        FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("LogFood").where("date",isEqualTo: DateFormat("yyyy-MM-dd").format(DateTime.now())).where('category',isEqualTo: name).snapshots(),
        builder: (_,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return SizedBox();
          }
          int dataQuantity=0;
          for(int i=0;i<snapshot.data!.size;i++){
            dataQuantity=(double.parse(dataQuantity.toString())+double.parse(snapshot.data!.docs[i]['quantity'])).toInt();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height:height?? 120,
              width: 100,
              decoration: BoxDecoration(
                  color: AppColors.white2,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: AppColors.shadowColor,blurRadius: 4,spreadRadius: 3,offset: const Offset(0,4))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("${data!.image}",height: 60,),
                  CustomText(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 13,text: name,),
                  CustomText(color: AppColors.black,fontWeight: FontWeight.w700,fontSize: 13,
                    text: name=="Other"&&quantity==0
                        ? dataQuantity.toString()
                        : dataQuantity==quantity
                        ? "✅"
                        : name=="Water"
                            ?"${dataQuantity}/${quantity.toString()} oz"
                            :"${dataQuantity}/${quantity.toString()}",
                  ),
                ],
              ),
            ),
          );
        });

  }
}
