import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/ui_helper.dart';

class BackgroundImageContainer extends StatelessWidget {
  final Widget child;
  const BackgroundImageContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var rewardService = locator.get<RewardService>();
    return Container(
        padding: UIHelper.containerPadding,
        decoration: BoxDecoration(
            gradient: rewardService.backgroundColor,
            image: DecorationImage(
                image: AssetImage(rewardService.backgroundImagePath),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter)),
        child: child);
  }
}
