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

  @override
  Widget build(BuildContext context) {
    var rewardService = locator.get<RewardService>();
    return WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Container(
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
                    body: FutureBuilder(
                      future: vm.getNextTask(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              child: Align(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      UIHelper.verticalSpaceSmall(),
                                      if (vm.showLearnedWithCabuuButton)
                                        _buildToNextTaskButton(),
                                      if (vm.showVocabularyTestReminder)
                                        _buildVocabTestReminder(),
                                      if (vm.showContinueTomorrowButton)
                                        _buildReturnTomorrowButton(),
                                      UIHelper.verticalSpaceSmall(),
                                      // _buildChangeBackgroundButton(),
                                      UIHelper.verticalSpaceMedium(),
                                      // Divider(),
                                      _buildStatistics()
                                    ],
                                  ),
                                  alignment: Alignment(0.0, 0.6)));
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ))),
          ],
        ));
  }

  _buildStatistics() {
    var rewardService = locator<RewardService>();
    var streakDays = rewardService.streakDays;

    double nextUnlockProgress = 0;
    int daysToNextReward = 0;
    for (var i = 1; i < (rewardService.backgrounds.length); i++) {
      if (rewardService.backgrounds[i].requiredDays > vm.daysActive) {
        var current = rewardService.backgrounds[i - 1].requiredDays;
        daysToNextReward = rewardService.backgrounds[i].requiredDays;
        var max = daysToNextReward - current;
        var progress = vm.daysActive - current;
        nextUnlockProgress = progress / max;
        break;
      }
    }

    var nextVocab = vm.daysUntilVocabTest();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // UIHelper.verticalSpaceMedium(),
        // Text(AppStrings.daysParticipated(daysActive)),
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.daysOfTotal(vm.daysActive, 36)),
        UIHelper.verticalSpaceSmall(),
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            color: Colors.blue,
            minHeight: 12,
            value: vm.studyProgress,
          ),
        ),
        UIHelper.verticalSpaceMedium(),
        Text(nextVocab),
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.progressToReward(vm.daysActive, daysToNextReward)),
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

  _buildVocabTestReminder() {
    return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Denk dran, heute in cabuu den Test zu machen"),
            OutlinedButton(
              onPressed: () async {
                await Navigator.pushNamed(
                    context, RouteNames.ASSESSMENT_MORNING);
                setState(() {});
              },
              child: Text(
                "Drücke hier, wenn du damit fertig bist",
                style: TextStyle(color: Colors.black),
              ),
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.orange[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  side: BorderSide(width: 1.0, color: Colors.grey)),
            ),
          ],
        ));
  }

  _buildToNextTaskButton() {
    return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(10),
        child: OutlinedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, RouteNames.ASSESSMENT_EVENING);
            setState(() {});
          },
          child: Text(
            vm.messageContinueAfterCabuu,
            style: TextStyle(color: Colors.black),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.orange[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              side: BorderSide(width: 1.0, color: Colors.grey)),
        ));
  }

  _buildReturnTomorrowButton() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.all(10),
        child: OutlinedButton(
          onPressed: () async {
            setState(() {});
          },
          child: Text(
            vm.messageContinueTomorrow,
            style: TextStyle(color: Colors.black),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.orange[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              side: BorderSide(width: 1.0, color: Colors.grey)),
        ));
  }

  _buildChangeBackgroundButton() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.all(10),
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
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                side: BorderSide(width: 1.0, color: Colors.grey)),
            onPressed: () async {
              await Navigator.pushNamed(context, RouteNames.REWARD_SELECTION);
              setState(() {});
            }));
  }
}
