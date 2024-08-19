import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/main.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/notification_tile.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(
            centerTitle: true,
            title: "Notification",
            backNavigation: true,
            profile: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: CustomText(
                    //       color: AppColors.greyBlack,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 15,
                    //       text: "Unread",
                    //     )),

                    StreamBuilder<QuerySnapshot>(
                        stream:  FirebaseFirestore.instance.collection("Notification").where('userId',isEqualTo: auth.currentUser!.uid).orderBy('time',descending: true).snapshots(),
                        builder: (_,notificationSnapshot){

                          if(notificationSnapshot.connectionState==ConnectionState.waiting){
                            return Center( child: CircularProgressIndicator(),);
                          }
                          print(auth.currentUser!.uid);
                          if(notificationSnapshot.data!.docs.isEmpty){
                            return Text("Empty");
                          }

                          return SizedBox(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  primary: false,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: notificationSnapshot.data!.docs.length,
                                  itemBuilder: (_, int index) {
                                    var data =notificationSnapshot.data!.docs[index];
                                    return NotificationTile(description: data['body'],title: data['title'],image: data['image'],);
                                  }),
                            );

                        }),

                    // SizedBox(
                    //   height: 16,
                    // ),
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: CustomText(
                    //       color: AppColors.greyBlack,
                    //       fontWeight: FontWeight.w700,
                    //       fontSize: 15,
                    //       text: "Read",
                    //     )),
                    // SizedBox(
                    //   child: ListView.builder(
                    //       physics: NeverScrollableScrollPhysics(),
                    //       primary: false,
                    //       padding: EdgeInsets.zero,
                    //       shrinkWrap: true,
                    //       itemCount: 6,
                    //       itemBuilder: (_, int index) {
                    //         return NotificationTile();
                    //       }),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
