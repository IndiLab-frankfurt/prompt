import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/rewards/timeline.dart';
import 'package:prompt/services/reward_service.dart';
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
    for (var bg in rewardService.backgrounds) {
      unlockItems.add(_buildUnlockItem(bg, rewardService.daysActive));
    }

    return Scaffold(
      appBar: PromptAppBar(
        title: "Wähle einen neuen Hintergrud",
        showBackButton: true,
      ),
      body: Container(
          child: Timeline(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorColorInactive: Colors.grey,
              lineColor: Theme.of(context).primaryColor,
              progress: ((rewardService.daysActive + 5) / 27),
              children: [...unlockItems])),
    );
  }

  _buildUnlockItem(UnlockableBackground unlockable, int daysActive) {
    var rewardService = locator.get<RewardService>();
    var unlocked = daysActive >= unlockable.requiredDays;
    Widget unlockButton;

    if (unlocked) {
      unlockButton = ElevatedButton(
        onPressed: () {
          setState(() {
            rewardService.setBackgroundImagePath(unlockable.path);
            if (unlockable.backgroundColor != null) {
              rewardService.setBackgroundColor(unlockable.backgroundColor);
            }
            Navigator.pop(context);
          });
        },
        child: Text("Aktivieren"),
      );
    } else {
      String text = "";
      var daysToUnlock = unlockable.requiredDays - daysActive;
      if (daysToUnlock == 1) {
        text = "Noch $daysToUnlock Tag alle Aufgaben erledigen";
      } else {
        text = "Noch $daysToUnlock Tage alle Aufgaben erledigen";
      }
      unlockButton = ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.grey),
        onPressed: () {
          setState(() {
            // rewardService.setBackgroundImagePath(path);
          });
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
          // Text(
          //   unlockable.name,
          //   style: Theme.of(context).textTheme.headline6,
          // ),
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
          // Divider(),
          if (isSelected)
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green[300]),
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Ausgewählt"),
            ),
          if (!isSelected) unlockButton
        ],
      ),
    );
  }
}
