import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final auth = Get.put(AuthenticationRepository());

  int _selectedPage = 0;
  Widget homeContentWindow = const Center(child: Text('Home Page Content'));

  void say() {
    print("say");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: const Text('Home Page'),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
              color: Colors.white,
            );
          }),
          actions: <Widget>[
            SizedBox(
              width: 300,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
            IconButton(
              onPressed: auth.signout,
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
          ]),
      body: homeContentWindow,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: say,
              icon: Icon(Icons.list),
              label: const Text("Listings"),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
            TextButton.icon(
                onPressed: say,
                icon: Icon(Icons.trending_up),
                label: const Text("Trends"),
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            ListTile(
              title: Text("Goals"),
            ),
            ListTile(
              title: Text("Calendar"),
              // onTap: clickedCalendar,
            ),
            ListTile(
              title: Text("Sound"),
              // onTap: clickedSound,
            )
          ],
        ),
      ),
    );
  }
}
