import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/GetController.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: GetBuilder<Controller>(
                init: Controller(),
                builder: (_) => Text('${_.count}')
            ),
          ),
        ],
      )
    );
  }
}