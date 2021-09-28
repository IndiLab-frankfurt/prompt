import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
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
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Checkbox(
          //         tristate: false,
          //         onChanged: (value) {
          //           vm.consented = value!;
          //         },
          //         value: vm.consented),
          //     Flexible(
          //       child: Text(
          //         AppStrings.CabuuLink_WantToParticipate,
          //         style: Theme.of(context).textTheme.subtitle1,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
