import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UIHelper.getContainerMargin(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_bare.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter)),
      child: Column(
        children: [
          Text(
            "Willkommen bei PROMPT!",
            style: Theme.of(context).textTheme.headline4,
          ),
          UIHelper.verticalSpaceMedium(),
          Text(
            "Auf der nächsten Seite geben wir dir erst einmal eine Einführung. Nimm dir dafür ein paar Minuten Zeit.",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
