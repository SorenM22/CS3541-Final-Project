
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:statistics/statistics.dart';

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
  Future<Set<String>> retrieveTrendsSettingSet(context) => _retrieveSearchSet(_retrieveJobsCsv,7,context);

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

  Future<List<List<dynamic>>> searchJobsbyFilter(String? workSetting, String? jobCategory, String? location, String? employmentType, context) async {
    List<List<dynamic>> baseCSV = await _retrieveJobsCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    if (workSetting != null) {
      filteredList = filteredList.where((row) => row[7] == workSetting).toList();
    }

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

  Future<double> findBestEngineerSalarybyFilter(String? location, String? companyName, String? jobTitle, context) async {
    List<List<dynamic>> filteredList = await searchEngineerSalarybyFilter(companyName, location, jobTitle, context);

    double maxSalary = filteredList.map((row) => row[6] as double).reduce((currentMax, element) => currentMax > element ? currentMax : element);

    return maxSalary;
  }

  Future<List<List<dynamic>>> findBestJobSalary(String? country, String? jobTitle, context) async{
    List<List<dynamic>> baseCSV = await _retrieveJobsCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    Map<String, List<List<dynamic>>> groupedByCountry = {};

    //Sorts the data from the CSV into groups mapped to the job's country of origin
    for(var row in filteredList){
      String country = row[8];
      if(!groupedByCountry.containsKey(country)){
        groupedByCountry[country] = [];
      }
      groupedByCountry[country]!.add(row);
    }

    // print("grouped by country");

    //Instantiate the result set prior to trying to add to it
    List<List<dynamic>> result = [['Country', 'BestSalary']];

    // print(groupedByCountry.length);

    //Identify the best salary of each coutnry and add it to a list of a list so we have a collection of country, best salary pairs
    for(var entry in groupedByCountry.entries){
      String country = entry.key;
      List<List<dynamic>> rows = entry.value;

      // print("$country, " + rows.length.toString());

      List<List<dynamic>> jobTitleFilteredRows = rows.where((row) => row[2] == jobTitle).toList();

      // print(jobTitleFilteredRows.length);

      if (jobTitleFilteredRows.isNotEmpty){
        String bestSalary = jobTitleFilteredRows.map((row) => row[3] as int).reduce((a,b) => a > b ? a : b).toString();
        
        result.add([country, bestSalary]);
        // print("$country, $bestSalary was added");
      }
    }
    return result;
  }


  Future<List<List<dynamic>>> findCompanySizeSalaryPattern(context) async{
    List<List<dynamic>> baseCSV = await _retrieveJobsCsv(context);
    List<List<dynamic>> filteredCSV = baseCSV.skip(1).toList();

    List<List<dynamic>> result = [['Company Size', 'Maximum Salary', 'Minimum Salary', 'Median', 'Mean', 'Standard Deviation']];

    Map<String, List<List<dynamic>>> groupedByCompanySize = {};

    //Maps all rows of a company size to a collection of that size
    for(var row in filteredCSV){
      String companySize = row[9];
      if(!groupedByCompanySize.containsKey(companySize)){
        groupedByCompanySize[companySize] = [];
      }
      groupedByCompanySize[companySize]!.add(row);
    }

    //Identify statistical numbers for each company size
    for (var entry in groupedByCompanySize.entries){
      String companySize = entry.key;
      List<List<dynamic>> rows = entry.value;
      List<int> salaries = [];

      if (rows.isNotEmpty) {
        for(var row in rows){
          salaries.add(row[3]);
        }

        var stats = salaries.statistics;

        result.add([companySize, stats.max, stats.min, stats.median, stats.mean.toString(), stats.standardDeviation.toStringAsPrecision(2)]);
      }
    }
    return result;
  }
  
}

