import 'dart:ffi';

import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/rows.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:final_ctrl_alt_defeat/Presenter/csv_reader.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchBarPresenter = SearchBarPresenter.instance;
  var csvReader = csv_reader();
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
      body: FutureBuilder(
          future: csvReader.searchEngineerSalarybyFilter(null,null,null,searchBarPresenter.getLatestSearch()),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              List<List> jobs = snapshot.data!;

              jobs.sort((row1,row2) {
                var posting1 = JobPosting.fromRow(row1);
                var posting2 = JobPosting.fromRow(row2);
                return posting1.salary.compareTo(posting2.salary);
              });

              return Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final row = jobs[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Text(
                        row.join(', '),
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              );
            }
            return const Text("Search By Job Title",textAlign: TextAlign.center,);
          }
      ),
    );
  }
}
