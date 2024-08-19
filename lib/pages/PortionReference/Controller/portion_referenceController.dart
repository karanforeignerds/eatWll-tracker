import 'package:eatwelltracker/pages/PortionReference/Model/portion_reference_model.dart';
import 'package:get/get.dart';

class PortionReferenceController extends GetxController{

  List<PortionReferenceModel > portionData=[
    PortionReferenceModel(comparison: "One Fists",      servingSize: "1 Cup", symbolImage: "assets/portion/5c4ee5fcbb7e2a029589d1c2 1.png"),
    PortionReferenceModel(comparison: "Flat Hand",      servingSize: "1 slice", symbolImage: "assets/portion/Rectangle 34625121 (3).png"),
    PortionReferenceModel(comparison: "Two Fists",      servingSize: "2 cups", symbolImage: "assets/portion/Group 1000005480 (1).png"),
    PortionReferenceModel(comparison: "Palm",           servingSize: "3 ounces", symbolImage: "assets/portion/Rectangle 34625121 (1).png"),
    PortionReferenceModel(comparison: "Pointer Figure", servingSize: "1 ½ ounce", symbolImage: "assets/portion/Rectangle 34625121.png"),
    PortionReferenceModel(comparison: "Thumps up",      servingSize: "1 Tablespoon", symbolImage: "assets/portion/Rectangle 34625121 (2).png"),

  ];

}