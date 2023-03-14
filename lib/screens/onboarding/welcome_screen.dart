import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';

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
            S.of(context).welcome,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          UIHelper.verticalSpaceMedium,
          Text(
            S.of(context).introductionTakeYourTime,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
