import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/pages/Templates/view_template.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/appbar_widget.dart';

class SavedTemplates extends StatelessWidget {
  SavedTemplates({Key? key}) : super(key: key);
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            profile: true,
            backNavigation: true,
            centerTitle: true,
            scfolldKey: scaffoldkey,
            title: "Saved Templates",
          ),
          Expanded(
              child:StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("Templates").snapshots(),
                builder: (_,templateSnapshot){
                  if(templateSnapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(templateSnapshot.data!.docs.isEmpty){
                    return Center(child: CustomText(text: "No template available",color: AppColors.greyBlack),);
                  }
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: templateSnapshot.data!.size,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: ()=>Get.to(ViewTemplate(template: templateSnapshot.data!.docs[index],)),
                          child: ListTile(
                            title: CustomText(text: templateSnapshot.data!.docs[index]['name'],color: AppColors.black),
                          ),
                        );
                      });
                },
              )
          )
        ],
      ),
    );
  }
}
