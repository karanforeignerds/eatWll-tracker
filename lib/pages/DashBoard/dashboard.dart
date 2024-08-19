import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/drawer.dart';
import '../../widgets/logFood_widget.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key, required this.userData,  this.fromRegistration=false}) : super(key: key);

  final DocumentSnapshot userData;
  final bool fromRegistration;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final controller=Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {

    if(fromRegistration){
      controller.showFreeTrialPopUp();
    }

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const SideDrawer(),
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            scfolldKey: scaffoldKey,
            backNavigation: false,
            // centerTitle: true,
            title: "Hi, ${userData['name']}",
          ),
          const SizedBox(height: 24),
          GridView.count(
            cacheExtent: 200,
            mainAxisSpacing: 14,
            crossAxisSpacing: 8,
            padding: EdgeInsets.symmetric(horizontal: 16),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(
              dashboardList.length,
              (index) {
                return LogFoodWidget(
                  onTap: index==dashboardList.length-1?(){scaffoldKey.currentState!.openEndDrawer();}:dashboardList[index].onTap,
                  image: dashboardList[index].image!,
                  title: dashboardList[index].title!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
