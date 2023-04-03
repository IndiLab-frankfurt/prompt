import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/plan_timing.dart';
import 'package:provider/provider.dart';

class OnboardingPlanTimingScreen extends StatefulWidget {
  const OnboardingPlanTimingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingPlanTimingScreenState createState() =>
      _OnboardingPlanTimingScreenState();
}

class _OnboardingPlanTimingScreenState
    extends State<OnboardingPlanTimingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: [
          UIHelper.verticalSpaceMedium,
          MarkdownBody(data: S.of(context).planTimingParagraph1),
          UIHelper.verticalSpaceMedium,
          MarkdownBody(
            data: S.of(context).planTimingParagraph2,
          ),
          UIHelper.verticalSpaceMedium,
          ChangeNotifierProvider.value(
            value: vm.planTimingViewModel,
            builder: (context, child) => PlanTiming(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
