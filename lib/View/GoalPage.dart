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
          title: Text("Enter your goal", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
          content: TextField(
            controller: goalController,
            decoration: InputDecoration(hintText: "Enter your goal"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Submit", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
              onPressed: () {
                setState(() {
                  _goals.add(goalController.text); // Add goal to the array
                });
                goalController.clear();
                Navigator.of(context).pop();
              },
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Goals", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Your Goals",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.onSecondary),
          onPressed: onDelete, // Invoke delete callback
        ),
      ],
    );
  }
}
