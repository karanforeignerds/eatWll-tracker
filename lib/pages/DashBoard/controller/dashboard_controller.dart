import 'package:eatwelltracker/widgets/loading_widget.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

  showFreeTrialPopUp() async {
    await Future.delayed(Duration(seconds: 3),(){loadingDialog(message: "Enjoy free trial of 7 days",button: true);});
  }

}