import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/pages/MyDishes/controller/mydishes_controller.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../main.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';

class AddDish extends StatelessWidget {
  AddDish(
      {Key? key,
      required this.dateTime,
      required this.isEdit,
      this.dishSnapshot})
      : super(key: key);

  final controller = Get.put(MyDishesController());
  final DateTime dateTime;
  final bool isEdit;
  DocumentSnapshot? dishSnapshot;

  @override
  Widget build(BuildContext context) {
    controller.items.clear();

    if (dishSnapshot != null) {
      for (int i = 0; i < dishSnapshot!['items'].length; i++) {
        controller.items.add(Container());
      }
      controller.dishNameController.text = dishSnapshot!['logFoodType'];
    } else {
      controller.items.add(Container());
    }

    return Scaffold(
      backgroundColor: AppColors.white3,
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppBarWidget(
              profile: true,
              title: dishSnapshot == null
                  ? "Add Dish"
                  : dishSnapshot!['logFoodType'],
              centerTitle: true,
              backNavigation: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    // padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const CustomText(
                          color: AppColors.greyBlack,
                          text: "Name",
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                          controller: controller.dishNameController,
                          onValidate: (val) {
                            if (val!.trim().isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                          hint: "Enter dish name",
                          hintSize: 14,
                          textFieldColor: AppColors.shadowColor),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Categories")
                              .snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            List<String> categorySnapshot = ["Select Category"];
                            RxList<List<String>> servings = [['Select Serving']].obs;
                            for (int i = 0; i < snapshot.data!.docs.length; i++) {
                              categorySnapshot.add(snapshot.data!.docs[i]['name']);
                              List<String> list = ['Select Serving'];
                              if (snapshot.data!.docs[i]['name'] == "My Dishes") {
                                FirebaseFirestore.instance.collection("Users").doc(auth.currentUser!.uid).collection("MyDishes").get().then((value) {
                                  if (value.docs.isNotEmpty) {
                                    for (int k = 0; k < value.docs.length; k++) {
                                      list.add(value.docs[k]['name']);
                                    }
                                  }
                                });
                              } else {
                                for (int j = 0; j < snapshot.data!.docs[i]['servings'].length; j++) {
                                  list.add(snapshot.data!.docs[i]['servings'][j]);
                                }
                              }
                              servings.add(list);
                            }

                            print(categorySnapshot);
                            print(servings);

                            return Obx(() => ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: controller.items.length,
                                itemBuilder: (_, int index) {
                                  return
                                  //   itemSection(
                                  //     index: index,
                                  //     categorySnapshot: categorySnapshot,
                                  //     servings: servings,
                                  //     category: ,
                                  //     quantity: ,
                                  //     serving: ,
                                  // );
                                    itemSection(
                                      index: index,
                                      categorySnapshot: categorySnapshot,
                                      servings: servings,
                                      category: dishSnapshot!=null && index<dishSnapshot!['items'].length
                                          ? dishSnapshot!['items'][index]['category']
                                          : null,
                                      serving: dishSnapshot!=null && index<dishSnapshot!['items'].length
                                          ? dishSnapshot!['items'][index]['serving']
                                          : null,
                                      quantity: dishSnapshot!=null && index<dishSnapshot!['items'].length
                                          ? dishSnapshot!['items'][index]['quantity']
                                          : null);
                                }));
                          }),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            controller.items.add(Container());
                          },
                          child: Text(
                            'Add new item',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        width: 178,
                        height: 53,
                        text: isEdit ? 'Save Dish' : 'Save Dish',
                        radius: 15,
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            isEdit
                                ? controller.editDish(dishSnapshot: dishSnapshot!)
                                : controller.addDish(date: dateTime);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemSection({
    required int index,
    required List<String> categorySnapshot,
    required RxList servings,
    String? category,
    String? serving,
    String? quantity,
  }) {
    controller.quantityControllers.add(TextEditingController());
    controller.selectedIndex.add(0.obs);
    controller.selectedServing.add("Select Serving".obs);
    controller.selectedCategory.add("".obs);
    controller.otherCategoryControllers.add(TextEditingController());

    if (category != null && category == 'Other') {
      controller.selectedCategory[index].value = "Other";
    }

    else {
      if (category != null) {
        controller.selectedIndex[index].value =
            categorySnapshot.indexOf(category);
        controller.selectedCategory[index].value = category;
      }
      controller.otherCategoryControllers.add(TextEditingController());
    }

    if (serving != null) {
      controller.selectedServing[index].value = serving;

      if (category != null && category == 'Other')
        controller.otherCategoryControllers[index].text = serving;
    }

    if (quantity != null) {
      controller.quantityControllers[index].text = quantity;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.shadowColor,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () {
                  controller.items.removeAt(index);
                  controller.quantityControllers.removeAt(index);
                  controller.otherCategoryControllers.removeAt(index);
                  controller.selectedIndex.removeAt(index);
                  controller.selectedServing.removeAt(index);
                  controller.selectedCategory.removeAt(index);
                },
                child: Icon(
                  Icons.cancel,
                  color: AppColors.lightGreen,
                )),
          ),
          const CustomText(
            color: AppColors.greyBlack,
            text: "Select Category",
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownWidget(
            value: category == null ? categorySnapshot[0] : category,
            list: categorySnapshot,
            onchange: (value) async {
              print(value);
              controller.selectedIndex[index].value =
                  categorySnapshot.indexOf(value);
              controller.selectedServing[index].value = "Select Serving";
              controller.selectedCategory[index].value = value;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Obx(() => CustomText(
                color: AppColors.greyBlack,
                text: controller.selectedCategory[index].value == "Other"
                    ? "Other category"
                    : "Select Serving",
                fontSize: 15,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(
            height: 16,
          ),
          Obx(
            () => controller.selectedCategory[index].value == "Other"
                ? CustomTextField(
                    controller: controller.otherCategoryControllers[index],
                    onValidate: (val) {
                      if (val!.trim().isEmpty) {
                        return "Field is required";
                      }
                      controller.selectedServing[index].value = val.toString();
                      return null;
                    },
                    hint: "Add name",
                    hintSize: 14,
                    textFieldColor: Colors.grey.withOpacity(0.1))
                : DropdownWidget(
                    value: controller.selectedServing[index].value,
                    list: servings[controller.selectedIndex[index].value],
                    onchange: (val) {
                      controller.selectedServing[index].value = val;
                    },
                  ),
          ),
          const SizedBox(
            height: 24,
          ),
          const CustomText(
            color: AppColors.greyBlack,
            text: "Quantity",
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(
            height: 16,
          ),
          CustomTextField(
              keyBoardType: TextInputType.numberWithOptions(decimal: true),
              controller: controller.quantityControllers[index],
              onValidate: (val) {
                if (val!.trim().isEmpty) {
                  return "Quantity is required";
                }
                return null;
              },
              hint: "Enter Quantity",
              hintSize: 14,
              textFieldColor: Colors.grey.withOpacity(0.1)),
        ],
      ),
    );
  }
}
