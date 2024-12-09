
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

  Future<double> findBestEngineerSalarybyCity(String location, context) async {
    List<List<dynamic>> baseCSV = await _retrieveEngineerCsv(context);
    List<List<dynamic>> filteredList = baseCSV.skip(1).toList();

    filteredList = filteredList.where((row) => row[3] == location).toList();

    double maxSalary = filteredList.map((row) => row[6] as double).reduce((currentMax, element) => currentMax > element ? currentMax : element);

    return maxSalary;
  }

  Future<List<List<dynamic>>> findBestJobSalary(String? country, String? jobTitle, context) async{
    List<List<dynamic>> baseCSV = await _retrieveEngineerCsv(context);
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

    //Instantiate the result set prior to trying to add to it
    List<List<dynamic>> result = [['Country', 'BestSalary']];


    //Identify the best salary of each coutnry and add it to a list of a list so we have a collection of country, best salary pairs
    for(var entry in groupedByCountry.entries){
      String country = entry.key;
      List<List<dynamic>> rows = entry.value;

      List<List<dynamic>> jobTitleFilteredRows = rows.where((row) => row[1] == jobTitle).toList();

      if (jobTitleFilteredRows.isNotEmpty){
        double bestSalary = jobTitleFilteredRows.map((row) => row[3] as double).reduce((a,b) => a > b ? a : b);
        
        result.add([country, bestSalary]);
      }

    }

    return result;
  }
  
}

