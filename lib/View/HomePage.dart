import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/GetController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  Widget homeContentWindow = Center(child: Text('Home Page Content'));

  void _tappedBottomNavBar(int index) {
    setState(() {
      _selectedPage = index;
      switch (index) {
        case 2:
          homeContentWindow = Center(child: Text('Settings Page'));
          break;
        case 1:
          homeContentWindow = Center(child: Text('History Page'));
          break;
        default:
          homeContentWindow = Center(child: Text('Home Page Content'));
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
      ),
      body: homeContentWindow,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph_rounded), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedPage,
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
        onTap: _tappedBottomNavBar,
      ),
    );
  }
}