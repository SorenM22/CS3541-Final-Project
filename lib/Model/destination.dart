import 'package:final_ctrl_alt_defeat/View/GoalPage.dart';
import 'package:final_ctrl_alt_defeat/View/SearchPage.dart';
import 'package:final_ctrl_alt_defeat/View/calendar.dart';
import 'package:final_ctrl_alt_defeat/View/csv_read_test.dart';
import 'package:final_ctrl_alt_defeat/View/listingComparePage.dart';
import 'package:final_ctrl_alt_defeat/View/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../View/GoalPage.dart';

enum Destination {
  home,
  goals,
  calendar,
  searchListings,
  compareListings,
  settings,
  trends;

  String get route {
    return '/${describeEnum(this)}';
  }

  Widget get widget {
    switch (this) {
      case Destination.home:
        return const Center(child: Text("Start with one of the databases selected"));
      case Destination.goals:
        return GoalPage();
      case Destination.calendar:
        return Calendar();
      case Destination.searchListings:
        return const SearchPage();
      case Destination.compareListings:
        return const ListingComparePage();
      case Destination.trends:
        return const Text("Trends");
      case Destination.settings:
        return const SettingsPage();
    }
  }

  static GetPageRoute getPage(RouteSettings settings) {
    var destination = Destination.values.firstWhereOrNull((e) => e.route == settings.name);
    return GetPageRoute(page: () => destination?.widget ?? Container());
  }
}