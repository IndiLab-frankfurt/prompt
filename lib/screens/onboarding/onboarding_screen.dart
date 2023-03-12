import 'package:flutter/material.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/screens/internalisation/emoji_internalisation_screen.dart';
import 'package:prompt/screens/onboarding/copingplan_enter_screen.dart';
import 'package:prompt/screens/onboarding/data_privavy_consent_screen.dart';
import 'package:prompt/screens/onboarding/horizontal_questionnaire.dart';
import 'package:prompt/screens/onboarding/instructions_cabuu_2.dart';
import 'package:prompt/screens/onboarding/instructions_distributed_learning.dart';
import 'package:prompt/screens/onboarding/instructions_implementation_intentions.dart';
import 'package:prompt/screens/onboarding/obstacle_enter_screen.dart';
import 'package:prompt/screens/onboarding/outcome_enter_screen.dart';
import 'package:prompt/screens/onboarding/first_plan_creation_screen.dart';
import 'package:prompt/screens/onboarding/onboarding_plan_timing_screen.dart';
import 'package:prompt/screens/onboarding/reward_screen_1.dart';
import 'package:prompt/screens/onboarding/welcome_screen.dart';
import 'package:prompt/viewmodels/completable_page.dart';
import 'package:prompt/viewmodels/data_privacy_consent_view_model.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:prompt/viewmodels/questionnaire_video_page_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:prompt/screens/main/video_screen.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  late OnboardingViewModel vm = Provider.of<OnboardingViewModel>(context);

  init() async {
    return this._memoizer.runOnce(() async {
      await vm.getInitialValues();

      List<Widget> _pages = [];

      for (var screen in vm.pages) {
        _pages.add(getScreen(screen));
      }

      return _pages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).dialogBackgroundColor,
                Theme.of(context).primaryColorLight
              ])),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PromptAppBar(
                showBackButton: true,
                title: vm.pages[vm.page].name,
              ),
              drawer: PromptDrawer(),
              resizeToAvoidBottomInset: false,
              body: FutureBuilder(
                future: init(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        color: Colors.transparent,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 20, bottom: 15),
                        child: MultiPageScreen(
                          vm,
                          snapshot.data,
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
        ));
  }

  Widget getScreen(CompletablePageMixin step) {
    var key = ValueKey(step);

    Widget page =
        Container(child: Center(child: Text("Missing Page ${step.name}")));

    if (step.name == OnboardingStep.welcome.name) {
      page = WelcomeScreen(key: key);
    }

    if (step is DataPrivacyConsentViewModel) {
      return ChangeNotifierProvider.value(
        value: step,
        key: key,
        child: DataPrivacyConsentScreen(key: key),
      );
    }

    if (step.name == OnboardingStep.rewardScreen1.name) {
      page = RewardScreen1(key: key);
    }

    if (step is QuestionnaireVideoPageViewModel) {
      page = VideoScreen(
        step.videoUrl,
        onVideoCompleted: step.onVideoCompleted,
        key: key,
      );
    }

    if (step.name == OnboardingStep.outcome.name) {
      return OutcomeEnterScreen(key: key);
    }

    if (step.name == OnboardingStep.obstacle.name) {
      return ObstacleEnterScreen(key: key);
    }

    if (step.name == OnboardingStep.copingPlan.name) {
      return CopingPlanEnterScreen(key: key);
    }

    if (step.name ==
        OnboardingStep.instructions_implementationIntentions.name) {
      return InstructionsImplementationIntentions(key: key);
    }

    if (step.name == OnboardingStep.planCreation.name) {
      return FirstPlanCreationScreen(key: key);
    }

    if (step.name == OnboardingStep.planInternalisationEmoji.name) {
      return ChangeNotifierProvider.value(
        value: step,
        key: key,
        child: EmojiInternalisationScreen(
            vm: vm.internalisationViewmodelEmoji, key: key),
      );
    }

    if (step is MultiPageQuestionnaireViewModel) {
      return ChangeNotifierProvider.value(
        value: step,
        key: key,
        child: HorizontalQuestionnaire(),
      );
    }

    if (step.name == OnboardingStep.instructions_distributedLearning.name) {
      return InstructionsDistributedLearning(key: key);
    }

    if (step.name == OnboardingStep.planTiming.name) {
      return OnboardingPlanTimingScreen(key: key);
    }

    if (step.name == OnboardingStep.instructions_cabuu_2.name) {
      return InstructionsCabuu2(key: key);
    }

    return page;
    // return ChangeNotifierProvider.value(
    //   value: step,
    //   key: key,
    //   child: page,
    //   // builder: (context, child) => page,
    // );
    // return ChangeNotifierProvider.value(
    //   value: step,
    //   key: key,
    //   builder: (context, child) => page,
    // );
  }
}
