import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/drawer.dart';
import 'package:flutter/material.dart';


class Categories extends StatelessWidget {
   Categories({Key? key}) : super(key: key);
  final  scaffoldkey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      endDrawer: SideDrawer(),
      body: Column(
        children: [
          AppBarWidget(title: "Michel",profile: true,scfolldKey: scaffoldkey,),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Image.asset("assets/calendar.png",height: 20,color: AppColors.lightGreen,),
                       const SizedBox(width: 8,),
                       const CustomText(text: "Thursday, 11 January",fontSize: 16,fontWeight: FontWeight.w500,color: AppColors.greyBlack,),
                      ],
                    ),
                    const SizedBox(height: 4,),
                    /*SizedBox(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:categoryCardData.length,
                          itemBuilder: (_,int index){
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: GestureDetector(

                                  onTap: (){
                                    if(index==0){
                                      Get.to(LogFoodScreen());
                                    }
                                    else{
                                      Get.to(Goals());
                                    }
                                  },
                                  child: CategoryCard(data: categoryCardData[index],)),
                            );
                          }),
                    ),*/

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
