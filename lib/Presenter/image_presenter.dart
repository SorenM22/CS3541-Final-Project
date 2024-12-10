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
    return model.imagePaths.map((path) {
      return GestureDetector(
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
      );
    }).toList();
  }
}
