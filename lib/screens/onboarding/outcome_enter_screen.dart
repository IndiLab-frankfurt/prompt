import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/onboarding_container.dart';

class OutcomeEnterScreen extends StatefulWidget {
  OutcomeEnterScreen({Key? key}) : super(key: key);

  @override
  _OutcomeEnterScreenState createState() => _OutcomeEnterScreenState();
}

class _OutcomeEnterScreenState extends State<OutcomeEnterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bgimg = "assets/illustrations/mascot_1_thoughtbubble.png";

    return OnboardingContainer(
      decorationImage: DecorationImage(
          image: AssetImage(bgimg),
          fit: BoxFit.none,
          scale: 6,
          alignment: Alignment.bottomCenter),
      child: ListView(
        children: [
          MarkdownBody(data: S.of(context).outcomeEnterP1),
          UIHelper.verticalSpaceMedium,
          TextField(
              minLines: 3,
              maxLines: null,
              onChanged: (text) {
                // vm.planInputViewModelOutcome.input = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                helperText: S.of(context).obstacleOutcomeHelperText,
              )),
        ],
      ),
    );
  }
}
