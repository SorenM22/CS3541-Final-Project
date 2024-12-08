
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

class csv_reader {

  Future<List<List<dynamic>>> _retrieveJobsCsv(context) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "Assets/processed_jobs_in_Data.csv",
    );
    return const CsvToListConverter().convert(result, eol: "\n");
  }

  Future<List<List<dynamic>>> _retrieveEngineerCsv(context) async {
    var result = await DefaultAssetBundle.of(context).loadString(
      "Assets/processed_Software_Engineer_Salary.csv",
    );
    return const CsvToListConverter().convert(result, eol: "\n");
  }


  Future<List<List<dynamic>>> searchEngineerSalarybyFilter(String? companyName, String? location, String? minimumSalary , context) async {
    List<List<dynamic>> baseCSV = await _retrieveEngineerCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    if(companyName != null){
      filteredList = filteredList.where((row) => row[0] == companyName).toList();
    }

    if(location != null){
      filteredList = filteredList.where((row) => row[3] == location).toList();
    }

    if(minimumSalary != null){
      filteredList= filteredList.where((row) => row[5] == minimumSalary).toList();
    }

    return filteredList;
  }


}

