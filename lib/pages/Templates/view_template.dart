import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/pages/Templates/Controller/view_template_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/Model/set_goal_wid_model.dart';
import '../../widgets/button.dart';
import '../../widgets/set_goal_widget.dart';

class ViewTemplate extends StatelessWidget {
   ViewTemplate({Key? key, required this.template}) : super(key: key);


   final scaffoldKey = GlobalKey<ScaffoldState>();
   final controller =Get.put(ViewTemplateController());
   final DocumentSnapshot template;

  @override
  Widget build(BuildContext context) {
    controller.setGoalData.clear();
    for(int i=0;i<template['goal'].length;i++){
      controller.setGoalData.add(SetGoalWidgetModel(name: template['goal'][i]['name'], count: int.parse(template['goal'][i]['quantity'].toString()).obs),);
    }
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SideDrawer(),
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            backNavigation: true,
            centerTitle: true,
            scfolldKey: scaffoldKey,
            title: template['name'],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                children:
                List.generate(controller.setGoalData.length, (index) {

                  SetGoalWidgetModel data = controller.setGoalData[index];
                  return Obx(() => SetGoalWidget(
                    name: data.name,
                    count: data.count!.value,
                    onDecrementPressed: () {
                      if(data.count!=0){
                        data.count!.value--;
                        print(controller.setGoalData[index].count);
                      }
                    },
                    onIncrementPressed: () {
                      data.count!.value++;
                    },
                  ));
                })),
          ),

          CustomButton(
            text: "Save Goal",
            radius: 15,
            height: 53,
            width: 178,
            onPressed: () {
              controller.saveGoal();
            },
          ),
        ],
      ),
    );
  }
}
