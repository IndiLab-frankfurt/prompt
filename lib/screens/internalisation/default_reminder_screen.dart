import 'package:flutter/material.dart';

class DefaultReminderScreen extends StatelessWidget {
  const DefaultReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        Text("Denk an dein Ziel:"),
        Text('"Ich will jeden Tag ein paar Vokabeln mit cabuu lernen!"')
      ]),
    );
  }
}
