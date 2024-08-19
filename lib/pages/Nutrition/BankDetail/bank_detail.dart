import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/Nutrition/BankDetail/controller/bank_detail_controller.dart';
import 'package:eatwelltracker/widgets/appbar_widget.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/custom_text_field.dart';
import 'package:eatwelltracker/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankDetail extends StatelessWidget {
  BankDetail({super.key});

  final controller =Get.put(BankDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarWidget(profile: true,title: "Bank Detail",centerTitle: true,backNavigation: true,),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=============
                    CustomText(text: "Business Name",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0,3)
                          )
                        ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "XYZ",
                        hintSize: 14,
                      ),
                    ),
                    ///======================
                    SizedBox(height: 16,),
                    CustomText(text: "Nickname you would like to call this account",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "abc",
                        hintSize: 14,
                      ),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Street Address",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "Street 21",
                        hintSize: 14,
                      ),
                    ),
                    ///=====================================
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width*0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: "City",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                              SizedBox(height: 16,),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.shadowColor,
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0,3)
                                      )
                                    ]
                                ),
                                child: CustomTextField(
                                  textFieldColor: AppColors.white2,
                                  hint: "New york",
                                  hintSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),SizedBox(
                          width: Get.width*0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              CustomText(text: "State",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                              SizedBox(height: 16,),
                              Center(
                                child: Obx(() => DropdownWidget(
                                  iconColor: AppColors.lightGreen,
                                  iconSize: 30,
                                  decoration: BoxDecoration(
                                      color: AppColors.white3,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.black.withOpacity(0.1),spreadRadius:4,blurRadius: 10
                                        )
                                      ]
                                  ),
                                  borderRadius: 15,
                                  value: controller.selectedState.value,
                                  height: 52,
                                  textColor: controller.selectedState.value=="Choose State"?AppColors.greyBlack:Colors.black,
                                  list: controller.states,
                                  onchange: (value) async {
                                    print(value);
                                    controller.selectedState.value=value;
                                  },
                                )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "ZIP Code",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "102102",
                        hintSize: 14,
                        keyBoardType: TextInputType.number,
                      ),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Routing Number",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "131383",
                        hintSize: 14,
                        keyBoardType: TextInputType.number,
                      ),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Account Number",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "1212-1212-1212",
                        hintSize: 14,
                        keyBoardType: TextInputType.number,

                      ),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Re-enter Account Number",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "1212-1212-1212",
                        hintSize: 14,
                        keyBoardType: TextInputType.number,

                      ),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Account Type",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Center(
                      child: Obx(() => DropdownWidget(
                        iconColor: AppColors.lightGreen,
                        iconSize: 30,
                        decoration: BoxDecoration(
                          color: AppColors.white3,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.black.withOpacity(0.1),spreadRadius:4,blurRadius: 10
                              )
                            ]
                        ),
                        borderRadius: 15,
                        value: controller.selectedAccountType.value,
                        height: 52,
                        textColor: controller.selectedAccountType.value=="Select an account type"?AppColors.greyBlack:Colors.black,
                        list: controller.accountType,
                        onchange: (value) async {
                          print(value);
                          controller.selectedAccountType.value=value;
                        },
                      )),
                    ),
                    ///======================================
                    SizedBox(height: 16,),
                    CustomText(text: "Notes",color: AppColors.greyBlack,fontWeight: FontWeight.w700,fontSize: 14),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.shadowColor,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0,3)
                            )
                          ]
                      ),
                      child: CustomTextField(
                        textFieldColor: AppColors.white2,
                        hint: "Note are for your record only",
                        hintSize: 14,
                        maxlines: 6,
                      ),
                    ),
                    SizedBox(height: 25,),
                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(text: "Save", radius: 10, onPressed: (){Get.back();},width: 178,height: 50,))
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
