import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: UIHelper.getContainerMargin(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/illustrations/mascots_group.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter)),
      child: Column(
        children: [
          Text(
            AppStrings.Welcome_WelcomeToPROMPT,
            style: Theme.of(context).textTheme.headline4,
          ),
          UIHelper.verticalSpaceMedium(),
          Text(
            AppStrings.Welcome_IntroductionTakeYourTime,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
