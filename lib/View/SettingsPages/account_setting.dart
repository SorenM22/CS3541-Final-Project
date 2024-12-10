import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ctrl_alt_defeat/Model/user_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/image_presenter.dart';
import 'package:final_ctrl_alt_defeat/Model/image_model.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _MyAccountPage();
}

class _MyAccountPage extends State<AccountPage> {
  final user = Get.put(UserRepository());
  final db = FirebaseFirestore.instance.collection("User_Data");
  late ImagePickerPresenter presenter;
  String selectedImagePath = 'Assets/bridgeTest2.jpg';
  bool isColorPickerActive = false; // No longer needed, removed

  @override
  void initState() {
    super.initState();
    presenter = ImagePickerPresenter(ImageModel());
    presenter.selectedImagePathNotifier.addListener(updateSelectedImage);

    db.doc(user.getCurrentUserUID()).get().then((doc) {
      if (doc.exists && doc.get("Profile Image Path") != null) {
        setState(() {
          selectedImagePath = doc.get("Profile Image Path");
        });
      }
    });
  }

  void showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a Profile Picture'),
          content: SingleChildScrollView(
            child: Column(
              children: presenter.getImageOptions(context, () {
                Navigator.of(context).pop();
              }),
            ),
          ),
        );
      },
    );
  }

  void updateSelectedImage() {
    setState(() {
      selectedImagePath = presenter.selectedImagePathNotifier.value;
    });

    db.doc(user.getCurrentUserUID()).set(
      {
        'ProfileImage': selectedImagePath,
      },
      SetOptions(merge: true),
    );
  }

  @override
  void dispose() {
    presenter.selectedImagePathNotifier.removeListener(updateSelectedImage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Account Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(selectedImagePath),
              child: selectedImagePath.isEmpty
                  ? const Text(
                'P',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              )
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showImagePickerDialog,
              child: Text(
                'Pick an Image',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
