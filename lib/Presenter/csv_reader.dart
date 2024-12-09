
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

  Future<Set<String>> _retrieveSearchSet(csvCallable ,int setTypeIndex, context) async {
    List<List<dynamic>> baseCSV = await csvCallable(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    Set<String> searchSet = {};
    for (var row in filteredList) {
      searchSet.add(row[setTypeIndex].toString());
    }

    return searchSet;
  }

  Future<Set<String>> retrieveJobsTitlesSet(context) => _retrieveSearchSet(_retrieveEngineerCsv,2,context);
  Future<Set<String>> retrieveJobsCitiesSet(context) => _retrieveSearchSet(_retrieveEngineerCsv,3,context);
  Future<Set<String>> retrieveTrendsCategorySet(context) => _retrieveSearchSet(_retrieveJobsCsv,2,context);
  Future<Set<String>> retrieveTrendsCountrySet(context) => _retrieveSearchSet(_retrieveJobsCsv,8,context);

  Future<List<List<dynamic>>> searchEngineerSalarybyFilter(String? companyName, String? location, String? jobTitle, context) async {
    List<List<dynamic>> baseCSV = await _retrieveEngineerCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    if(companyName != null){
      filteredList = filteredList.where((row) => row[0] == companyName).toList();
    }

    if(location != null){
      filteredList = filteredList.where((row) => row[3] == location).toList();
    }

    if(jobTitle != null){
      filteredList = filteredList.where((row) => row[2] == jobTitle).toList();
    }

    return filteredList;
  }

  Future<List<List<dynamic>>> searchJobsbyFilter(String workSetting, String? jobCategory, String? location, String? employmentType, context) async {
    List<List<dynamic>> baseCSV = await _retrieveJobsCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    //Searching according to a work_setting, required attribute
    filteredList = filteredList.where((row) => row[7] == workSetting).toList();

    if(jobCategory != null){
      filteredList = filteredList.where((row) => row[2] == jobCategory).toList();
    }

    if(location != null){
      filteredList = filteredList.where((row) => row[8] == location).toList();
    }

    if(employmentType != null){
      filteredList = filteredList.where((row)=> row[6] == employmentType).toList();
    }

    return filteredList;
  }
  
}

