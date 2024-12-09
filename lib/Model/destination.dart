import 'package:final_ctrl_alt_defeat/View/GoalPage.dart';
import 'package:final_ctrl_alt_defeat/View/csv_read_test.dart';
import 'package:final_ctrl_alt_defeat/View/trends_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../View/GoalPage.dart';

enum Destination {
  home,
  goals,
  calendar,
  listings,
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
        return const Text("Calendar Page");
      case Destination.listings:
        return const CsvComparisonApp();
      case Destination.trends:
        return TrendsPage();
    }
  }

  static GetPageRoute getPage(RouteSettings settings) {
    var destination = Destination.values.firstWhereOrNull((e) => e.route == settings.name);
    return GetPageRoute(page: () => destination?.widget ?? Container());
  }
}