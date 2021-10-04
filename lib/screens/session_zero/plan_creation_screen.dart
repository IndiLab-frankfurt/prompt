import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class PlanCreationScreen extends StatefulWidget {
  PlanCreationScreen({Key? key}) : super(key: key);

  @override
  _PlanCreationScreenState createState() => _PlanCreationScreenState();
}

class _PlanCreationScreenState extends State<PlanCreationScreen> {
  TextEditingController _habitTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget childWidget = buildEnterHabit();

    return Container(
      child: childWidget,
    );
  }

  Widget buildEnterHabit() {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(data: '### "Wenn ich'),
      TextField(
          controller: _habitTextController,
          onChanged: (newText) {
            vm.plan = newText;
          },
          decoration: new InputDecoration(hintText: '...'),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      UIHelper.verticalSpaceSmall(),
      MarkdownBody(data: '### , dann lerne ich mit cabuu."'),
      // ElevatedButton(
      //     onPressed: () {
      //       setState(() {
      //         _screenState = PlanCreationScreenState.selectTime;
      //       });
      //     },
      //     child: Text(AppStrings.Continue))
    ]);
  }
}
