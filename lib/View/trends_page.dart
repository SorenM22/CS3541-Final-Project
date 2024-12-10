import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';

import '../Presenter/csv_reader.dart';

class TrendsPage extends StatefulWidget {
  const TrendsPage({super.key});

  @override
  State<TrendsPage> createState() => _TrendsPageState();
}

class _TrendsPageState extends State<TrendsPage> {
  final reader = csv_reader();
  bool isLoading = false;
  bool selectedValue = true;
  var searchBarPresenter = SearchBarPresenter.instance;

  List<List<dynamic>> trends = [];

  Future<void> getBestJobSalary() async {
    setState(() {
      isLoading = true;
    });

    String searchQuery = searchBarPresenter.getLatestSearch();
    trends = await reader.findBestJobSalary(
      null,
      searchQuery.isEmpty ? "Data Engineer" : searchQuery,
      context,
    );

    setState(() {
      isLoading = false;
      selectedValue = true;
    });
  }

  Future<void> getCompanySizeSalaryPattern() async {
    setState(() {
      isLoading = true;
    });

    trends = await reader.findCompanySizeSalaryPattern(context);

    setState(() {
      isLoading = false;
      selectedValue = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: getBestJobSalary,
              style: TextButton.styleFrom(
                backgroundColor: selectedValue
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
              child: const Text(
                "Salary",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: getCompanySizeSalaryPattern,
              style: TextButton.styleFrom(
                backgroundColor: !selectedValue
                    ? Theme.of(context).colorScheme.onPrimary
                    : null,
              ),
              child: const Text(
                "Size",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : trends.isEmpty
          ? Center(
        child: Text(
          'No data available for ${searchBarPresenter.getLatestSearch()}',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: trends.length,
        itemBuilder: (context, index) {
          if (selectedValue) {

            final country = trends[index][0];
            final maxSalary = trends[index][1];

            return ListTile(
              title: Text('Country: $country'),
              subtitle: Text('Max Salary: \$${maxSalary.toString()}'),
            );
          } else {

            final companySize = trends[index][0];
            final maxSalary = trends[index][1];
            final minSalary = trends[index][2];
            final medianSalary = trends[index][3];
            final meanSalary = trends[index][4];
            final standardDeviationSalary = trends[index][5];

            return ListTile(
              title: Text('Company Size: $companySize'),
              subtitle: Text(
                'Max Salary: \$${maxSalary.toString()}\n'
                    'Min Salary: \$${minSalary.toString()}\n'
                    'Median Salary: \$${medianSalary.toString()}\n'
                    'Mean Salary: \$${meanSalary.toString()}\n'
                    'Standard Deviation: \$${standardDeviationSalary.toString()}',
              ),
            );
          }
        },
      ),
    );
  }
}



class TrendWidget extends StatelessWidget {
  final String country;
  final String bestSalary;

  TrendWidget({super.key, required this.country, required this.bestSalary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("in $country highest Salary is $bestSalary", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
      ],
    );
  }
}

Widget scrollableList(List<List<dynamic>>? data) {
  if (data == null) {
    return const Center(child: CircularProgressIndicator());
  }
  print(data);





  return ListView.separated(
      itemCount: data.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final row = data[index];
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    border: Border.all(width: 1)
                ),
                child: Column(
                  children: [
                    Text(row[0].toString()),
                    Text(row[1].toString()),
                  ],
                )
            )
          ],
        );
      });
}

