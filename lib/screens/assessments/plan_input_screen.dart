import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_prompt_view_model.dart';
import 'package:prompt/widgets/plan_input.dart';
import 'package:provider/provider.dart';

class PlanInputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<PlanPromptViewModel>(context);
    return Container(
        child: ListView(children: [
      MarkdownBody(data: "### " + AppLocalizations.of(context)!.planInputP1),
      UIHelper.verticalSpaceMedium,
      PlanInput(
        plan: vm.plan,
        onChanged: (newText) {
          vm.plan = "Wenn ich " + newText + ", dann lerne ich mit cabuu!";
        },
      )
    ]));
  }
}
