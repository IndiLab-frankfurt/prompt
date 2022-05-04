import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/habit_toggle_button.dart';
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

  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controllerTopCenter.dispose();
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
          _buildConfettiTop()
          // Align(alignment: Alignment.bottomCenter, child: _buildTaskList())
        ]));
  }

  _getTasks() {
    // return Container(
    //   child: ListView.separated(
    //       shrinkWrap: true,
    //       itemCount: 2,
    //       itemBuilder: (context, index) {
    //         return Expanded(
    //             child: ListView(
    //           children: [
    //             _buildToDistributedLearningButton(),
    //             _buildToMentalContrasting(),
    //           ],
    //           shrinkWrap: true,
    //         ));
    //       },
    //       separatorBuilder: (context, index) => SizedBox(
    //             height: 10,
    //           )),
    // );
    List<Widget> tasks = [];

    if (vm.openTasks.contains(OpenTasks.ViewDistributedLearning)) {
      tasks.add(_buildToDistributedLearningButton());
      tasks.add(UIHelper.verticalSpaceSmall());
    }
    if (vm.openTasks.contains(OpenTasks.ViewMentalContrasting)) {
      tasks.add(_buildToMentalContrasting());
      tasks.add(UIHelper.verticalSpaceSmall());
    }

    return tasks;
  }

  _buildTaskButton({text, required GestureTapCallback onPressed}) {
    return SizedBox(
        width: 300,
        height: 40,
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
              child: Text(text, style: TextStyle(fontSize: 20)),
            ),
          ],
        ));
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
    return _buildTaskButton(
      text: "Lerntipp anschauen",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.DISTRIBUTED_LEARNING);
      },
    );
  }

  _buildToMentalContrasting() {
    return _buildTaskButton(
      text: "Problemlöser anschauen",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.MENTAL_CONTRASTING);
      },
    );
  }

  _buildHabitButton() {
    List<bool>? initialValues;
    if (vm.hasLearnedToday) {
      initialValues = [true, false];
    }

    return HabitToggleButtons(
      callback: (newValue) {
        if (newValue) {
          vm.addDaysLearned(1);
          _controllerTopCenter.play();
        }
      },
      initialValues: initialValues,
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
        _buildHabitButton()
      ],
    );
  }

  _buildConfettiTop() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirection: pi / 2,
        maxBlastForce: 5, // set a lower max blast force
        minBlastForce: 2, // set a lower min blast force
        emissionFrequency: 0.1,
        numberOfParticles: 50, // a lot of particles at once
        gravity: 0.9,
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
