import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

enum Entitlement { free, allCourses }

List<String> activeSubscription = [];

class CheckSubscription extends GetxController {
  CheckSubscription() {
    print("checking Subscription");
    init();
  }

  Entitlement _entitlement = Entitlement.free;

  Entitlement get entitlement => _entitlement;

  Future init() async {
    Purchases.addCustomerInfoUpdateListener((customerInfo) async {
      updatePurchaserStatus();
    });
  }

  Future updatePurchaserStatus() async {
    final purchaseInfo = await Purchases.getCustomerInfo();

    activeSubscription = await purchaseInfo.activeSubscriptions;
    print(activeSubscription.length.toString() +
        "==============================");
    final entitlements =
        purchaseInfo.entitlements.active['access_eat_well_tracker'];
    _entitlement =
        entitlements != null ? Entitlement.free : Entitlement.allCourses;
    print(entitlement.toString() + "Here it is");
  }
}
