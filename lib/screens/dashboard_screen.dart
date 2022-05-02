import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
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
      vm.initialize();
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
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    // floatingActionButton: _buildFloatingActionButton(),
                    // bottomNavigationBar: _buildBottomAppBar(),
                    backgroundColor: Colors.transparent,
                    appBar: PromptAppBar(showBackButton: true),
                    drawer: _getDrawer(),
                    body: FutureBuilder(
                      future: vm.initialize(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return _buildBody();
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ))),
          ],
        ));
  }

  _buildBody() {
    return Container(
        margin: UIHelper.getContainerMargin(),
        child: Stack(children: [
          Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // UIHelper.verticalSpaceLarge(),
                  // UIHelper.verticalSpaceMedium(),
                  _buildStatistics(),
                  // UIHelper.verticalSpaceMedium(),
                  // if (vm.showHabitButton)
                  // _buildHabitButton(),
                  // if (vm.showDaysLearned)
                  //   _buildTimerButton(),
                  // _buildTaskList(),
                  // if (vm.showTimerConfiguration)
                  //   _buildTimerConfiguration(),
                  // if (vm.showTimerControls)
                  //   _buildTimerControls()
                  Spacer(),
                  ..._getTasks(),
                  UIHelper.verticalSpaceSmall()
                ],
              ),
              alignment: Alignment(0.0, 0.6)),
          // Align(alignment: Alignment.bottomCenter, child: _buildTaskList())
        ]));
  }

  _buildTaskList() {
    return ListView(children: [
      _buildHabitButton(),
      _buildHabitButton(),
      _buildHabitButton(),
    ]);
  }

  _getTasks() {
    return [
      Container(
          padding: EdgeInsets.all(10),
          child: _buildOutlinedHeader("Deine Aufgaben:")),
      UIHelper.verticalSpaceSmall(),
      _buildToDistributedLearningButton(),
      UIHelper.verticalSpaceSmall(),
      _buildToMentalContrasting(),
      UIHelper.verticalSpaceSmall(),
      if (vm.showHabitButton) _buildHabitButton()
    ];
  }

  _buildOutlinedHeader(String text) {
    return Stack(children: [
      Text("Deine Aufgaben:",
          style: TextStyle(
              fontSize: 22,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.white)),
      Text("Deine Aufgaben:",
          style: TextStyle(fontSize: 22, color: Colors.black))
    ]);
  }

  _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      label: Text('Ich habe heute Vokabeln gelernt'),
      icon: null, // const Icon(Icons.add),
      onPressed: () {},
    );
  }

  _buildToDistributedLearningButton() {
    return FullWidthButton(
      text: "Lerntipp anschauen",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.DISTRIBUTED_LEARNING);
      },
    );
  }

  _buildToMentalContrasting() {
    return FullWidthButton(
      text: "Problemlöser anschauen",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.MENTAL_CONTRASTING);
      },
    );
  }

  _buildBottomAppBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.place_rounded), label: "Planen"),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Lernuhr"),
      ],
    );
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
    return FullWidthButton(
      text: "Vokabeln gelernt",
      onPressed: () {
        vm.addDaysLearned(1);
      },
    );
  }

  _buildToPlanningButton() {
    return Container(
      child: ElevatedButton.icon(
        icon: Icon(Icons.timer),
        label: Text("Planen", style: TextStyle(fontSize: 20)),
        onPressed: () {
          vm.showDaysLearned = false;
          vm.showTimerConfiguration = true;
        },
      ),
    );
  }

  _buildTimerButton() {
    return Container(
      child: ElevatedButton.icon(
        icon: Icon(Icons.timer),
        label: Text("Lernuhr", style: TextStyle(fontSize: 20)),
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
          Text("${vm.timerGoalSeconds.toInt().toString()} Minuten",
              style: TextStyle(fontSize: 30)),
          Slider(
              value: vm.timerGoalSeconds,
              onChanged: (newTimerValue) {
                setState(() {
                  vm.timerGoalSeconds = newTimerValue;
                });
              },
              label: "${vm.timerGoalSeconds.toInt()}",
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
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Row contents horizontally,
          crossAxisAlignment:
              CrossAxisAlignment.center, //Center Row contents vertically,
          children: [
            ElevatedButton(
              child: Text("Start"),
              onPressed: () {
                vm.showTimerConfiguration = false;
                vm.startTimer(vm.timerGoalSeconds * 60);
                vm.showTimerControls = true;
              },
            ),
            ElevatedButton(
              child: Text("Abbrechen"),
              onPressed: () {
                vm.stopTimer();
                vm.showDaysLearned = true;
                vm.showTimerConfiguration = false;
                vm.showTimerControls = false;
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildTimerControls() {
    var minutes = vm.timerProgressSeconds ~/ 60;
    var seconds = vm.timerProgressSeconds % 60;

    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // format the timerprogress float as minutes:seconds
          Text("$minutes:${seconds.toString().padLeft(2, "0")}",
              style: TextStyle(fontSize: 30)),
          Center(
              child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment:
                CrossAxisAlignment.center, //Center Row contents vertically,
            children: [
              _buildTimerPause(),
              _buildTimeStop(),
            ],
          ))
        ],
      ),
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
