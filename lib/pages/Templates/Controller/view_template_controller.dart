import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/Model/set_goal_wid_model.dart';
import 'package:get/get.dart';

class ViewTemplateController extends GetxController{

  RxList setGoalData = [
  SetGoalWidgetModel(name: "Meat/Protein", count: 0.obs),
  SetGoalWidgetModel(name: "Dairy", count: 0.obs),
  SetGoalWidgetModel(name: "Vegetable", count: 0.obs),
  SetGoalWidgetModel(name: "Fruit", count: 0.obs),
  SetGoalWidgetModel(name: "Bread/Starch", count: 0.obs),
  SetGoalWidgetModel(name: "My Food", count: 0.obs),
  SetGoalWidgetModel(name: "My Dishes", count: 0.obs),
  SetGoalWidgetModel(name: "Water", count: 0.obs),
  SetGoalWidgetModel(name: "Other", count: 0.obs),
].obs;

  saveGoal(){
    List goalData=[];
    for(int i=0;i<setGoalData.length;i++){
      SetGoalWidgetModel data = setGoalData[i];
      goalData.add({
        "name":data.name,
        "quantity":data.count!.value,
      });
    }
    FirebaseFirestore.instance.collection("Goals").doc(auth.currentUser!.uid).set({
      "goal":goalData,
    });
    // FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Goals").doc(DateFormat('yyyy-MM-dd').format(DateTime.now())).get().then((value){
    //   if(value.exists){
    //     Get.defaultDialog(
    //         title: "",
    //         contentPadding: EdgeInsets.zero,
    //         content: SizedBox(
    //           width: Get.width * 0.9,
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 horizontal: 16.0),
    //             child: Column(
    //               children: [
    //                 Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: CustomText(
    //                       color: AppColors.black,
    //                       text: "You already set today goal. Do you want to change today goal?",
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                       align: TextAlign.center,
    //                     )),
    //                 const SizedBox(
    //                   height: 30,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     SizedBox(
    //                       width: Get.width*0.25,
    //                       height: Get.height*0.05,
    //                       child: CustomButton(
    //                         text: "Yes",
    //                         radius: 15,
    //                         onPressed: () {
    //                           value.reference.update({
    //                             "goal":goalData,
    //                           }).then((value) =>Get.close(2));
    //                         },
    //                         width: 172,
    //                         height: 53,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: Get.width*0.25,
    //                       height: Get.height*0.05,
    //                       child: CustomButton(
    //                         text: "No",
    //                         radius: 15,
    //                         onPressed: () {
    //                           Get.back();
    //                         },
    //                         width: 172,
    //                         height: 53,
    //                       ),
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ));
    //   }else{
    //     FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Goals").doc(DateFormat('yyyy-MM-dd').format(DateTime.now())).set({
    //       "date":DateFormat("yyyy-MM-dd").format(DateTime.now()),
    //       "goal":goalData,
    //     });
    //     Get.back();
    //   }
    // });
  }
}