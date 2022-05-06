import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/dialogs/reward_dialog.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
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
  late Future initialize = vm.initialize();
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 2));

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => showRewardDialogIfNeeded());
  }

  void showRewardDialogIfNeeded() {
    var rewardNotifications = vm.getPendingRewards();

    if (rewardNotifications.isEmpty) {
      return;
    } else {
      for (var reward in rewardNotifications) {
        // wait two seconds and then show the dialog
        Future.delayed(const Duration(seconds: 1), () {
          showDialog(
            context: context,
            builder: (context) => RewardDialog(score: reward),
          );
        });
      }
      vm.clearPendingRewards();
    }
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
                      future: initialize,
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
                  UIHelper.verticalSpaceMedium(),
                  _buildHabitButton(),
                  UIHelper.verticalSpaceMedium(),
                  _buildStatistics(),
                  UIHelper.verticalSpaceMedium(),
                  // Spacer(),
                  ..._getTasks(),
                  UIHelper.verticalSpaceSmall()
                ],
              ),
              alignment: Alignment(0.0, 0.6)),
          _buildConfettiTop(),
          // SizedBox(
          //     width: double.infinity,
          //     height: double.infinity,
          //     child: EmojiRain(numberOfItems: 5)),
        ]));
  }

  _getTasks() {
    List<Widget> tasks = [];

    if (vm.openTasks.contains(OpenTasks.ViewDistributedLearning)) {
      tasks.add(_buildToDistributedLearningButton());
      tasks.add(UIHelper.verticalSpaceSmall());
    } else if (vm.openTasks.contains(OpenTasks.ViewMentalContrasting)) {
      tasks.add(_buildToMentalContrasting());
      tasks.add(UIHelper.verticalSpaceSmall());
    }

    return tasks;
  }

  _buildTaskButton({text, required GestureTapCallback onPressed}) {
    return SizedBox(
        width: double.infinity,
        height: 40,
        child: Stack(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(400, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
              child: Text("$text", style: TextStyle(fontSize: 20)),
            ),
            // Positioned(
            //     right: -10,
            //     bottom: 0,
            //     child: Text("💎", style: TextStyle(fontSize: 20)))
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
      text: "💎 Dein nächster Lerntrick 💎",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.DISTRIBUTED_LEARNING);
      },
    );
  }

  _buildToMentalContrasting() {
    return _buildTaskButton(
      text: "💎 Dein nächster Lerntrick 💎",
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.MENTAL_CONTRASTING);
      },
    );
  }

  _buildToLearningTip() {
    return _buildTaskButton(
      text: "💎 Dein nächster Lerntrick 💎",
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
        if (!vm.hasLearnedToday) {
          vm.addDaysLearned(1);
          showDialogIfNecessary();
          if (newValue) {
            _controllerTopCenter.play();
          }
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
    var msg = "";
    if (vm.daysLearned == 0) {
      msg = "Du hast bisher noch keine Lerntage eingetragen.";
    } else if (vm.daysLearned == 1) {
      msg =
          "Du hast in den letzten sieben Tagen an ${vm.daysLearned} Tag Vokabeln gelernt";
    } else {
      msg =
          "Du hast in den letzten Tagen an ${vm.daysLearned} Tagen Vokabeln gelernt";
    }

    return Text(
      msg,
      style: TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );
    // SizedBox(
    //     width: double.infinity,
    //     child: Center(child: Markdown(data: "## $msg"))),
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
