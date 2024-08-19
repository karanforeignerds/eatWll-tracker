import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/constants/colors.dart';
import 'package:eatwelltracker/pages/CheckUserType/check_user_type.dart';
import 'package:eatwelltracker/pages/Subscription/Controller/subscription_controller.dart';
import 'package:eatwelltracker/purchases/check_subscription.dart';
import 'package:eatwelltracker/purchases/purchase_api.dart';
import 'package:eatwelltracker/widgets/button.dart';
import 'package:eatwelltracker/widgets/custom_text.dart';
import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../main.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({Key? key, this.data}) : super(key: key);

  final Package? data;

  @override
  Widget build(BuildContext context) {
    final product = data!.storeProduct;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 261,
        width: Get.width,
        decoration: const BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 5,
                offset: Offset(1, 4),
                spreadRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppColors.skyBlue,
              ),
              child: CustomText(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                text: product.title,
                fontSize: 18,
                align: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                  child: CustomText(
                    color: AppColors.lightGreen,
                    fontWeight: FontWeight.w700,
                    text: product.currencyCode.toLowerCase() == "usd"
                        ? "\$"
                        : product.currencyCode,
                    fontSize: 18,
                    align: TextAlign.center,
                  ),
                ),
                CustomText(
                  color: AppColors.lightGreen,
                  fontWeight: FontWeight.w700,
                  text: product.price.toStringAsFixed(2),
                  fontSize: 28,
                  align: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: AppColors.greyBlack,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomText(
                    color: AppColors.greyBlack,
                    text: product.description,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              text: activeSubscription.contains(data!.storeProduct.identifier)
                  ? 'Active'
                  : "Buy",
              radius: 25,
              onPressed: () async {
                if (activeSubscription
                    .contains(data!.storeProduct.identifier)) {
                  subscriptionInfo();
                } else {
                  loadingDialog(message: "Wait...", loading: true);
                  var isPurchaseSuccess = await PurchaseApi.purchasePackage(
                    data!,
                  );
                  if (isPurchaseSuccess == true) {
                    Get.find<SubscriptionController>().fetchOffers();
                    Get.back();
                    await Get.find<CheckSubscription>().init();

                    ///Subscription details========================================================================================================
                    subscriptionsDetail(
                        subscriptionPrice: product.price,
                        subscriptionType: product.title,
                        subscriptionCurrency: product.currencyCode);

                    ///========================================================================================================
                    Get.offAll(CheckUserType());
                  } else {
                    Get.back();
                  }
                }
              },
              height: 53,
              width: 172,
            )
          ],
        ),
      ),
    );
  }

  subscriptionInfo() async {
    try {
      print("object");
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      for (var element in customerInfo.entitlements.active.values) {
        print(element);
        if (element.isActive &&
            element.productIdentifier == data!.storeProduct.identifier) {
          return showDialog(
              context: Get.context!,
              builder: (_) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        color: AppColors.greyBlack,
                        text:
                            'Member since ${DateFormat('yyyy-MM-dd').format(DateTime.parse(element.originalPurchaseDate))}',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        color: AppColors.greyBlack,
                        text:
                            "Expires at ${DateFormat('yyyy-MM-dd').format(DateTime.parse(element.expirationDate!))}",
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Okay",
                        radius: 10,
                        onPressed: () => Get.back(),
                        width: Get.width * 0.3,
                      ),
                    ],
                  ),
                );
              });
        }
      } // access latest customerInfo
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  subscriptionsDetail(
      {subscriptionType, subscriptionPrice, subscriptionCurrency}) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((userData) {
      if (userData['referralCode'] != "") {
        FirebaseFirestore.instance
            .collection('Referrals')
            .where('code', isEqualTo: userData['referralCode'])
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            FirebaseFirestore.instance.collection("SubscriptionsDetail").add({
              'authId': auth.currentUser!.uid,
              'referralCode': userData['referralCode'],
              'type': subscriptionType,
              'price': subscriptionPrice,
              'currency': subscriptionCurrency,
              'nutritionistId': value.docs[0]['userId'],
              'date': DateTime.now()
            });

            await userData.reference.update({
              'subscriptionType': subscriptionType,
            });
          } else {
            FirebaseFirestore.instance.collection("SubscriptionsDetail").add({
              'authId': auth.currentUser!.uid,
              'referralCode': '',
              'type': subscriptionType,
              'price': subscriptionPrice,
              'currency': subscriptionCurrency,
              'nutritionistId': '',
              'date': DateTime.now()
            });
            await userData.reference.update({
              'subscriptionType': subscriptionType,
            });
          }
        });
      }
    });
  }
}
