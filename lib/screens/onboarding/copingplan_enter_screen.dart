import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/onboarding_container.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CopingPlanEnterScreen extends StatefulWidget {
  CopingPlanEnterScreen({Key? key}) : super(key: key);

  @override
  _CopingPlanEnterScreenState createState() => _CopingPlanEnterScreenState();
}

class _CopingPlanEnterScreenState extends State<CopingPlanEnterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context, listen: false);
    var bgimg = "assets/illustrations/mascot_1_ladder.png";
    return OnboardingContainer(
      decorationImage: DecorationImage(
        image: AssetImage(bgimg),
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomCenter,
      ),
      child: ListView(
        children: [
          MarkdownBody(
              data: "${AppLocalizations.of(context)!.copingPlanEnterP1}"),
          UIHelper.verticalSpaceMedium,
          TextField(
              minLines: 3,
              maxLines: null,
              onChanged: (text) {
                vm.copingPlan = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                labelText: AppLocalizations.of(context)!
                    .labelTextWriteDownBulletPoints,
              )),
        ],
      ),
    );
  }
}
