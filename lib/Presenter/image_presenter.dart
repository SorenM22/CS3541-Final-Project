import 'package:flutter/material.dart';
import 'package:final_ctrl_alt_defeat/Model/image_model.dart';

class ImagePickerPresenter {
  final ImageModel model;
  final ValueNotifier<String> selectedImagePathNotifier = ValueNotifier<String>('');

  ImagePickerPresenter(this.model);

  void pickImage(String imagePath) {
    selectedImagePathNotifier.value = imagePath;
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
