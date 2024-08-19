import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwelltracker/connectivity_check.dart';
import 'package:eatwelltracker/pages/Splash/splash.dart';
import 'package:eatwelltracker/purchases/check_subscription.dart';
import 'package:eatwelltracker/purchases/purchase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'pages/CheckUserType/check_user_type.dart';

/// todo for Ios================
final configuration =
    PurchasesConfiguration("appl_tVOGgBITbrQzrYDZNVlWAdpZEbH");
final configuration1 =
    PurchasesConfiguration("goog_wBkWyCjiDLOGNQNzwNlflSskPYm");

///

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (Platform.isIOS) {
    await Purchases.configure(configuration);
  } else {
    await Purchases.configure(configuration1);
  }
  if (auth.currentUser != null) Purchases.logIn(auth.currentUser!.uid);

  await PurchaseApi.init();
  Get.put(CheckSubscription());
  isInternetAvailable.value = await checkConnectivity();
  runApp(const MyApp());
}

final auth = FirebaseAuth.instance;
DocumentSnapshot? userInfo;
RxBool isInternetAvailable = false.obs;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // auth.signOut();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eatwell Tracker',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          fontFamily: "SfProDisplay",
        ),
        home: auth.currentUser == null ? Splash() : CheckUserType());
  }
}
