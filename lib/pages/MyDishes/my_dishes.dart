import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/MyDishes/add_dish.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enter_quantity.dart';

class MyDishes extends StatelessWidget {
  MyDishes({super.key, required this.dateTime, this.viewUserSnapshot});

  final DateTime dateTime;
  final DocumentSnapshot? viewUserSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white1,
      extendBody: true,
      floatingActionButton: viewUserSnapshot==null?FloatingActionButton(
        onPressed: () {
          Get.to(() => AddDish(
                dateTime: dateTime,
                isEdit: false,
              ));
          // selectMealType(context);
        },
        backgroundColor: AppColors.lightGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ):SizedBox(),
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            title: "My Dishes",
            centerTitle: true,
            backNavigation: true,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(viewUserSnapshot!=null?viewUserSnapshot!.id:auth.currentUser!.uid)
                .collection("MyDishes")
                .snapshots(),
            builder: (context, myDishesSnapshot) {
              if (myDishesSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (myDishesSnapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    "No Dishes",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "SfProDisplay"),
                  ),
                );
              }

              return GridView.count(
                  scrollDirection: Axis.vertical,
                  // cacheExtent: 200,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: List.generate(myDishesSnapshot.data!.size, (index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => EnterQuantity(
                          viewUserSnapshot: viewUserSnapshot,
                          dishSnapshot: myDishesSnapshot.data!.docs[index])),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  color: Colors.grey.shade200,
                                  offset: Offset(0, 5))
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                alignment: Alignment.center,
                                // width: 120,
                                // height: 120,
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                child: Image.asset(
                                  "assets/main-dish2.png",
                                  width: 100,
                                  height: 80,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              myDishesSnapshot.data!.docs[index]['logFoodType'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "SfProDisplay"),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    );
                  }));
            },
          ))
        ],
      ),
    );
  }
}
