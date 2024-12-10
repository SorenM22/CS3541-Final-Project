import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
            onTap: () {
              // Navigate to Account Settings Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const PlaceholderPage(title: 'Account Settings'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Customize your notification preferences'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const PlaceholderPage(title: 'Notification Settings'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy & Security'),
            subtitle: const Text('Manage privacy and security settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const PlaceholderPage(title: 'Privacy & Security'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Appearance'),
            subtitle: const Text('Customize the app appearance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const PlaceholderPage(title: 'Appearance Settings'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Learn more about the app'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Center(
                    child: Text(
                        textAlign: TextAlign.left,
                        ' Author of:\n\n'
                        'Software Engineer Jobs & Salaries 2024\n\u2022 Emre Öksüz\n\n'
                        'Jobs and Salaries in Data Science\n\u2022 Hummaam Qaasim',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          '$title Page Content Goes Here',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
