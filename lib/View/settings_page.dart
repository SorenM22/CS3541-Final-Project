import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/csv_reader.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Model/destination.dart';
import 'package:audioplayers/audioplayers.dart';

import '../Model/image_model.dart';
import '../Presenter/image_presenter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  void navToNotification() => Get.toNamed(Destination.notification.route, id: 1);
  void navToAbout() => Get.toNamed(Destination.about.route, id: 1);
  void navToPrivacySecurity() => Get.toNamed(Destination.privacyAndSecurity.route, id: 1);
  void navToAppearance() => Get.toNamed(Destination.appearance.route, id: 1);
  void navToAccount() => Get.toNamed(Destination.account.route, id: 1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            subtitle: const Text('Manage your account settings'),
            onTap: navToAccount
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Customize your notification preferences'),
            onTap: navToNotification
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy & Security'),
            subtitle: const Text('Manage privacy and security settings'),
            onTap: navToPrivacySecurity
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Appearance'),
            subtitle: const Text('Customize the app appearance'),
            onTap: navToAppearance
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Learn more about the app'),
            onTap: navToAbout
          ),
        ],
      ),
    );
  }
}
