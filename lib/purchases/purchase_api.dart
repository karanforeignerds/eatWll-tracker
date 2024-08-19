import 'dart:io';

import 'package:eatwelltracker/main.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi{

  static Future init() async{
    await Purchases.setLogLevel(LogLevel.info);
    Platform.isIOS?await Purchases.configure(configuration):await Purchases.configure(configuration1);
  }


  static Future<List<Offering>> fetchOffers() async{
    try{
      final offering = await Purchases.getOfferings();
      final current = offering.current;

      print("$current=========");
      return current == null ? [] : [current];
    }on PlatformException catch(e){
      print(e.toString());
      return [];
    }
  }

  static Future<bool> purchasePackage(Package package)async{

    try{
      await Purchases.purchasePackage(package);
      return true;
    }catch (e){
      print(e.toString()+"==================");
      return false;
    }
  }
}