import 'package:flutter/material.dart';
import 'package:final_ctrl_alt_defeat/Model/image_model.dart';

import '../Model/user_repository.dart';

class ImagePickerPresenter {
  final ImageModel model;
  final ValueNotifier<String> selectedImagePathNotifier = ValueNotifier<String>('');

  ImagePickerPresenter(this.model);

  void pickImage(String imagePath) {
    selectedImagePathNotifier.value = imagePath;
  }
  Future<void> fetchProfileImageFromDatabase() async {
    try {
      String? imagePath = await UserRepository.instance.getProfileImagePath();
      if (imagePath != null && imagePath.isNotEmpty) {
        selectedImagePathNotifier.value = imagePath;
      } else {
        selectedImagePathNotifier.value = 'Assets/bridgeTest.jpg';
      }
    } catch (e) {
      print("Error fetching profile image path: $e");
      selectedImagePathNotifier.value = 'Assets/bridgeTest.jpg';
    }
  }

  List<Widget> getImageOptions(BuildContext context, Function onImageSelected) {
    List<Widget> imageWidgets = [];

    for (int i = 0; i < model.imagePaths.length; i++) {
      String path = model.imagePaths[i];

      imageWidgets.add(
        GestureDetector(
          onTap: () {
            pickImage(path);
            onImageSelected();
          },
          child: Image.asset(
            path,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
      if (i < model.imagePaths.length - 1) {
        imageWidgets.add(SizedBox(height: 10));
      }
    }

    return imageWidgets;
  }
}
