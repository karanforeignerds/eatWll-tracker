import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static Future<XFile?> pickImages() async {
    XFile? imageFile;
    if (GetPlatform.isMobile) {
      await Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('Pick Form Gallery'),
              onTap: () async {
                imageFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Pick Form Camera'),
              onTap: () async {
                imageFile = await ImagePicker().pickImage(
                    source: ImageSource.camera);
                Get.back();
              },
            ),

          ],
        ),
      ));
      return imageFile;
    } else {
      return imageFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
    }
  }

  static Future<XFile?> pickProfilePicture() async {
    XFile? imageFile;
    if (GetPlatform.isMobile) {
      await Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('Pick Form Gallery'),
              onTap: () async {
                imageFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Pick Form Camera'),
              onTap: () async {
                imageFile = await ImagePicker().pickImage(
                    source: ImageSource.camera);
                Get.back();
              },
            ),
          ],
        ),
      ));
      return imageFile;
    } else {
      return imageFile = await ImagePicker().pickImage(
          source: ImageSource.gallery);
    }
  }

  static Future<List<XFile?>?> pickLocationImages() async {
    List<XFile?>? imageFile=[];

    if (GetPlatform.isMobile) {
      await Get.bottomSheet(BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('Pick From Gallery'),
              onTap: () async {
                imageFile = await ImagePicker().pickMultiImage();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Pick From Camera'),
              onTap: () async {
                XFile? x = await ImagePicker().pickImage(
                    source: ImageSource.camera);

                print("=====X vakye=====$x");
                if(x != null){
                  print("NOT EMPTY: ========================= ======== ============= =============");
                  imageFile!.add(x);
                }

                Get.back();
              },
            ),
            SizedBox(height: 0,)

          ],
        ),
      ));
      return imageFile;
    }
    return null;
  }
}