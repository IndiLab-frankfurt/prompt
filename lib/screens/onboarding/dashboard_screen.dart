import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/widgets/dashboard_button.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        vm.getNextTask();
      });
    }
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
            UIHelper.verticalSpaceMedium,
            MarkdownBody(data: _textStreak),
            UIHelper.verticalSpaceMedium,
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
                drawer: PromptDrawer(),
                body: FutureBuilder(
                  future: vm.getNextTask(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UIHelper.verticalSpaceSmall,
                                  if (vm.showVocabularyTestReminder)
                                    _buildVocabTestReminder(),
                                  if (vm.startTomorrow) _buildStartTomorrow(),
                                  UIHelper.verticalSpaceSmall,
                                  UIHelper.verticalSpaceMedium,
                                  _buildStatistics()
                                ],
                              ),
                              alignment: Alignment(0.0, 0.6)));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ))));
  }

  _buildStatistics() {
    var nextVocab = vm.daysUntilVocabTestString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.verticalSpaceMedium,
        Text(AppStrings.daysOfTotal(vm.daysActive, vm.getMaxStudyDays())),
        UIHelper.verticalSpaceSmall,
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            minHeight: 12,
            value: vm.studyProgress,
          ),
        ),
        UIHelper.verticalSpaceLarge,
        Text(
          nextVocab,
          textAlign: TextAlign.center,
        ),
        UIHelper.verticalSpaceMedium,
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            minHeight: 12,
            value: vm.getVocabProgress(),
          ),
        )
      ],
    );
  }

  _buildVocabTestReminder() {
    return DashboardButton(
        onPressed: () async {
          setState(() {});
        },
        text: AppStrings.Dashboard_ClickAfterVocabTest);
  }

  _buildStartTomorrow() {
    return DashboardButton(text: S.current.dashboard_mainmessage_firstday);
  }
}
