class LogFoodModel{

  LogFoodModel({this.title,this.image,this.nameAndQuantity, this.onTap});

  List<NameAndQuantity>? nameAndQuantity;
  String? image;
  String? title;
  Function()? onTap;
}

class NameAndQuantity{
  NameAndQuantity({this.quantity,this.name});
  String? name;
  int? quantity;
}


