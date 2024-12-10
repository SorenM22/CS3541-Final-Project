import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var notificationsEnabled = true.obs;
  var silentModeEnabled = false.obs;
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active),
            title: const Text('Enable Notifications'),
            subtitle: const Text('Toggle to receive notifications'),
            trailing: Obx(() {
              return Switch(
                value: controller.notificationsEnabled.value,
                onChanged: (value) {
                  controller.notificationsEnabled.value = value;
                  Get.snackbar(
                    'Notification Status',
                    value ? 'Notifications Enabled' : 'Notifications Disabled',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
