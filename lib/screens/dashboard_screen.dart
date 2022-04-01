import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  late DashboardViewModel vm = Provider.of<DashboardViewModel>(context);
  Timer? updateRegularlyTimer;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResumed();
    }
  }

  void onResumed() {
    print("on resumed");
    setState(() {
      vm.getNextTask();
    });
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
                                      UIHelper.verticalSpaceLarge(),
                                      UIHelper.verticalSpaceMedium(),
                                      // Divider(),
                                      if (vm.showDaysLearned)
                                        _buildStatistics(),
                                      UIHelper.verticalSpaceMedium(),
                                      if (vm.showDaysLearned)
                                        _buildHabitButton(),
                                      if (vm.showDaysLearned)
                                        _buildTimerButton(),
                                      if (vm.showTimerConfiguration)
                                        _buildTimerConfiguration(),
                                      if (vm.showTimerControls)
                                        _buildTimerControls()
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
    return Column(
      children: [
        UIHelper.verticalSpaceMedium(),
        Text("${AppStrings.Dashboard_daysLearned}:",
            style: TextStyle(fontSize: 20)),
        UIHelper.verticalSpaceSmall(),
        Center(child: Text("${vm.daysActive}", style: TextStyle(fontSize: 30))),
        UIHelper.verticalSpaceMedium(),
        UIHelper.verticalSpaceMedium(),
      ],
    );
  }

  _buildHabitButton() {
    return Container(
      child: ElevatedButton(
        child: Text("Ich habe heute gelernt", style: TextStyle(fontSize: 20)),
        onPressed: () {
          vm.addDaysLearned(1);
        },
      ),
    );
  }

  _buildTimerButton() {
    return Container(
      child: ElevatedButton(
        child: Text("Lernen", style: TextStyle(fontSize: 20)),
        onPressed: () {
          vm.showDaysLearned = false;
          vm.showTimerConfiguration = true;
        },
      ),
    );
  }

  _buildTimerConfiguration() {
    return Container(
      child: Column(
        children: [
          Text("${vm.timerGoal.toInt().toString()} Minuten",
              style: TextStyle(fontSize: 30)),
          Slider(
              value: vm.timerGoal,
              onChanged: (newTimerValue) {
                setState(() {
                  vm.timerGoal = newTimerValue;
                });
              },
              label: "${vm.timerGoal.toInt()}",
              min: 0,
              max: 120),
          UIHelper.verticalSpaceMedium(),
          _buildStartTimerButton()
        ],
      ),
    );
  }

  _buildStartTimerButton() {
    return Container(
      child: ElevatedButton(
        child: Text("Start"),
        onPressed: () {
          vm.showTimerConfiguration = false;
          vm.startTimer(vm.timerGoal);
          vm.showTimerControls = true;
        },
      ),
    );
  }

  _buildTimerControls() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("${vm.timerProgress}", style: TextStyle(fontSize: 30)),
        Center(
            child: Row(
          children: [
            _buildTimerPause(),
            _buildTimeStop(),
          ],
        ))
      ],
    ));
  }

  _buildTimerPause() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.pause),
        onPressed: () {
          vm.pauseTimer();
        },
      ),
    );
  }

  _buildTimeStop() {
    return Container(
      child: IconButton(
        icon: Icon(Icons.stop),
        onPressed: () {
          vm.stopTimer();
          vm.showDaysLearned = true;
          vm.showTimerControls = false;
        },
      ),
    );
  }
}
