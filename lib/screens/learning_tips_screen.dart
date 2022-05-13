import 'package:flutter/material.dart';
import 'package:prompt/data/learning_tips.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class LearningTipsScreen extends StatelessWidget {
  const LearningTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: UIHelper.defaultBoxDecoration,
      child: Scaffold(
          appBar: PromptAppBar(showBackButton: true),
          drawer: PromptDrawer(),
          body: Container(
              padding: UIHelper.getContainerPadding(),
              child: ListView(children: buildTips(context)))),
    );
  }

  buildTips(BuildContext context) {
    List<Widget> tipWidgets = [
      UIHelper.verticalSpaceMedium(),
      Text("Hier sind ein paar Lerntipps für dich:",
          style: TextStyle(fontSize: 20)),
      UIHelper.verticalSpaceMedium(),
    ];

    var tips = LearningTips;

    for (var tip in LearningTips) {
      tipWidgets.add(
        Card(
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(15),
            child: ListTile(
              title: Text(tip.title),
              subtitle: Text(tip.learningTip),
            ),
          ),
        ),
      );
    }
    return tipWidgets;
  }
}
