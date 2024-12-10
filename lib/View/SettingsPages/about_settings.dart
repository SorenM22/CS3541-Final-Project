import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "This is an app made for the final project of CS3541. It was created by Aidan Carlson, Lucas Moen, Soren Mohn, Nathaniel Palme, John Pfenning-Wendt, and Parker Vetter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            Text(
              textAlign: TextAlign.left,
              '\nAuthor of:\n\n'
                  'Software Engineer Jobs & Salaries 2024\n\u2022 Emre Öksüz\n\n'
                  'Jobs and Salaries in Data Science\n\u2022 Hummaam Qaasim',
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onPrimary
              ),
            )
          ],
        ),
      ),
    );
  }
}
