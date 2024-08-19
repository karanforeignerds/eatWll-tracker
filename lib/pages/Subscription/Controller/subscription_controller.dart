import 'package:eatwelltracker/purchases/purchase_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionController extends GetxController{

  @override
  Future<void> onInit() async {
    await fetchOffers();
    // TODO: implement onInit
    super.onInit();
  }

  RxList<Package> subscriptionPackages=<Package>[].obs;

  Future fetchOffers() async{
    print("Fetching Offer===================================");
    final offerings=await PurchaseApi.fetchOffers();
    if(offerings.isEmpty){
      print("offering is empty");
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text("No Plans Found")));
    }else{
      subscriptionPackages.clear();
      print("offering is not empty");
      final packages=offerings.map((offer) => offer.availablePackages).expand((pair) => pair).toList();
      subscriptionPackages.value=packages;
    }
  }

}