import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class PlanCreationScreen extends StatefulWidget {
  PlanCreationScreen({Key? key}) : super(key: key);

  @override
  _PlanCreationScreenState createState() => _PlanCreationScreenState();
}

enum PlanCreationScreenState { enterHabit, selectTime, before, after, neither }

class _PlanCreationScreenState extends State<PlanCreationScreen> {
  TextEditingController _habitTextController = new TextEditingController();

  PlanCreationScreenState _screenState = PlanCreationScreenState.enterHabit;
  @override
  Widget build(BuildContext context) {
    Widget childWidget = buildEnterHabit();

    switch (_screenState) {
      case PlanCreationScreenState.enterHabit:
        childWidget = buildEnterHabit();
        break;
      case PlanCreationScreenState.selectTime:
        childWidget = buildEnterHabit();
        break;
      case PlanCreationScreenState.before:
        // TODO: Handle this case.
        break;
      case PlanCreationScreenState.after:
        // TODO: Handle this case.
        break;
      case PlanCreationScreenState.neither:
        // TODO: Handle this case.
        break;
    }

    return Container(
      child: childWidget,
    );
  }

  Widget buildEnterHabit() {
    return ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceMedium(),
      MarkdownBody(data: '### "Wenn ich'),
      TextField(
          controller: _habitTextController,
          onChanged: (newText) {
            // _habitTextController. = newText;
          },
          decoration:
              new InputDecoration(hintText: 'gib hier deinen Plan ein...'),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          )),
      MarkdownBody(data: '### dann lerne ich mit cabuu."'),
      // ElevatedButton(
      //     onPressed: () {
      //       setState(() {
      //         _screenState = PlanCreationScreenState.selectTime;
      //       });
      //     },
      //     child: Text(AppStrings.Continue))
    ]);
  }

  Widget buildBeforeAfterNo() {
    return ListView(children: [
      Text(_habitTextController.text),
      Text(AppStrings.GotTimeBeforeOrAfter),
      ElevatedButton(
        child: Text(AppStrings.Before),
        onPressed: () {
          setState(() {
            _screenState = PlanCreationScreenState.before;
          });
        },
      ),
      ElevatedButton(
          child: Text(AppStrings.After),
          onPressed: () {
            _screenState = PlanCreationScreenState.after;
          }),
      ElevatedButton(
        child: Text(AppStrings.Neither),
        onPressed: () {
          _screenState = PlanCreationScreenState.neither;
        },
      )
    ]);
  }
}
