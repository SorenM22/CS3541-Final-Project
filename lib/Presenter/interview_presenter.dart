
import 'package:flutter/material.dart';

import '../view/interview.dart';

class InterviewManager {

  List<Interview> interviewList = [];

  InterviewManager();

  void addInterview(DateTime time, String company) {
    interviewList.add(Interview(time, company));
    interviewList.sort((a,b) => a.time.compareTo(b.time));

  }

  int getLength() {
    return interviewList.length;
  }

  void newInterview(DateTime? date, TimeOfDay? time, String company) {
    DateTime interviewTime = DateTime(date!.year, date.month, date.day, time!.hour, time.minute);
    interviewList.add(Interview(interviewTime, company));
    interviewList.sort((a,b) => a.time.compareTo(b.time));
  }

}