import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/constants/string.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewUserGoal extends StatelessWidget {
  ViewUserGoal({super.key, required this.viewUserSnapshot});
  final DocumentSnapshot viewUserSnapshot;

  final RxString selectedDate="".obs;
  final Rx<DateTime> date=DateTime.now().obs;


  @override
  Widget build(BuildContext context) {
    selectedDate.value=DateFormat("yyyy-MM-dd").format(date.value);
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            title:"Goals",
            centerTitle: true,
            backNavigation: true,
            profile: true,
            onPressed: () {
              Get.back();
            },
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
            child: Row(
              children: [
                Text("Select Date:",style: TextStyle(color: lightGreen,fontWeight: FontWeight.w600,fontSize: 16)),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () async {
                    var _date = await showDatePicker(
                      context: context,
                      initialDate: date.value,
                      firstDate: DateTime.parse("2023-01-01"),
                      lastDate: DateTime.now());
                    if(_date!=null){
                      selectedDate.value=DateFormat("yyyy-MM-dd").format(_date);
                      date.value=_date;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColors.lightGreen),
                        borderRadius: BorderRadius.circular(5)),
                    child: Obx(() => CustomText(
                      text: selectedDate.value!=""?DateFormat("MM-dd-yyyy").format(date.value):"MM-DD-YYYY",
                      color: AppColors.greyBlack,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => StreamBuilder<DocumentSnapshot>(
              stream: selectedDate.value==DateFormat("MM-dd-yyyy").format(DateTime.now())
                  ?FirebaseFirestore.instance.collection("Goals").doc(viewUserSnapshot.id).snapshots()
                  :FirebaseFirestore.instance.collection("Users").doc(viewUserSnapshot.id)
                  .collection('Goals').doc(selectedDate.value).snapshots(),
              builder: (_, goalSnapshot) {
                print(viewUserSnapshot.id);
                if (goalSnapshot.connectionState == ConnectionState.waiting) {

                  return Center(child: CircularProgressIndicator());

                }

                return Expanded(
                  child: Column(
                    children: [
                      !goalSnapshot.data!.exists
                          ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height*0.1),
                          child: CustomText(
                            text: "Empty",
                            color: AppColors.greyBlack,
                          ),
                        ),
                      ) : Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: goalSnapshot.data!['goal'].length,
                          itemBuilder: (_, int index) {
                            return HomeCard(
                              isPickForMe: true,
                              data: goalsCardData[index],
                              height: 140,
                              name: goalSnapshot.data!['goal'][index]['name'],
                              quantity: int.parse(goalSnapshot.data!['goal'][index]['quantity'].toString()),
                            );
                          },
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 140,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 3),
                        ),
                      ),

                    ],
                  ),
                );
              })),
        ],
      ),
    );
  }
}
