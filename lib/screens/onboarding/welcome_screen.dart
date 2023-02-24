import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascot_1_bare.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter)),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.welcome,
            style: Theme.of(context).textTheme.headline4,
          ),
          UIHelper.verticalSpaceMedium,
          Text(
            AppLocalizations.of(context)!.introductionTakeYourTime,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }
}
