import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Presenter/csv_reader.dart';
import '../Presenter/search_bar_presenter.dart';

class TrendsSearchPage extends StatefulWidget {
  const TrendsSearchPage({super.key});

  @override
  State<TrendsSearchPage> createState() => _TrendsSearchPageState();
}

class _TrendsSearchPageState extends State<TrendsSearchPage> {
  var searchBarPresenter = SearchBarPresenter.instance;
  var csvReader = csv_reader();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading:Center(
          child: TextButton.icon(
              onPressed: () {
                setState(() {});
              },
              label: Text("Search",style: Theme.of(context).textTheme.bodyLarge,),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary)
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width,
      ),
      body: FutureBuilder(
          future: csvReader.searchJobsbyFilter(searchBarPresenter.getLatestSearch(), null, null, null, context),
          builder: (context,snapshot) {

            if (snapshot.hasData) {
              List<List> jobs = snapshot.data!;

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
            return const Text("Search by work setting",textAlign: TextAlign.center,);
          }
      ),
    );
  }
  
}