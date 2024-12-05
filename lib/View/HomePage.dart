import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = Get.put(AuthenticationRepository());

  int _selectedPage = 0;
  Widget homeContentWindow = const Center(child: Text('Home Page Content'));

  void _navigating(int index) {
    setState(() {
      _selectedPage = index;
      switch (index) {
        case 3:
          homeContentWindow = const Center(child: Text('Calendar Page'));
          break;
        case 2:
          homeContentWindow = const Center(child: Text('Goals Page'));
          break;
        case 1:
          homeContentWindow = const Center(child: Text('Trends Page'));
          break;
        case 0:
          homeContentWindow = const Center(child: Text('Listings Page'));
          break;
        default:
          homeContentWindow = const Center(child: Text('Home Page Content'));
          break;
      }
    });
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
            const SizedBox(
              width: 300,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: Colors.white),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Listings'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph_rounded), label: 'Trends'),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        onTap: _navigating,
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
