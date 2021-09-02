import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/no_task_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class NoTasksScreen extends StatefulWidget {
  const NoTasksScreen({Key? key}) : super(key: key);

  @override
  _NoTasksScreenState createState() => _NoTasksScreenState();
}

class _NoTasksScreenState extends State<NoTasksScreen>
    with WidgetsBindingObserver {
  late NoTaskViewModel vm = Provider.of<NoTaskViewModel>(context);

  bool _showNextButton = false;

  late Timer updateRegularlyTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      // await showDialogIfNecessary();
    });

    WidgetsBinding.instance!.addObserver(this);

    updateRegularly();
  }

  updateRegularly() {
    updateRegularlyTimer = Timer(Duration(minutes: 5), () {
      setState(() {});
      updateRegularly();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    updateRegularlyTimer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onPaused();
        break;
      case AppLifecycleState.paused:
        onInactive();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  void onResumed() {
    print("on resumed");
    setState(() {});
  }

  void onPaused() {
    print("on paused");
  }

  void onInactive() {
    print("on inactive");
  }

  void onDetached() {
    print("on detached");
  }

  showDialogIfNecessary() async {
    String _title = "";
    String _textReward = "";
    String _textStreak = "";
    String _textTotal = "";

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text(_title),
        content: new Column(
          children: [
            MarkdownBody(data: _textReward),
            UIHelper.verticalSpaceMedium(),
            MarkdownBody(data: _textStreak),
            UIHelper.verticalSpaceMedium(),
            Text(_textTotal)
          ],
        ),
        actions: <Widget>[
          new ElevatedButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<bool> setNextText() async {
    return true;
  }

  _getDrawer() {
    return PromptDrawer();
  }

  _buildToRecallTaskButton() {
    return Container(
      margin: EdgeInsets.all(10),
      child: FullWidthButton(
        onPressed: () async {
          return;
        },
        text: "Weiter zur Aufgabe",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var rewardService = locator.get<RewardService>();
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            decoration: BoxDecoration(
                gradient: rewardService.backgroundColor,
                image: DecorationImage(
                    image: AssetImage(rewardService.backgroundImagePath),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PromptAppBar(showBackButton: true),
                drawer: _getDrawer(),
                body: Container(
                    child: Align(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpaceSmall(),
                            Text(vm.wurst),
                            if (_showNextButton) _buildToRecallTaskButton(),
                            UIHelper.verticalSpaceSmall(),
                            _buildChangeBackgroundButton(),
                            UIHelper.verticalSpaceMedium(),
                            Divider(),
                            _buildStatistics()
                          ],
                        ),
                        alignment: Alignment(0.0, 0.6))))));
  }

  _buildStatistics() {
    var rewardService = locator<RewardService>();

    var daysActive = rewardService.daysActive;
    var streakDays = rewardService.streakDays;

    int maxDays = 36;
    double studyProgress = daysActive / maxDays;

    double nextUnlockProgress = 0;
    int daysToNextReward = 0;
    for (var i = 1; i < (rewardService.backgrounds.length); i++) {
      if (rewardService.backgrounds[i].requiredDays > daysActive) {
        var current = rewardService.backgrounds[i - 1].requiredDays;
        daysToNextReward = rewardService.backgrounds[i].requiredDays;
        var max = daysToNextReward - current;
        var progress = daysActive - current;
        nextUnlockProgress = progress / max;
        break;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.daysParticipated(daysActive)),
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.daysConsecutive(streakDays)),
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.daysOfTotal(daysActive, 36)),
        UIHelper.verticalSpaceSmall(),
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            color: Colors.blue,
            minHeight: 12,
            value: studyProgress,
          ),
        ),
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.progressToReward(daysActive, daysToNextReward)),
        UIHelper.verticalSpaceSmall(),
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            color: Colors.blue,
            minHeight: 12,
            value: nextUnlockProgress,
          ),
        )
      ],
    );
  }

  _buildChangeBackgroundButton() {
    return Container(
        width: 250,
        height: 40,
        child: OutlinedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.ChangeBackground,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
            ),
            onPressed: () async {
              await Navigator.pushNamed(context, RouteNames.REWARD_SELECTION);
              setState(() {});
            }));
  }
}
