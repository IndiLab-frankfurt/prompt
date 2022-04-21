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
  TextEditingController _textControllerIfPart = new TextEditingController();
  TextEditingController _textControllerThenPart = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget childWidget = buildEnterHabit();

    return Container(
      child: childWidget,
    );
  }

  @override
  void initState() {
    super.initState();
    var vm = Provider.of<SessionZeroViewModel>(context, listen: false);
    _textControllerIfPart.text = getIfPart(vm.plan);
    _textControllerThenPart.text = getThenPart(vm.plan);
  }

  String getIfPart(String input) {
    var vm = Provider.of<SessionZeroViewModel>(context, listen: false);
    var ifPartStart = input.indexOf("Wenn");
    var thenPartStart = input.indexOf("dann");
    return vm.plan.substring(ifPartStart + 3, thenPartStart);
  }

  String getThenPart(String input) {
    var vm = Provider.of<SessionZeroViewModel>(context, listen: false);
    var thenPartStart = input.indexOf("dann");
    return vm.plan.substring(thenPartStart + 3, vm.plan.length);
  }

  Widget buildEnterHabit() {
    var vm = Provider.of<SessionZeroViewModel>(context);

    return ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(data: '### _Wenn_'),
      buildIfPart(),
      UIHelper.verticalSpaceSmall(),
      MarkdownBody(data: '### dann lerne ich Vokabeln!'),
      // buildThenPart(),
    ]);
  }

  buildIfPart() {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return TextField(
        controller: _textControllerIfPart,
        onChanged: (newText) {
          var fullPlan = "Wenn $newText dann lerne ich Vokabeln!";
          vm.plan = fullPlan;
        },
        decoration: new InputDecoration(hintText: '...'),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }

  buildThenPart() {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return TextField(
        controller: _textControllerThenPart,
        onChanged: (newText) {
          var fullPlan = "Wenn ${_textControllerIfPart.text} dann $newText";
          vm.plan = fullPlan;
        },
        decoration: new InputDecoration(hintText: '...'),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }
}
