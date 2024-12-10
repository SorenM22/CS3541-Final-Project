import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_ctrl_alt_defeat/Model/ThemeController.dart';

class AppearancePage extends StatelessWidget {
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
        backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Change Theme",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              themeController.isDarkMode.value ? Icons.nightlight_round : Icons.wb_sunny,
              size: 100,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(height: 20),
            Switch(
              value: themeController.isDarkMode.value,
              onChanged: (value) {
                themeController.toggleTheme();
              },
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveThumbColor: Theme.of(context).colorScheme.onSurface,
              inactiveTrackColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            Text(
              themeController.isDarkMode.value ? "Dark Mode" : "Light Mode",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
