import 'package:get/get.dart';
import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:flutter/material.dart';

class loginPresenter extends GetxController {
  static loginPresenter get instance => Get.find();
  final authRepo = Get.put(AuthenticationRepository());

  final email = TextEditingController();
  final password = TextEditingController();

  final isGoogleLoading = false.obs;
  final isLoading = false.obs;


  void logUserIn(String email, String password){

    try {
      isLoading.value = true;
      authRepo.loginWithEmailandPass(email, password);
      isLoading.value = false;
    } catch (e) {
      print ("Error logging in: $e");
    }

    isLoading.value = true;
    authRepo.loginWithEmailandPass(email, password);
    isLoading.value = false;
  }

  Future<void> googleLogin() async {
    try{
      isGoogleLoading.value = true;
      await authRepo.signInWithGoogle();
      isGoogleLoading.value = false;
    } catch (e) {
      isGoogleLoading.value = false;
      print("Failed to log in with google: $e");
    }
  }

}