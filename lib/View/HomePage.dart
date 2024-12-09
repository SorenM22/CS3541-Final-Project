import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/HomePageController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(
      controller.listingsPicked.value ? "This is Listings" : "This is Trends",
    ));
  }
}
