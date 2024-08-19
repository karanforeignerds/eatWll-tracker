import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/string.dart';
import 'package:eatwelltracker/pages/LogFoods/Controller/log_food_controller.dart';
import 'package:eatwelltracker/pages/LogFoods/add_food.dart';
import 'package:eatwelltracker/pages/MyDishes/my_dishes.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:eatwelltracker/widgets/logFood_widget.dart';
import 'package:eatwelltracker/widgets/log_food_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogFoodScreen extends StatelessWidget {
  LogFoodScreen({
    Key? key,
    required this.dateTime,
    this.viewUserSnapshot,
    required this.fromHome,
  }) : super(key: key);

  final controller = Get.put(LogFoodController());
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final DateTime dateTime;
  final DocumentSnapshot? viewUserSnapshot;
  final bool fromHome;

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
            title: "Log Food",
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              cacheExtent: 200,
              mainAxisSpacing: 14,
              crossAxisSpacing: 8,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(
                logFood.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      print(index);
                      print("TAPPED");
                      if (index == 6) {
                        Get.to(() => MyDishes(
                          dateTime: dateTime,
                          viewUserSnapshot: viewUserSnapshot,
                        ));
                      } else {
                        fromHome
                            ? Get.to(() => LogFoodCard(
                                  index: index,
                                  data: logFoodCardData[index],
                                  dateTime: dateTime,
                                  viewUserSnapshot: viewUserSnapshot,
                                ))
                            : Get.to(() => AddFood(
                                  appBarTitle: logFoodCardData[index].title,
                                  dateTime: dateTime,
                                ));
                      }
                    },
                    child: LogFoodWidget(
                      image: logFood[index].image!,
                      title: logFood[index].title!,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
