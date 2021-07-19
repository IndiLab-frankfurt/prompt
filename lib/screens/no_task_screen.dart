import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';

class NoTasksScreen extends StatefulWidget {
  const NoTasksScreen({Key? key}) : super(key: key);

  @override
  _NoTasksScreenState createState() => _NoTasksScreenState();
}

class _NoTasksScreenState extends State<NoTasksScreen>
    with WidgetsBindingObserver {
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
          // floatingActionButton: _buildAboutButton(),
          backgroundColor: Colors.transparent,
          appBar: PromptAppBar(showBackButton: true),
          drawer: _getDrawer(),
          body: FutureBuilder(
              future: Future.delayed(Duration.zero),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      child: Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              UIHelper.verticalSpaceMedium(),
                              // Text(_textNotification,
                              //     textAlign: TextAlign.center,
                              //     style: Theme.of(context).textTheme.headline6),
                              // UIHelper.verticalSpaceMedium(),
                              // Text(_textNextTask,
                              //     textAlign: TextAlign.center,
                              //     style: Theme.of(context).textTheme.headline6),
                              UIHelper.verticalSpaceMedium(),
                              if (_showNextButton) _buildToRecallTaskButton(),
                              UIHelper.verticalSpaceMedium(),
                              _buildChangeBackgroundButton()
                            ],
                          ),
                          alignment: Alignment(0.0, 0.6)));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
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
                  "Hintergrund ändern",
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
