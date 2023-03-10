import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/plan_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstPlanCreationScreen extends StatefulWidget {
  FirstPlanCreationScreen({Key? key}) : super(key: key);

  @override
  _FirstPlanCreationScreenState createState() =>
      _FirstPlanCreationScreenState();
}

class _FirstPlanCreationScreenState extends State<FirstPlanCreationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context);

    return Container(
        child: ListView(children: [
      MarkdownBody(
          data: "### " +
              AppLocalizations.of(context)!.planCreation_letsCreatePlan),
      UIHelper.verticalSpaceSmall,
      MarkdownBody(
          data:
              "### " + AppLocalizations.of(context)!.planCreation_whenAndWhere),
      UIHelper.verticalSpaceLarge,
      MarkdownBody(
          data:
              "### " + AppLocalizations.of(context)!.planCreation_whenAndWhere),
      UIHelper.verticalSpaceMedium,
      PlanInput(
        vm: vm.planInputViewModel,
        onChanged: (newText) {},
      ),
    ]));
  }
}
