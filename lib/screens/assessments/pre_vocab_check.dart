import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:provider/provider.dart';

class PreVocabCheck extends StatefulWidget {
  const PreVocabCheck({Key? key}) : super(key: key);

  @override
  _PreVocabCheckState createState() => _PreVocabCheckState();
}

class _PreVocabCheckState extends State<PreVocabCheck> {
  bool isTestChecked = false;
  bool isLearnPlanCreatedChecked = false;

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<MorningAssessmentViewModel>(context);
    return Container(
        child: ListView(children: [
      UIHelper.verticalSpaceLarge(),
      Checkbox(
          value: isTestChecked,
          onChanged: (value) {
            setState(() {
              isTestChecked = value!;
            });

            if (isTestChecked && isLearnPlanCreatedChecked) {
              vm.preVocabCompleted = true;
            }
          }),
      UIHelper.verticalSpaceLarge(),
      Checkbox(
          value: isLearnPlanCreatedChecked,
          onChanged: (value) {
            setState(() {
              isLearnPlanCreatedChecked = value!;
            });

            if (isTestChecked && isLearnPlanCreatedChecked) {
              vm.preVocabCompleted = true;
            }
          }),
    ]));
  }
}
