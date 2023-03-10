import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';
import 'package:prompt/widgets/onboarding_container.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var vm = Provider.of<OnboardingViewModel>(context);

    var bgimg = "assets/illustrations/mascot_1_thoughtbubble.png";

    return OnboardingContainer(
      decorationImage: DecorationImage(
          image: AssetImage(bgimg),
          fit: BoxFit.none,
          scale: 6,
          alignment: Alignment.bottomCenter),
      child: ListView(
        children: [
          MarkdownBody(data: AppLocalizations.of(context)!.outcomeEnterP1),
          UIHelper.verticalSpaceMedium,
          TextField(
              minLines: 3,
              maxLines: null,
              onChanged: (text) {
                vm.planInputViewModelOutcome.input = text;
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                helperText:
                    AppLocalizations.of(context)!.obstacleOutcomeHelperText,
              )),
        ],
      ),
    );
  }
}
