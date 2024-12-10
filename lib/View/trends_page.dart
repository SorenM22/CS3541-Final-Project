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
  bool selectedValue = true; // Selected value for the radio button group
  var searchBarPresenter = SearchBarPresenter.instance;

  List<List<dynamic>> salaryByCountry = [];
  Future<void> getBestJobSalary() async {
    print(searchBarPresenter.getLatestSearch());
    if(searchBarPresenter.getLatestSearch().isEmpty){
      salaryByCountry = await reader.findBestJobSalary(null, "Data Engineer", context);
    } else {salaryByCountry = await reader.findBestJobSalary(null, searchBarPresenter.getLatestSearch(), context);}
  }

  List<List<dynamic>> companySizePattern = [];
  Future<void> getCompanySizeSalaryPattern() async {
    companySizePattern = await reader.findCompanySizeSalaryPattern(context);
  }

  @override
  void initState() {
    super.initState();
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
              onPressed: () async {
                await getBestJobSalary();
                setState(() {
                  selectedValue = true;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text(
                "Salary",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10), // Add spacing between buttons
            TextButton(
              onPressed: () async {
                await getCompanySizeSalaryPattern();
                setState(() {
                  selectedValue = false;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text(
                "Size",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: FutureBuilder(
                builder: (context, snapshot) {

                  final trends = selectedValue == false
                      ? salaryByCountry
                      : companySizePattern;
              return Row(
                children:[
                  Expanded(flex: 1, child: scrollableList(trends))
                ]
              );

                  /*return ListView.builder(
                    shrinkWrap: false,
                    itemCount: selectedValue == false
                        ? salaryByCountry.length
                        : companySizePattern.length,
                    itemBuilder: (context, index) {



                        /*ListView.builder(
                        shrinkWrap: false,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return TrendWidget(country: trends[index] as String, bestSalary: trends[index] as String);
                        },
                      );*/
                    },
                  );*/
                },
                future: getBestJobSalary(),
              ),
            ),
          ],
        ),
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
  // print(data);

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
