import 'dart:ffi';

import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var searchBarPresenter = SearchBarPresenter.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading:Center(
          child: TextButton.icon(
              onPressed: () {},
              label: Text("Compare View",style: Theme.of(context).textTheme.bodyLarge,),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary)
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
    );
  }
}
