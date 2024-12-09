import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'csv_reader.dart';

enum SuggestionType {jobsTitle,jobsCities,trendsCategory,trendsCountries,none}

class SearchBarPresenter extends GetxController {
  static SearchBarPresenter get instance => Get.find();
  SearchController searchBarController = SearchController();

  SuggestionType activeSuggestionsType = SuggestionType.jobsTitle;

  Future<List<String>> getActiveSuggestions(String filter_text,context) async {
    var csvReader = csv_reader();
    Set<String> searchSet;

    switch(activeSuggestionsType){
      case SuggestionType.jobsTitle:
        searchSet = await csvReader.retrieveJobsTitlesSet(context);
      case SuggestionType.jobsCities:
        searchSet = await csvReader.retrieveJobsCitiesSet(context);
      case SuggestionType.trendsCategory:
        searchSet = await csvReader.retrieveTrendsCategorySet(context);
      case SuggestionType.trendsCountries:
        searchSet = await csvReader.retrieveTrendsCountrySet(context);
      case SuggestionType.none:
        return [];
    }

    return searchSet.where((String suggestion) =>
        suggestion.toLowerCase().contains(filter_text.toLowerCase())).toList();
  }
}