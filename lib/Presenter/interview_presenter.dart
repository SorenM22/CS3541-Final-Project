
import '../view/interview.dart';

class InterviewManager {

  List<Interview> interviewList = [Interview(DateTime.now(), 'a'),
    Interview(DateTime.now(), 'b'),
    Interview(DateTime.now(), 'c')
  ];

  InterviewManager() {

  }

  void addInterview(DateTime time, String company) {
    interviewList.add(Interview(time, company));
    interviewList.sort((a,b) => a.time.compareTo(b.time));
  }

  int getLength() {
    return interviewList.length;
  }

}