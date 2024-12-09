import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListingComparePage extends StatefulWidget {
  const ListingComparePage({super.key});

  @override
  State<StatefulWidget> createState() => _ListingComparePageState();
}

class _ListingComparePageState extends State<ListingComparePage> {
  List<List<dynamic>>? csvDataLeft;
  List<List<dynamic>>? csvDataRight;

  Future<List<List<dynamic>>> loadCsv(String path) async {
    try {
      String result = await DefaultAssetBundle.of(context).loadString(path);
      return const CsvToListConverter().convert(result);
    } catch (e) {
      return [];
    }
  }

  Future<void> loadCsvData() async{
    csvDataLeft = await loadCsv("Assets/processed_Software_Engineer_Salary.csv");
    csvDataRight = await loadCsv("Assets/processed_Software_Engineer_Salary.csv");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCsvData();
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
                      Text(row[0]),
                      Text(row[2].toString()),
                      Text(row[3].toString()),
                      Text(row[5].toString()),
                    ],
                  )
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: scrollableList(csvDataLeft)),
        const VerticalDivider(),
        Expanded(flex: 1, child: scrollableList(csvDataRight))
      ],
    );
  }
}
