
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class csv_reader {

  Future<List<List<dynamic>>> processCsv(context) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "Assets/processed_jobs_in_Data.csv",
    );
    return const CsvToListConverter().convert(result, eol: "\n");
  }


}

