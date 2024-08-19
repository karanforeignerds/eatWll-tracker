import 'package:eatwelltracker/pages/DailyActivity/daily_activity.dart';
import 'package:eatwelltracker/pages/Goals/set_goals.dart';
import 'package:eatwelltracker/pages/Home/home.dart';
import 'package:eatwelltracker/pages/IntakeHistory/intake_history.dart';
import 'package:eatwelltracker/pages/InviteFriend/invite_friend.dart';
import 'package:eatwelltracker/widgets/Model/category_card_model.dart';
import 'package:eatwelltracker/widgets/Model/home_card_model.dart';
import 'package:eatwelltracker/widgets/Model/log_food_model.dart';
import 'package:get/get.dart';

List goalsCardData = [
  HomeCardModel(
      image: "assets/meat.png", name: "Meat/Protein", quantity: "2/3"),
  HomeCardModel(
      image: "assets/dairy-products.png", name: "Dairy", quantity: "2/3"),
  HomeCardModel(
      image: "assets/vegetable.png", name: "Vegetable", quantity: "✅"),
  HomeCardModel(image: "assets/fruit.png", name: "Fruit", quantity: "1/3"),
  HomeCardModel(
      image: "assets/bread.png", name: "Bread/Starch", quantity: "3/4"),
  HomeCardModel(
      image: "assets/water-bottle 1.png", name: "Water", quantity: "5/8"),
  HomeCardModel(image: "assets/others.png", name: "Other", quantity: "✅"),
];
List categoryCardData = [
  CategoryCardModel(
      image: "assets/c1.png",
      title: "Log Food",
      description:
          "Lörem ipsum regisk sesöck, klittra, lare plad, beräska. Nasade vegen och refölig tenas. Kabel soren. Vangen sodiling för palad beling. Vabening nilingar serad."),
  CategoryCardModel(
      image: "assets/c1.png",
      title: "Goals",
      description:
          "Lörem ipsum regisk sesöck, klittra, lare plad, beräska. Nasade vegen och refölig tenas. Kabel soren. Vangen sodiling för palad beling. Vabening nilingar serad.")
];

/*
  HomeCardModel(image: "assets/diet (1).png", name: "My Food", quantity: "✅"),
  HomeCardModel(
      image: "assets/polyunsaturated-fat 1.png",
      name: "My Dishes",
      quantity: "✅"),*/

List logFoodCardData = [
  LogFoodModel(
      image: "assets/pngwing 1.png",
      title: "Breakfast items",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Fruit"),
        NameAndQuantity(quantity: 1, name: "Bread/Starch"),
        NameAndQuantity(quantity: 2, name: "Meat/Protein"),
      ]),
  LogFoodModel(
      image: "assets/pngwing 4.png",
      title: "Morning Snack",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Vegetables"),
        NameAndQuantity(quantity: 1, name: "Bread/Starch"),
        NameAndQuantity(quantity: 2, name: "Fruit"),
      ]),
  LogFoodModel(
      image: "assets/pngwing 5.png",
      title: "Lunch items",
      nameAndQuantity: [
        NameAndQuantity(quantity: 1, name: "Bread/Starch"),
        NameAndQuantity(quantity: 1, name: "Fats"),
        NameAndQuantity(quantity: 2, name: "Dairy"),
      ]),
  LogFoodModel(
      image: "assets/afternoon_pic.png",
      title: "Afternoon Snack",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Fruit"),
        NameAndQuantity(quantity: 1, name: "Bread/Starch"),
        NameAndQuantity(quantity: 2, name: "Meat/Protein"),
      ]),
  LogFoodModel(
      image: "assets/dinner_pic.png",
      title: "Dinner items",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Fruit"),
        NameAndQuantity(quantity: 1, name: "Bread/Starch"),
        NameAndQuantity(quantity: 2, name: "Meat/Protein"),
      ]),
  LogFoodModel(
      image: "assets/evening_pic.png",
      title: "Evening Snack",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Bread/Starch"),
        NameAndQuantity(quantity: 1, name: "Fats"),
        NameAndQuantity(quantity: 2, name: "Meat/Protein"),
      ]),
  LogFoodModel(
      image: "assets/pngwing 1.png",
      title: "My Dishes",
      nameAndQuantity: [
        NameAndQuantity(quantity: 2, name: "Bread/Starch"),
        NameAndQuantity(quantity: 1, name: "Fats"),
        NameAndQuantity(quantity: 2, name: "Meat/Protein"),
      ]),
];

List logFood = [
  LogFoodModel(
    image: "assets/breakfast.png",
    title: "Breakfast",
  ),
  LogFoodModel(
    image: "assets/morning.png",
    title: "Morning",
  ),
  LogFoodModel(
    image: "assets/lunch.png",
    title: "Lunch",
  ),
  LogFoodModel(
    image: "assets/afternoon.png",
    title: "Afternoon Snack",
  ),
  LogFoodModel(
    image: "assets/dinner.png",
    title: "Dinner",
  ),
  LogFoodModel(
    image: "assets/evening.png",
    title: "Evening Snack",
  ),
  LogFoodModel(
    image: "assets/main-dish2.png",
    title: "My Dishes",
  ),
];
List<LogFoodModel> dashboardList = [
  LogFoodModel(
    image: "assets/logfood.png",
    title: "Log Food",
    onTap: () {
      Get.to(() => Home());
    },
  ),
  LogFoodModel(
    image: "assets/daily.png",
    title: "Daily Activity",
    onTap: () {
      Get.to(() => DailyActivity());
    },
  ),
  LogFoodModel(
    image: "assets/history.png",
    title: "Intake History",
    onTap: () {
      Get.to(() => IntakeHistory());
    },
  ),
  LogFoodModel(
    image: "assets/goal.png",
    title: "Set Goals",
    onTap: () {
      Get.to(()=>SetGoals());
      // Get.to(()=>Goals());
    },
  ),
  LogFoodModel(
    image: "assets/referrals.png",
    title: "Invite my Friends",
    onTap: () async {
      Get.to(() => InviteFriend());
    },
  ),
  LogFoodModel(
    image: "assets/bibimbap 1.png",
    title: "My Information",
  ),
];
