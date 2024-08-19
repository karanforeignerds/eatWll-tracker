

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:get/get.dart';

class IntakeHistoryController extends GetxController{


  Future<List<DocumentSnapshot>> intakeHistoryRange(
      {required RxString startDate,
      required RxString endDate,
      DocumentSnapshot? viewUserSnapshot}) async {
    print(startDate.value+" // "+endDate.value+"=========================");
    List<DocumentSnapshot> snapshotList=[];

    await FirebaseFirestore.instance.collection("Users").doc(viewUserSnapshot!=null?viewUserSnapshot.id:auth.currentUser!.uid).collection("Goals").get().then((snapshot){
      if(snapshot.docs.isNotEmpty){
        for(int i=0;i<snapshot.size;i++){
          if(startDate.value!="" && endDate.value!=""
              && (DateTime.parse("${snapshot.docs[i].id} 00:00:00").isAfter(DateTime.parse("${startDate.value} 00:00:00"))||snapshot.docs[i].id==startDate.value)
              && (DateTime.parse("${snapshot.docs[i].id} 00:00:00").isBefore(DateTime.parse("${endDate.value} 00:00:00"))||snapshot.docs[i].id==endDate.value)){
            print(1);
            snapshotList.add(snapshot.docs[i]);
          }
          else if(startDate.value!="" && endDate.value=="" &&
              (DateTime.parse("${snapshot.docs[i].id} 00:00:00").isAfter(DateTime.parse("${startDate.value} 00:00:00"))||snapshot.docs[i].id==startDate.value)
              &&  DateTime.parse("${snapshot.docs[i].id} 23:59:59").isBefore(DateTime.now())){
            print(2);
            snapshotList.add(snapshot.docs[i]);

          }
          else if(startDate.value=="" && endDate.value!=""
              && (DateTime.parse("${snapshot.docs[i].id} 00:00:00").isBefore(DateTime.parse("${endDate.value} 00:00:00"))||snapshot.docs[i].id==endDate.value)
              &&  DateTime.parse("${snapshot.docs[i].id} 23:59:59").isBefore(DateTime.now())){
            print(3);
            snapshotList.add(snapshot.docs[i]);
          }
          else{
            print(4);
            if(startDate.value=="" && endDate.value==""){
              snapshotList.add(snapshot.docs[i]);
            }
          }
        }
      }
    });

    return snapshotList;
  }

  Future<List<Map<String,dynamic>>> sumOFGoals( goalSnapshot) async{
    List<Map<String,dynamic>> data=[];
    for(int i=0;i<goalSnapshot.length;i++){
      for(int k=0;k<goalSnapshot[i]['goal'].length;k++){
        if(i==0){
          data.add({
            "name":goalSnapshot[i]['goal'][k]['name'],
            'quantity':goalSnapshot[i]['goal'][k]['quantity'],
            'dates':[goalSnapshot[i].id]
          });
        }else{
          data[k]['quantity']=double.parse(data[k]['quantity'].toString())+double.parse(goalSnapshot[i]['goal'][k]['quantity'].toString());
          data[k]['dates'].add(goalSnapshot[i].id);
        }
      }
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> logFood({required List dates, DocumentSnapshot? viewUserSnapshot}) async{

    List<Map<String,dynamic>> inTakeData=[
      {'name':'Meat/Protein','quantity':0.0},
      {'name':'Dairy','quantity':0.0},
      {'name':'Vegetable','quantity':0.0},
      {'name':'Fruit','quantity':0.0},
      {'name':'Bread/Starch','quantity':0.0},
      {'name':'Water','quantity':0.0},
      {'name':'Other','quantity':0.0},
    ];

    for(int i=0;i<dates.length;i++){

     await FirebaseFirestore.instance.collection("Users")
         .doc(viewUserSnapshot!=null?viewUserSnapshot.id:auth.currentUser!.uid).collection("LogFood").where('date',isEqualTo: dates[i]).get().then((value){
        if(value.docs.isNotEmpty){
          print(value.docs.length);
          for(int k=0;k<value.docs.length;k++){
            inTakeData.forEach((element) {
              if(element['name']==value.docs[k]['category']){
                element['quantity']=double.parse(element['quantity'].toString())+double.parse(value.docs[k]['quantity'].toString());
              }
            });
          }
        }
      });
    }
    print(inTakeData);

    return inTakeData;
  }


}