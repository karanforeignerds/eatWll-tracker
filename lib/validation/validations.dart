import 'package:get/get.dart';

fieldValidation(val)=>val.trim().isEmpty?"Field is required":null;
addressValidation(val)=>val.trim().isEmpty?"Address is required":null;
emailValidation(val)=>val.trim().isEmpty?"Email is required":!GetUtils.isEmail(val)?"Email is not valid":null;
phoneValidation(val)=>val.trim().isEmpty?"Phone is required":!GetUtils.isPhoneNumber(val)?"Phone is not valid":null;
passwordValidation(val)=>val.trim().isEmpty?"Password is required":val.length<6?"Password must be greater then 6 character":null;
confirmPasswordValidation(val1,val2)=>val1.trim().isEmpty?"Password is required":val1.length<6?"Password must be greater then 6 character":val1!=val2?"Password must be same":null;