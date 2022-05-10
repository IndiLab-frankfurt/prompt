import 'package:flutter/material.dart';
import 'package:prompt/data/questions.dart';
import 'package:prompt/screens/assessments/multi_step_assessment.dart';
import 'package:prompt/screens/assessments/multi_step_questionnaire_future.dart';
import 'package:prompt/screens/assessments/questionnaire_page.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_reminder_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class PlanReminderScreens extends StatefulWidget {
  PlanReminderScreens({Key? key}) : super(key: key);

  @override
  _PlanReminderScreensState createState() => _PlanReminderScreensState();
}

class _PlanReminderScreensState extends State<PlanReminderScreens> {
  List<Widget> _pages = [];

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late PlanReminderViewModel vm = Provider.of<PlanReminderViewModel>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];
    for (var screen in vm.screenOrder) {
      _pages.add(getScreen(screen));
    }
  }

  init() async {
    return this._memoizer.runOnce(() async {
      await vm.getInitialValues();
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: UIHelper.defaultBoxDecoration,
          child: Scaffold(
              appBar: PromptAppBar(showBackButton: true),
              drawer: PromptDrawer(),
              body: SafeArea(
                child: FutureBuilder(
                  future: init(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          margin: UIHelper.containerMargin,
                          child: MultiStepAssessment(
                            vm,
                            _pages,
                          ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
        ));
  }

  Widget getScreen(Enum step) {
    var key = ValueKey(step);

    var reminderStep = step as PlanReminderStep;
    switch (reminderStep) {
      case PlanReminderStep.planInternalisationEmoji:
        return ChangeNotifierProvider.value(
            value: vm.internalisationViewModel,
            key: key,
            child: EmojiInternalisationScreen(
                onCompleted: vm.onInternalisationCompleted,
                emojiInputIf: true,
                emojiInputThen: true,
                key: ValueKey(PlanReminderStep.planInternalisationEmoji)));

      case PlanReminderStep.usabilityQuestions:
        return MultiStepQuestionnairePage(
          key: key,
          vm: vm,
          questionnaire: usabilityQuestions,
        );

      case PlanReminderStep.efficacyQuestions:
        return MultiStepQuestionnairePage(
          key: key,
          vm: vm,
          questionnaire: promptEfficacyQuestions,
        );
    }
  }
}
