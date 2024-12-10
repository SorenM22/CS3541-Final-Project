// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/date_symbol_data_local.dart';
import '../Presenter/interview_presenter.dart';

import '../Presenter/calendar_presenter.dart';





class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  InterviewManager man = InterviewManager();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) async {
                    if (!isSameDay(_selectedDay, selectedDay)) {

                      String companyName = '';

                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Company Name'),
                          content: const Text('Enter the name of the company your interview is with.'),
                          actions: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    onChanged: (text) {
                                      companyName = text;
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints.tight(Size(150,50)),
                                      border: OutlineInputBorder(),
                                      hintText: 'Company Name',

                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context, 'CANCEL');
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                          child: const Text('CANCEL'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if(companyName.isEmpty) {
                                              Navigator.pop(context, 'OK');
                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('Missing Company Name'),
                                                  content: const Text('You must include a company name to create an interview.'),
                                                  actions: <Widget>[
                                                    Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context, 'OK'),
                                                            style: TextButton.styleFrom(
                                                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                                            ),
                                                            child: const Text('OK'),
                                                          ),
                                                        ]
                                                    )
                                                  ],
                                                ),
                                              );
                                            } else {
                                              Navigator.pop(context, 'OK');
                                              TimeOfDay? time = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: ThemeData.light().copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          onSurface: Theme.of(context).colorScheme.onPrimary,
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  }



                                              );
                                              man.newInterview(selectedDay, time, companyName);
                                              setState(() {});
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                          ),
                                          child: const Text('OK'),
                                        ),
                                      ]
                                  )
                                ]
                            ),
                          ],
                        ),
                      );
                      setState(() {

                        //_selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    _focusedDay = focusedDay;
                  },
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: man.getLength(),
                    itemBuilder: (context, index) => man.interviewList[index]
                ),
              ]
          )
      )

    );
  }
}





void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
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
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    child: Text('Basics'),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Calendar() ),
                    ),
                  ),
                ]
            )
        )
    );
  }
}