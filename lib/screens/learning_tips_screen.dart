import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';

class LearningTipsScreen extends StatelessWidget {
  const LearningTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(child: ListView(children: buildTips(context))));
  }

  buildTips(BuildContext context) {
    List<Widget> tipWidgets = [];
    for (var tip in LearningTips.entries) {
      tipWidgets.add(
        ListTile(
          title: Text(tip.key),
          subtitle: Text(tip.value),
        ),
      );
    }
    return tipWidgets;
  }
}
