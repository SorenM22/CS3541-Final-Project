import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Model/session_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/destination.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final auth = Get.put(AuthenticationRepository());

  void navToHome() => Get.toNamed(Destination.home.route, id: 1);
  void navToGoals() => Get.toNamed(Destination.goals.route, id: 1);
  void navToCalendar() => Get.toNamed(Destination.calendar.route, id: 1);
  void changeToListings() {
    var sessionData = SessionData();
    sessionData.searchContent = SearchContent.listings;
  }
  void changeToTrends() {
    var sessionData = SessionData();
    sessionData.searchContent = SearchContent.trends;
  }
  void playSound() {
    print("Playing sounds");
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
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Destination.home.route,
        onGenerateRoute: (settings) => Destination.getPage(settings),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: changeToListings,
              icon: Icon(Icons.list),
              label: const Text("Listings"),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
            TextButton.icon(
                onPressed: changeToTrends,
                icon: Icon(Icons.trending_up),
                label: const Text("Trends"),
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Home"),
              onTap: navToHome,
            ),
            ListTile(
              title: Text("Goals"),
              onTap: navToGoals,
            ),
            ListTile(
              title: Text("Calendar"),
              onTap: navToCalendar,
            ),
            ListTile(
              title: Text("Sound"),
              onTap: playSound,
              // onTap: clickedSound,
            )
          ],
        ),
      ),
    );
  }
}
