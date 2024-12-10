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

  List<List<dynamic>> salaryByCountry = [];
  Future<void> getBestJobSalary() async {
    salaryByCountry = await reader.findBestJobSalary(null, null, context);
  }

  List<List<dynamic>> companySizePattern = [];
  Future<void> getCompanySizeSalaryPattern() async {
    companySizePattern = await reader.findCompanySizeSalaryPattern(context);
  }

  @override
  void initState() {
    super.initState();
    getBestJobSalary();
    getCompanySizeSalaryPattern();
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
              onPressed: () {
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
              onPressed: () {
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
            Expanded(
              child: FutureBuilder(
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: selectedValue == false
                        ? salaryByCountry.length
                        : companySizePattern.length,
                    itemBuilder: (context, index) {
                      final trends = selectedValue == false
                          ? salaryByCountry
                          : companySizePattern;
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return TrendWidget(country: trends[index] as String, bestSalary: trends[index] as String);
                        },
                      );
                    },
                  );
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
