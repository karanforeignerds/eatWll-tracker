import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/Model/log_food_model.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../constants/string.dart';
import '../pages/LogFoods/add_food.dart';
import 'appbar_widget.dart';

class LogFoodCard extends StatelessWidget {
  LogFoodCard(
      {Key? key,
      this.data,
      required this.index,
      required this.dateTime,
      this.viewUserSnapshot})
      : super(key: key);

  final LogFoodModel? data;
  final int index;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTime dateTime;
  final DocumentSnapshot? viewUserSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const SideDrawer(),
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            scfolldKey: scaffoldKey,
            backNavigation: true,
            centerTitle: true,
            title: logFoodCardData[index].title,
          ),
          const SizedBox(height: 50),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(viewUserSnapshot != null
                        ? viewUserSnapshot!.id
                        : auth.currentUser!.uid)
                    .collection('LogFood')
                    .where("date",
                        isEqualTo: DateFormat('yyyy-MM-dd').format(dateTime))
                    .where('logFoodType',
                        isEqualTo: logFoodCardData[index].title)
                    .orderBy('time', descending: true)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  return Container(
                    /// 460
                    height: 500,
                    width: Get.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32,

                      /// 16
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.15),

                              /// blue
                              offset: const Offset(3, 3),
                              spreadRadius: 10,
                              blurRadius: 15),
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          data!.image!,
                          width: 274,
                          height: 185,
                        ),
                        const SizedBox(height: 20),
                        CustomText(
                          text: data!.title,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CustomText(
                                text: "Meal intake",
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                              CustomText(
                                text: "Quantity",
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: snapshot.data!.size == 0
                              ? Center(
                                  child: CustomText(
                                    text: "No meal intake",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white.withOpacity(0.7),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      snapshot.data!.size,
                                      // data!.nameAndQuantity!.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: snapshot.data!.docs[index]
                                                  ['category'],
                                              // text: data!.nameAndQuantity![index].name,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                            ),
                                            Container(
                                              height: 23,
                                              // width: 32,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                  gradient:
                                                      const LinearGradient(
                                                          colors: [
                                                        Color(0xffFFE9B8),
                                                        Color(0xffFFE9B8),
                                                      ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight)),
                                              child: Center(
                                                  child: CustomText(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: AppColors.blackLight,
                                                // text: data!.nameAndQuantity![index].quantity
                                                text: snapshot.data!
                                                    .docs[index]['quantity']
                                                    .toString(),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        viewUserSnapshot == null
                            ? DateTime.parse(DateFormat("yyyy-MM-dd 00:00:00")
                                        .format(dateTime))
                                    .isAfter(DateTime.parse(
                                        DateFormat("yyyy-MM-dd 00:00:00")
                                            .format(DateTime.now())))
                                ? SizedBox()
                                : Container(
                                    margin: EdgeInsets.only(right: 20),
                                    alignment: Alignment.centerRight,
                                    child: FloatingActionButton.extended(
                                      onPressed: () {
                                        Get.to(AddFood(
                                          appBarTitle:
                                              logFoodCardData[index].title,
                                          dateTime: dateTime,
                                        ));
                                      },
                                      backgroundColor: Colors.white,
                                      label: Row(
                                        children: [
                                          const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.blue,
                                            ),
                                          ),
                                          Text(
                                            "Enter Food",
                                            style: TextStyle(
                                                color: AppColors.blue),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
