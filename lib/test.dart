import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';

import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
          body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlaButton(
              type: ButtonType.primary,
              text: "test primary",
              onPressed: () {
                print("test primary");
              },
            ),
            const SizedBox(
              height: 12,
            ),
            BlaButton(
              type: ButtonType.secondary,
              text: "test secondary",
              onPressed: () {
                print('test secondary');
              },
            ),
            const SizedBox(
              height: 12,
            ),
            BlaButton(
              icon: Icons.access_alarm,
              text: "test primary with icon",
              onPressed: () {
                print('test primary with icon');
              },
            ),
          ],
        ),
      )),
    );
  }
}
