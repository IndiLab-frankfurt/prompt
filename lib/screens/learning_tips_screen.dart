import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
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
          body: Container(child: ListView(children: buildTips(context)))),
    );
  }

  buildTips(BuildContext context) {
    List<Widget> tipWidgets = [];
    for (var tip in LearningTips.entries) {
      tipWidgets.add(
        Card(
          child: ListTile(
            title: Text(tip.key),
            subtitle: Text(tip.value),
          ),
        ),
      );
    }
    return tipWidgets;
  }
}
