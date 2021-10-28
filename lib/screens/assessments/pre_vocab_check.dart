import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:provider/provider.dart';

class PreVocabCheck extends StatefulWidget {
  final DateTime nextVocabDate;
  const PreVocabCheck({Key? key, required this.nextVocabDate})
      : super(key: key);

  @override
  _PreVocabCheckState createState() => _PreVocabCheckState();
}

class _PreVocabCheckState extends State<PreVocabCheck> {
  bool isTestChecked = false;
  bool isLearnPlanCreatedChecked = false;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MorningAssessmentViewModel>(context);

    var isLastTest = vm.getVocabListNumber() >= 6;
    return Container(
        child: ListView(children: [
      UIHelper.verticalSpaceLarge(),
      CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: isTestChecked,
          title: Text("Ich habe den Test gemacht"),
          onChanged: (value) {
            setState(() {
              isTestChecked = value!;
            });

            if (isTestChecked && (isLearnPlanCreatedChecked || isLastTest)) {
              vm.preVocabCompleted = true;
            }
          }),
      UIHelper.verticalSpaceLarge(),
      if (!isLastTest)
        CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: isLearnPlanCreatedChecked,
            title: Text("Ich habe den Lernplan aktiviert"),
            onChanged: (value) {
              setState(() {
                isLearnPlanCreatedChecked = value!;
              });

              if (isTestChecked && (isLearnPlanCreatedChecked || isLastTest)) {
                vm.preVocabCompleted = true;
              }
            }),
    ]));
  }
}
