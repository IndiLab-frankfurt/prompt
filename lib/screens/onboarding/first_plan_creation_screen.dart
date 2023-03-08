import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/plan_input.dart';
import 'package:provider/provider.dart';

class FirstPlanCreationScreen extends StatefulWidget {
  FirstPlanCreationScreen({Key? key}) : super(key: key);

  @override
  _FirstPlanCreationScreenState createState() =>
      _FirstPlanCreationScreenState();
}

class _FirstPlanCreationScreenState extends State<FirstPlanCreationScreen> {
  TextEditingController _habitTextController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _habitTextController.text =
        Provider.of<OnboardingViewModel>(context, listen: false)
            .planInputViewModel
            .plan
            .replaceFirst("Wenn ich ", "")
            .replaceFirst(", dann lerne ich mit cabuu!", "");
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context);

    return Container(
        child: ListView(children: [
      MarkdownBody(data: "### " + AppStrings.PlanCreation_LetsCreatePlan),
      UIHelper.verticalSpaceSmall,
      MarkdownBody(
          data: "### " + AppStrings.PlanCreation_PlanCreationExplanation),
      UIHelper.verticalSpaceLarge,
      MarkdownBody(data: "### " + AppStrings.PlanCreation_CompleteThePlan),
      UIHelper.verticalSpaceMedium,
      PlanInput(
        vm: vm.planInputViewModel,
        onChanged: (newText) {},
      ),
    ]));
  }
}
