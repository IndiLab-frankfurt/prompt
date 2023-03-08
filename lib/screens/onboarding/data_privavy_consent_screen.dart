import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/widgets/data_privacy_info.dart';
import 'package:prompt/widgets/speech_bubble.dart';
import 'package:provider/provider.dart';

class DataPrivacyConsentScreen extends StatefulWidget {
  const DataPrivacyConsentScreen({super.key});

  @override
  State<DataPrivacyConsentScreen> createState() =>
      _DataPrivacyConsentScreenState();
}

class _DataPrivacyConsentScreenState extends State<DataPrivacyConsentScreen> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<OnboardingViewModel>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        SpeechBubble(
          text: AppLocalizations.of(context)!.consent_readthis,
        ),
        UIHelper.verticalSpaceMedium,
        ...DataPrivacyInfo.getConsentText(context),
        UIHelper.verticalSpaceMedium,
        CheckboxListTile(
          title: Text(AppLocalizations.of(context)!.consent_study),
          value: vm.consented,
          onChanged: (newValue) {
            vm.consented = newValue!;
          },
          controlAffinity: ListTileControlAffinity.leading,
        )
      ],
    );
  }
}
