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

    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
    setState(() {
      vm.getNextTask();
    });
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
                                      if (vm.startTomorrow)
                                        _buildStartTomorrow(),
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
    var nextVocab = vm.daysUntilVocabTestString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpaceMedium(),
        Text(AppStrings.daysOfTotal(vm.daysActive, vm.getMaxStudyDays())),
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
        // Text(AppStrings.progressToReward(vm.daysActive, daysToNextReward)),
        // UIHelper.verticalSpaceSmall(),
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            color: Colors.blue,
            minHeight: 12,
            value: (9 - vm.daysUntilVocabTest()) / 9,
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
            Text("Denk dran, heute in cabuu den Test zu machen."),
            OutlinedButton(
              onPressed: () async {
                setState(() {});
              },
              child: Text(
                "Drücke hier, wenn du damit fertig bist.",
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

  _buildStartTomorrow() {
    return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(10),
        child: OutlinedButton(
          onPressed: () async {},
          child: Text(
            "Morgen geht es richtig los",
            style: TextStyle(color: Colors.black),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.orange[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              side: BorderSide(width: 1.0, color: Colors.grey)),
        ));
  }

  _buildToNextTaskButton() {
    return Container(
        width: double.infinity,
        height: 80,
        margin: EdgeInsets.all(10),
        child: OutlinedButton(
          onPressed: () async {
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
}
