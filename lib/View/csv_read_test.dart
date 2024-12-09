import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

Future<void> main() async {
  runApp(const CsvComparisonApp());
}

class CsvComparisonApp extends StatefulWidget {
  const CsvComparisonApp({super.key});

  @override
  State<CsvComparisonApp> createState() => _CsvComparisonAppState();
}

class _CsvComparisonAppState extends State<CsvComparisonApp> {
  List<List<dynamic>>? csvDataTop;
  List<List<dynamic>>? csvDataBottom;

  Future<List<List<dynamic>>> loadCsv(String path) async {
    try {
      String result = await DefaultAssetBundle.of(context).loadString(path);
      return const CsvToListConverter().convert(result);
    } catch (e) {
      debugPrint("Error loading CSV file at $path: $e");
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCsvData();
  }

  Future<void> _loadCsvData() async {
    csvDataTop = await loadCsv("Assets/processed_Software_Engineer_Salary.csv");
    csvDataBottom = await loadCsv("Assets/processed_Software_Engineer_Salary.csv");
    setState(() {});
  }

  Widget buildScrollableList(List<List<dynamic>>? data) {
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final row = data[index];
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("CSV Data Comparison"),
        ),
        body: Column(
          children: [

            // Top scrollable widget
            Expanded(
              flex: 1,
              child: buildScrollableList(csvDataTop),
            ),
            const Divider(),

            // Bottom scrollable widget
            Expanded(
              flex: 1,
              child: buildScrollableList(csvDataBottom),
            ),
          ],
        ),
      ),
    );
  }
}
