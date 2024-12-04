import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const FuturePage(),
            );
          }
          return const MaterialApp();
        }
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePage();
}

class _FuturePage extends State<FuturePage> {
  final databaseReference = FirebaseFirestore.instance.collection('Test');
  var name = "";
  Future<void> getName() async {
    name = databaseReference.doc('test1').id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}