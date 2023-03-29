import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
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
  bool _hasCheckedTasks = false;

  @override
  void initState() {
    super.initState();

    _hasCheckedTasks = false;

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && !_hasCheckedTasks) {
      _hasCheckedTasks = true;
      DashboardViewModel vm =
          Provider.of<DashboardViewModel>(context, listen: false);
      await vm.checkTasks();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _hasCheckedTasks = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    DashboardViewModel vm = Provider.of<DashboardViewModel>(context);
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
                  future: vm.getButtonText(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  UIHelper.verticalSpaceSmall,
                                  _buildMainText(snapshot.data.toString(), vm),
                                  UIHelper.verticalSpaceMedium,
                                  _buildStatistics(vm)
                                ],
                              ),
                              alignment: Alignment(0.0, 0.6)));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ))));
  }

  _buildStatistics(DashboardViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UIHelper.verticalSpaceMedium,
        if (vm.isInStudyPhase()) studyProgress(vm),
        UIHelper.verticalSpaceLarge,
        vocabTestProgress(vm)
      ],
    );
  }

  Widget studyProgress(DashboardViewModel vm) {
    return Column(
      children: [
        Text(S.current
            .dashboard_daysOfTotal(vm.daysActive, vm.getMaxStudyDays())),
        UIHelper.verticalSpaceSmall,
        SizedBox(
          width: 300,
          child: LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColorLight,
            minHeight: 12,
            value: vm.studyProgress,
          ),
        )
      ],
    );
  }

  Widget vocabTestProgress(DashboardViewModel vm) {
    return Column(
      children: [
        Text(
          vm.daysUntilVocabTestString(),
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

  _buildMainText(String text, DashboardViewModel vm) {
    return DashboardButton(
        onPressed: () async {
          vm.checkTasks();
        },
        text: text);
  }
}
