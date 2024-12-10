import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class Interview extends StatelessWidget {


  DateTime time;
  late String interviewText;


  Interview(this.time , company) {
    String month = time.month.toString();
    String day = time.day.toString();
    String hour = time.hour == 0 ? '12' : (time.hour%12).toString();
    String min = time.minute == 0 ? '00' : time.minute.toString();
    String meridian = time.hour < 12 ? 'am' : 'pm';
    interviewText = '$month/$day: Interview with $company at $hour:$min $meridian';
   }
  
  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0), // Uniform radius
                ),
                child: Center(
                  child: Text(
                      interviewText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              Container(
                height: 10
              )
            ]
    );
  }
}



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  
  DateTime testTime = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TableCalendar Example'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Interview(testTime, 'company')
                ]
            )
        )
    );
  }
}