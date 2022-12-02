import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/internalisation/internalisation_screen.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_edit_view_model.dart';
import 'package:prompt/viewmodels/plan_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class PlanEditScreen extends StatefulWidget {
  final OnCompletedCallback? onCompleted;
  PlanEditScreen({Key? key, this.onCompleted}) : super(key: key);

  @override
  _PlanEditScreenState createState() => _PlanEditScreenState();
}

class _PlanEditScreenState extends State<PlanEditScreen> {
  TextEditingController _textControllerIfPart = new TextEditingController();
  TextEditingController _textControllerThenPart = new TextEditingController();
  late PlanEditViewModel vm;
  late Future<bool> initialize = vm.initialize().then((value) {
    _textControllerIfPart.text =
        vm.planViewModel.getIfPart(vm.planViewModel.plan);
    _textControllerThenPart.text =
        vm.planViewModel.getThenPart(vm.planViewModel.plan);
    return true;
  });

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<PlanEditViewModel>(context);
    return Container(
        decoration: UIHelper.defaultBoxDecoration,
        child: Scaffold(
          appBar: PromptAppBar(showBackButton: true),
          drawer: PromptDrawer(),
          body: FutureBuilder(
              future: initialize,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: UIHelper.containerMargin,
                    child: Column(
                      children: [
                        buildEnterHabit(),
                        Spacer(),
                        _buildSubmitButton()
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildEnterHabit() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      MarkdownBody(
          data: "### " +
              "Hier kannst du deinen Plan nochmal ändern, wenn er dir nicht mehr gefällt."),
      UIHelper.verticalSpaceLarge(),
      MarkdownBody(data: '### Wenn'),
      buildIfPart(),
      UIHelper.verticalSpaceSmall(),
      MarkdownBody(data: '### dann lerne ich Vokabeln!'),
    ]);
  }

  buildIfPart() {
    return TextField(
        controller: _textControllerIfPart,
        onChanged: (newText) {
          var fullPlan = vm.planViewModel.getFullPlanFromIfPart(newText);
          vm.planViewModel.plan = fullPlan;

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

  _buildSubmitButton() {
    var vm = Provider.of<PlanEditViewModel>(context);

    if (vm.state == ViewState.busy) {
      return CircularProgressIndicator();
    }

    return FullWidthButton(
      onPressed: () async {
        await vm.submit();
      },
      text: "Weiter",
    );
  }
}
