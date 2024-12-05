import 'package:final_ctrl_alt_defeat/View/HomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
        return const HomePage();
      case Destination.goals:
        return const Text("Goals page");
      case Destination.calendar:
        return const Text("Calendar Page");
    }
  }

  static GetPageRoute getPage(RouteSettings settings) {
    var destination = Destination.values.firstWhereOrNull((e) => e.route == settings.name);
    return GetPageRoute(page: () => destination?.widget ?? Container());
  }
}