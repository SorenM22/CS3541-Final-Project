import 'package:final_ctrl_alt_defeat/View/GoalPage.dart';
import 'package:final_ctrl_alt_defeat/View/SearchPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../View/GoalPage.dart';

enum Destination {
  home,
  goals,
  calendar;

  String get route {
    return '/${describeEnum(this)}';
  }

  Widget get widget {
    switch (this) {
      case Destination.home:
        return const SearchPage();
      case Destination.goals:
        return GoalPage();
      case Destination.calendar:
        return const Text("Calendar Page");
    }
  }

  static GetPageRoute getPage(RouteSettings settings) {
    var destination = Destination.values.firstWhereOrNull((e) => e.route == settings.name);
    return GetPageRoute(page: () => destination?.widget ?? Container());
  }
}