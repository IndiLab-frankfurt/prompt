import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/onboarding_container.dart';

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
    var bgimg = "assets/illustrations/mascot_1_ladder.png";
    return OnboardingContainer(
      decorationImage: DecorationImage(
        image: AssetImage(bgimg),
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomCenter,
      ),
      child: ListView(
        children: [
          MarkdownBody(data: "${S.of(context).copingPlanEnterP1}"),
          UIHelper.verticalSpaceMedium,
          TextField(
              minLines: 3,
              maxLines: null,
              onChanged: (text) {
                // vm.planInputViewModelCoping.input = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                labelText: S.of(context).labelTextWriteDownBulletPoints,
                helperText: S.of(context).obstacleOutcomeHelperText,
              )),
        ],
      ),
    );
  }
}
