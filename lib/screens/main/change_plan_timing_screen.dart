import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_timing_view_model.dart';
import 'package:prompt/widgets/background_image_container.dart';
import 'package:prompt/widgets/plan_timing.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePlanTimingScreen extends StatelessWidget {
  final PlanTimingViewModel vm;
  const ChangePlanTimingScreen({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PromptAppBar(
          showBackButton: true,
        ),
        drawer: PromptDrawer(),
        body: BackgroundImageContainer(
          child: Container(
              child: ListView(children: [
            UIHelper.verticalSpaceMedium,
            Text(
              AppLocalizations.of(context)!.planTimingChangeP1,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ChangeNotifierProvider.value(
                value: vm, builder: (context, child) => PlanTiming()),
            UIHelper.verticalSpaceMedium,
          ])),
        ));
  }
}
