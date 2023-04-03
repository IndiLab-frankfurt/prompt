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
              image: AssetImage("assets/illustrations/mascot_1_bookpillar.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter)),
      child: Column(
        children: [
          Text(
            S.of(context).welcome,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          UIHelper.verticalSpaceMedium,
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor.withOpacity(0.9),
              border: Border.all(color: Color(0xFF000000), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Text(
              S.of(context).introductionTakeYourTime,
              style: Theme.of(context).textTheme.titleMedium,            ),
          ),
        ],
      ),
    );
  }
}
