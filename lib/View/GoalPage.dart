import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController goalController = TextEditingController();

class GoalPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return GoalState();
  }
}

class GoalState extends State<GoalPage> {
  final List<String> _goals = []; // Array to store goals

  void _showGoalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                "Enter your goal",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
          ),
          content: TextField(
            controller: goalController,
            decoration: InputDecoration(hintText: "Enter your goal"),
          ),
          actions: [
            Column(
              mainAxisSize: MainAxisSize.min, // Minimize column size
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10), // Add spacing between buttons
                    ElevatedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      onPressed: () {
                        setState(() {
                          _goals.add(goalController.text); // Add goal to the array
                        });
                        goalController.clear();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _removeGoal(String goal) {
    setState(() {
      _goals.remove(goal); // Remove goal from the array
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Goals", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  return GoalWidget(
                    name: _goals[index],
                    onDelete: () => _removeGoal(_goals[index]), // Pass callback for deletion
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _showGoalDialog,
              child: Text(
                "Add Goal",
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.onPrimary,
              thickness: 1.0,
            )
          ],
        ),
      ),
    );
  }
}

class GoalWidget extends StatelessWidget {
  final String name;
  final VoidCallback onDelete;

  GoalWidget({super.key, required this.name, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0, // Adds shadow effect
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adds spacing
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Padding inside the card
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Space between text and icon
          children: [
            Text(
              name,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: onDelete, // Invoke delete callback
            ),
          ],
        ),
      ),
    );
  }
}
