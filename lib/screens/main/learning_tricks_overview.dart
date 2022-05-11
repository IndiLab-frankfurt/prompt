import 'package:flutter/material.dart';
import 'package:prompt/screens/main/prompt_single_screen.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';

class LearningTricksOverviewScreen extends StatelessWidget {
  const LearningTricksOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PromptSingleScreen(
      child: ListView(children: [
        UIHelper.verticalSpaceLarge(),
        Text(
          "Hier kannst du dir die ganzen Lerntricks anzeigen lassen.",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        UIHelper.verticalSpaceLarge(),
        buildNavButton(
            context, "Tipps für das Lernen ansehen", RouteNames.LEARNING_TIPS),
        buildNavButton(
            context, "Mache dir einen Plan", RouteNames.LEARNING_TIPS),
        buildNavButton(
            context, "Lerne verteilt", RouteNames.LEARNING_TIPS),
        buildNavButton(
          context, "Überwinde Hindernisse", RouteNames.LEARNING_TIPS),
      ]),
    );
  }

  buildNavButton(BuildContext context, String label, String route) {
    return Container(
      padding: EdgeInsets.all(15),
      height: 80,
      child: (ElevatedButton(
        onPressed: () => {Navigator.pushNamed(context, route)},
        child: Text(label),
      )),
    );
  }
}
