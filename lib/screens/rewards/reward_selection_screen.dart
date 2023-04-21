import 'package:flutter/material.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/screens/rewards/timeline.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/models/unlockable_background.dart';

class RewardSelectionScreen extends StatefulWidget {
  RewardSelectionScreen() : super();

  @override
  _RewardSelectionScreenState createState() => _RewardSelectionScreenState();
}

class _RewardSelectionScreenState extends State<RewardSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> unlockItems = [];
    var rewardService = locator<RewardService>();

    var sortedByScore = rewardService.backgrounds.toList()
      ..sort((a, b) => a.cost.compareTo(b.cost));

    for (var bg in sortedByScore) {
      unlockItems.add(_buildUnlockItem(bg, rewardService.scoreValue));
    }

    var progress = rewardService.getRewardProgress(rewardService.scoreValue);

    return Scaffold(
      appBar: PromptAppBar(
        title: "Hintergründe freischalten",
        showBackButton: true,
      ),
      body: Container(
          child: Timeline(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorColorInactive: Colors.grey,
              lineColor: Theme.of(context).primaryColor,
              progress: progress,
              children: [...unlockItems])),
    );
  }

  _buildUnlockItem(UnlockableBackground unlockable, int balance) {
    var rewardService = locator.get<RewardService>();
    var unlocked = balance >= unlockable.cost;
    Widget unlockButton;

    if (unlocked) {
      unlockButton = ElevatedButton(
        onPressed: () {
          setState(() {
            rewardService.setBackgroundImagePath(unlockable.path);

            rewardService.setBackgroundColor(unlockable.backgroundColor);

            Navigator.pushNamed(context, AppScreen.MAINSCREEN.name);
          });
        },
        child: Text("Aktivieren"),
      );
    } else {
      String text = "";
      var daysToUnlock = unlockable.cost - balance;
      text = "Noch $daysToUnlock 💎";

      unlockButton = ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        onPressed: () {
          setState(() {});
        },
        child: Text(text),
      );
    }

    var isSelected = rewardService.backgroundImagePath == unlockable.path;
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.orange[50],
          boxShadow: [
            BoxShadow(
                blurRadius: .5,
                spreadRadius: 1.0,
                color: Colors.black.withOpacity(.12))
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          if (unlocked)
            Image(
              image: AssetImage(unlockable.path),
              width: 130,
              height: 110,
            ),
          if (!unlocked)
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: Image(
                image: AssetImage(unlockable.path),
                width: 130,
                height: 110,
              ),
            ),
          if (isSelected)
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.green[300]),
              onPressed: () {
                setState(() {});
                Navigator.pushNamed(context, AppScreen.MAINSCREEN.name);
              },
              child: Text("Ausgewählt"),
            ),
          if (!isSelected) unlockButton
        ],
      ),
    );
  }
}
