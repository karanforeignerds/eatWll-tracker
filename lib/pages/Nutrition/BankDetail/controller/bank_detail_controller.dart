import 'package:get/get.dart';

class BankDetailController extends GetxController{

  List<String> states=["Choose State","New York","New Jersey","New Mexico","Washington","Florida","California"];
  List<String> accountType=["Select an account type","Saving","Current","Other"];

  RxString selectedState="Choose State".obs;
  RxString selectedAccountType="Select an account type".obs;

}