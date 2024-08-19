import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/LogFoods/log_foods.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../main.dart';
import 'Controller/home_controller.dart';

class Home extends StatelessWidget {
  final DocumentSnapshot? viewUserSnapshot;

  Home({Key? key, this.viewUserSnapshot, }) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SideDrawer(),
      body: Column(
        children: [
          AppBarWidget(
            backNavigation: true,
            centerTitle: true,
            title:viewUserSnapshot != null
                ? (viewUserSnapshot!.data() as Map<String, dynamic>)['name'] ?? "Unknown User"
                : "Hello, ${userInfo?['name'] ?? 'Guest'}",
             //title: viewUserSnapshot!=null?viewUserSnapshot!['name']:"Hello, ${userInfo!['name']}",
            profile: true,
            scfolldKey: scaffoldKey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => TableCalendar(
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: AppColors.black),
                      weekendStyle: TextStyle(color: AppColors.black),
                    ),
                    headerStyle: const HeaderStyle(
                        titleTextStyle:
                            TextStyle(color: AppColors.greyBlack, fontSize: 18),
                        titleCentered: true,
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: lightGreen,
                          size: 30,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: lightGreen,
                          size: 30,
                        ),
                        formatButtonVisible: false),
                    availableGestures: AvailableGestures.horizontalSwipe,
                    calendarStyle: const CalendarStyle(
                        defaultTextStyle: TextStyle(color: AppColors.black),
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(6),
                          color: AppColors.yellow,
                        )),
                    firstDay: DateTime.utc(2023, 01, 01),
                    lastDay: DateTime.utc(2050, 12, 01),

                    focusedDay: controller.today.value,
                    currentDay: controller.today.value,
                    onDaySelected: (val1, val2) {
                      Get.to(()=>LogFoodScreen(
                        dateTime: val1,
                        fromHome: true,
                        viewUserSnapshot: viewUserSnapshot,
                      ));
                      controller.today.value = val1;
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
