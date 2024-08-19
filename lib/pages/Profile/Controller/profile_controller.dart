import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/loading_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController{

final TextEditingController name=TextEditingController();
final TextEditingController email=TextEditingController();
final TextEditingController contact=TextEditingController();

XFile? image;
Rx<File> imagePath = File("").obs;
final RxString selectedDate="".obs;
RxString imageUrl="".obs;


saveProfile({required DocumentReference profileReference }){

  if(imagePath.value.path.isNotEmpty){
    loadingDialog(message: "Updating Profile",loading: true);
    Reference reference = FirebaseStorage.instance.ref("UserProfile").child(imagePath.value.path);
    UploadTask uploadTask = reference.putFile(File(imagePath.value.path));
    uploadTask.whenComplete(() async {
      if(imageUrl.value!=""){
       await FirebaseStorage.instance.refFromURL(imageUrl.value).delete();
      }
      imageUrl.value=await uploadTask.snapshot.ref.getDownloadURL();
    }).then((value) async {
      profileReference.update({
        'name':name.text,
        'd_o_b':selectedDate.value,
        'image':imageUrl.value,
        "phoneNo":contact.text
      }).then((value) {
        imagePath.value = File("");
        Get.back();

      });
    });
  }else{
    profileReference.update({
      'name':name.text,
      'd_o_b':selectedDate.value,
      'image':imageUrl.value,
      "phoneNo":contact.text
    }).then((value) {
      imagePath.value = File("");
    });
  }

}
}