import 'package:get/get.dart';

class HomePageController extends GetxController {
  // Reactive variable for listingsPicked
  var listingsPicked = false.obs;

  // Method to toggle the state
  void toggleListings(bool value) {
    listingsPicked.value = value;
  }
}
