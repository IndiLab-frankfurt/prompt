import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';

class DefaultReminderScreen extends StatelessWidget {
  const DefaultReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        Text(AppStrings.ThinkAboutYourGoal),
        Text('"Ich will jeden Tag ein paar Vokabeln mit cabuu lernen!"')
      ]),
    );
  }
}
