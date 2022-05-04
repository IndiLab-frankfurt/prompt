import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/internalisation/internalisation_screen.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_view_model.dart';
import 'package:provider/provider.dart';

class PlanCreationScreen extends StatefulWidget {
  final OnCompletedCallback? onCompleted;
  PlanCreationScreen({Key? key, this.onCompleted}) : super(key: key);

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
    var vm = Provider.of<PlanViewModel>(context, listen: false);
    _textControllerIfPart.text = vm.getIfPart(vm.plan);
    _textControllerThenPart.text = vm.getThenPart(vm.plan);
  }

  Widget buildEnterHabit() {
    return ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(data: '### Wenn'),
      buildIfPart(),
      UIHelper.verticalSpaceSmall(),
      MarkdownBody(data: '### dann lerne ich Vokabeln!'),
    ]);
  }

  buildIfPart() {
    var vm = Provider.of<PlanViewModel>(context);
    return TextField(
        controller: _textControllerIfPart,
        onChanged: (newText) {
          var fullPlan = vm.getFullPlanFromIfPart(newText);
          vm.plan = fullPlan;

          widget.onCompleted?.call(fullPlan);
        },
        decoration: new InputDecoration(hintText: '...'),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }

  buildThenPart() {
    var vm = Provider.of<PlanViewModel>(context);
    return TextField(
        controller: _textControllerThenPart,
        onChanged: (newText) {
          var fullPlan = "Wenn ${_textControllerIfPart.text} dann $newText";
          vm.plan = fullPlan;

          widget.onCompleted?.call(fullPlan);
        },
        decoration: new InputDecoration(hintText: '...'),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ));
  }
}
